package com.dz.module.vehicle;

import com.dz.common.factory.HibernateSessionFactory;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
import javax.mail.search.AndTerm;
import javax.mail.search.FlagTerm;
import javax.mail.search.FromTerm;
import javax.mail.search.SearchTerm;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import java.util.function.Consumer;
import java.util.function.Function;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

@Service
public class MailReceiver {
    public MailReceiverConfig config = new MailReceiverConfig();

    @Autowired
    InsuranceDao insuranceDao;

    public void doReceive(boolean mannal){
        loadConfig();

        if (!mannal && !config.enabled){
            return;
        }

        Date operationTime = new Date();
        StringBuilder worklog = new StringBuilder();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Long logId;

        worklog.append(simpleDateFormat.format(new Date()));
        worklog.append(": 任务开始！\n");

        Session session = HibernateSessionFactory.getSession();
        Query query = session.createSQLQuery("INSERT INTO `insurance_import_log`(`automic`, `op_time`, `worklog`) " +
                "VALUES ( :automic, :op_time, :worklog);");
        query.setShort("automic", (short) (mannal? 0: 1));
        query.setDate("op_time",operationTime);
        query.setString("worklog",worklog.toString());
        query.executeUpdate();
        query = session.createSQLQuery("select max(id) from `insurance_import_log`");
        logId = (Long) query.uniqueResult();
        HibernateSessionFactory.closeSession();

        String basePath = System.getProperty("com.dz.root") +"data/insurance/";

        Properties mailConfig = new Properties();
        mailConfig.setProperty("mail.store.protocol",config.protocol);
        mailConfig.setProperty("mail.pop3.port",""+config.port);
        mailConfig.setProperty("mail.pop3.host",config.host);
        javax.mail.Session mailSession = javax.mail.Session.getInstance(mailConfig);

        Store store = null;
        Folder folder = null;
        try{
            store = mailSession.getStore("pop3");
            store.connect(config.email, config.password);

            folder = store.getFolder("INBOX");
            /* Folder.READ_ONLY：只读权限
             * Folder.READ_WRITE：可读可写（可以修改邮件的状态）
             */
            folder.open(Folder.READ_WRITE); //打开收件箱

            Address sender = new InternetAddress(config.sender);
            Message[] latestMessages = folder.getMessages();

            SearchTerm searchTerm = new FromTerm(sender);
            Flags seenFlag = new Flags(Flags.Flag.SEEN);
            if (!config.readAll){
                FlagTerm unseenFlagTerm = new FlagTerm(seenFlag, false);
                searchTerm = new AndTerm(searchTerm, unseenFlagTerm);
            }

            Message[] messages = folder.search(searchTerm, latestMessages);

            worklog.append(simpleDateFormat.format(new Date()));
            worklog.append(": 共计"+messages.length+"邮件需处理\n");
            updateLog(worklog, logId);

            for (int i = messages.length - 1; i >= 0; i--) {
                MimeMessage msg = (MimeMessage) messages[i];
                visitAttachment(msg, (inputStream, filename) -> {
                    if (filename.endsWith(".zip")){
                        try(ZipInputStream zipInputStream = new ZipInputStream(inputStream)) {
                            ZipEntry entry;

                            while ((entry = zipInputStream.getNextEntry()) != null) {
                                if (!entry.isDirectory()) {
                                    String fileName = entry.getName();
                                    if (fileName.endsWith(".pdf")){
                                        byte[] bytes = readInputStream(zipInputStream);
                                        ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(bytes);

                                        Insurance insurance = InsurancePdfReader.loadPdf(byteArrayInputStream);
                                        if (insurance == null) continue;
                                        insurance.setFilename(fileName);
                                        insuranceDao.addInsurance(insurance, config.override);

                                        byteArrayInputStream.reset();
                                        FileUtils.copyInputStreamToFile(byteArrayInputStream, new File(basePath,fileName));
                                        worklog.append(simpleDateFormat.format(new Date()));
                                        worklog.append(": 已处理："+fileName+"\n");
                                        updateLog(worklog, logId);
                                    }
                                }
                                zipInputStream.closeEntry();
                            }
                        } catch (IOException ignored) { }
                    }
                });
                if (config.updateState) {
                    msg.setFlags(seenFlag, true);
                }
            }
            worklog.append(simpleDateFormat.format(new Date()));
            worklog.append(": 处理完毕！\n");
            updateLog(worklog, logId);
        } catch (MessagingException e) {
            e.printStackTrace();
        } finally {
            try {
                if (folder != null) {
                    folder.close(true);
                }
                if (store != null) {
                    store.close();
                }
            } catch (MessagingException e) {
                e.printStackTrace();
            }
        }
    }

    private void updateLog(StringBuilder worklog, Long logId) {
        Session session;
        Query query;
        session = HibernateSessionFactory.getSession();
        query = session.createSQLQuery("update `insurance_import_log` set worklog=:worklog where id=:id");
        query.setString("worklog",worklog.toString());
        query.setLong("id",logId);
        query.executeUpdate();
    }

    private static byte[] readInputStream(InputStream inputStream) {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        byte[] buffer = new byte[1024];
        int bytesRead;
        try {
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return outputStream.toByteArray();
    }

    @FunctionalInterface
    public interface AttachmentReader{
        void read(InputStream inputStream, String filename);
    }

    /**
     * 保存附件
     * @param part 邮件中多个组合体中的其中一个组合体
     */
    public static void visitAttachment(Part part, AttachmentReader reader) {
        try {
            if (part.isMimeType("multipart/*")) {
                Multipart multipart = (Multipart) part.getContent();    //复杂体邮件
                //复杂体邮件包含多个邮件体
                int partCount = multipart.getCount();
                for (int i = 0; i < partCount; i++) {
                    //获得复杂体邮件中其中一个邮件体
                    BodyPart bodyPart = multipart.getBodyPart(i);
                    //某一个邮件体也有可能是由多个邮件体组成的复杂体
                    String disp = bodyPart.getDisposition();
                    if (disp != null && (disp.equalsIgnoreCase(Part.ATTACHMENT) || disp.equalsIgnoreCase(Part.INLINE))) {
                        InputStream is = bodyPart.getInputStream();
                        reader.read(is,decodeText(bodyPart.getFileName()));
                    } else if (bodyPart.isMimeType("multipart/*")) {
                        visitAttachment(bodyPart,reader);
                    } else {
                        String contentType = bodyPart.getContentType();
                        if (contentType.contains("name") || contentType.contains("application")) {
                            reader.read(bodyPart.getInputStream(), decodeText(bodyPart.getFileName()));
                        }
                    }
                }
            } else if (part.isMimeType("message/rfc822")) {
                visitAttachment((Part) part.getContent(),reader);
            }
        } catch (MessagingException| IOException ignored) { }
    }

    /**
     * 文本解码
     * @param encodeText 解码MimeUtility.encodeText(String text)方法编码后的文本
     * @return 解码后的文本
     * @throws UnsupportedEncodingException
     */
    public static String decodeText(String encodeText) throws UnsupportedEncodingException {
        if (encodeText == null || "".equals(encodeText)) {
            return "";
        } else {
            return MimeUtility.decodeText(encodeText);
        }
    }


    private <T> void loadConfigItem(Query query, String key, Function<String,T> convert, Consumer<T> setter){
        query.setString("key",key);
        String content = (String) query.uniqueResult();
        if (StringUtils.isNotEmpty(content)){
            T value = convert.apply(content);
            setter.accept(value);
        }
    }

    public void loadConfig(){
        Session session = HibernateSessionFactory.getSession();
        Query query = session.createSQLQuery("select `value` from sys_config where `key` = :key ");

        loadConfigItem(query,"mail.enabled",Boolean::valueOf,config::setEnabled);
        loadConfigItem(query,"mail.store.protocol",Function.identity(),config::setProtocol);
        loadConfigItem(query,"mail.pop3.port",Integer::parseInt,config::setPort);
        loadConfigItem(query,"mail.pop3.host",Function.identity(),config::setHost);
        loadConfigItem(query,"mail.email",Function.identity(),config::setEmail);
        loadConfigItem(query,"mail.password",Function.identity(),config::setPassword);
        loadConfigItem(query,"mail.sender",Function.identity(),config::setSender);
        loadConfigItem(query,"strategy.readAll",Boolean::valueOf,config::setReadAll);
        loadConfigItem(query,"strategy.updateState",Boolean::valueOf,config::setUpdateState);
        loadConfigItem(query,"strategy.override",Boolean::valueOf,config::setOverride);

        HibernateSessionFactory.closeSession();
    }

    public static class MailReceiverConfig {
        boolean enabled;
        String protocol = "pop3";
        int port = 110;
        String host = "pop.163.com";
        String email = "hrbdzbx@163.com";
        String password = "CPLTJDLPMUDJTDMH";
        String sender = "epolicy@picc.com.cn";
        boolean readAll = false;
        boolean updateState = true;
        boolean override = true;

        public boolean isEnabled() {
            return enabled;
        }

        public String getProtocol() {
            return protocol;
        }

        public int getPort() {
            return port;
        }

        public String getHost() {
            return host;
        }

        public String getEmail() {
            return email;
        }

        public String getPassword() {
            return password;
        }

        public String getSender() {
            return sender;
        }

        public boolean isReadAll() {
            return readAll;
        }

        public boolean isUpdateState() {
            return updateState;
        }

        public boolean isOverride() {
            return override;
        }

        public void setEnabled(boolean enabled) {
            this.enabled = enabled;
        }

        public void setProtocol(String protocol) {
            this.protocol = protocol;
        }

        public void setPort(int port) {
            this.port = port;
        }

        public void setHost(String host) {
            this.host = host;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public void setPassword(String password) {
            this.password = password;
        }

        public void setReadAll(boolean readAll) {
            this.readAll = readAll;
        }

        public void setUpdateState(boolean updateState) {
            this.updateState = updateState;
        }

        public void setSender(String sender) {
            this.sender = sender;
        }

        public void setOverride(boolean override) {
            this.override = override;
        }
    }

    public void setInsuranceDao(InsuranceDao insuranceDao) {
        this.insuranceDao = insuranceDao;
    }
}
