package com.dz.module.vehicle;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class InsurancePdfReader {
    public static void main(String[] args) throws IOException {
//        File file = new File("D:\\Yu-hsin Wang\\Documents\\WeChat Files\\wxid_ttnhadmdmgn721\\FileStorage\\File\\2023-09\\45N0T交.pdf");
        File file = new File("D:\\Yu-hsin Wang\\Documents\\WeChat Files\\wxid_ttnhadmdmgn721\\FileStorage\\File\\2023-09\\45N0T商.pdf");
        Insurance insurance = loadPdf(new FileInputStream(file));
        System.out.println("insurance = " + insurance);
    }

    public static Insurance loadPdf(InputStream inputStream){
        try (PDDocument document = PDDocument.load(inputStream)){
            // 创建 PDFTextStripper 对象
            PDFTextStripper stripper = new PDFTextStripper();

            // 提取文本
            String text = stripper.getText(document);
            Insurance insurance = new Insurance();

            extractPolicyNumber(text, insurance);
            extractPolicyType(text, insurance);

            if ("机动车交通事故责任强制保险单".equals(insurance.getInsuranceClass())){
                extractVehicleTax(text, insurance);
                extractChassisNumber(text, insurance);
                extractTotalPremium(text, insurance);
                insurance.setInsuranceClass("交强险");
            }
            else if("机动车商业保险保险单".equals(insurance.getInsuranceClass())) {
                extractVIN(text, insurance);
                extractLossInsuranceFee(text, insurance);
                extractThirdPartyInsuranceAmount(text, insurance);
                extractThirdPartyInsuranceFee(text, insurance);
                insurance.setInsuranceClass("商业保险单");
            } else {
              return null;
            }

            extractSignDate(text, insurance);
            extractInsurancePeriod(text, insurance);

            insurance.setInsuranceCompany("中国人民财产保险股份有限公司哈尔滨市分公司");
            insurance.setDriverId("哈尔滨大众交通运输有限责任公司");
            insurance.setPhone("86661212");
            insurance.setEnterpriseID("12759066-9");
            insurance.setAddress("征仪路３１１号－２号");

            insurance.setRegister(0);
            insurance.setRegistTime(new Date());

            return insurance;
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    private static void extractPolicyNumber(String text, Insurance insurance) {
        Pattern pattern = Pattern.compile("保险单号：\\s*(\\w+)");
        Matcher matcher = pattern.matcher(text);
        if (matcher.find()) {
            insurance.setInsuranceNum(matcher.group(1));
        }
    }

    private static void extractChassisNumber(String text, Insurance insurance) {
        Pattern pattern = Pattern.compile("识别代码（车架号）\\s*(\\w+)");
        Matcher matcher = pattern.matcher(text);
        if (matcher.find()) {
            insurance.setCarframeNum(matcher.group(1));
        }
    }

    private static void extractVIN(String text, Insurance insurance) {
        Pattern pattern = Pattern.compile("(\\w{17})/\\w{17}");
        Matcher matcher = pattern.matcher(text);
        if (matcher.find()) {
            insurance.setCarframeNum(matcher.group(1));
        }
    }

    private static void extractPolicyType(String text, Insurance insurance) {
        Pattern pattern = Pattern.compile("机动车(.*?)保险单");
        Matcher matcher = pattern.matcher(text);
        if (matcher.find()) {
            insurance.setInsuranceClass("机动车" + matcher.group(1) + "保险单");
        }
    }

    private static void extractTotalPremium(String text, Insurance insurance) {
        Pattern pattern = Pattern.compile("保险费合计.*?\\（¥：([\\d.,]+)元\\）");
        Matcher matcher = pattern.matcher(text);
        if (matcher.find()) {
            String premiumText = matcher.group(1).replaceAll(",", "");
            insurance.setInsuranceMoney(Double.parseDouble(premiumText));
        }
    }

    private static void extractVehicleTax(String text, Insurance insurance) {
        Pattern pattern = Pattern.compile("当年应缴[\\s|\\S]*?\\（¥：([\\d.,]+)元\\）");
        Matcher matcher = pattern.matcher(text);
        if (matcher.find()) {
            String taxText = matcher.group(1);
            insurance.setTax(Double.parseDouble(taxText));
        }
    }

    private static void extractSignDate(String text, Insurance insurance) {
        Pattern pattern = Pattern.compile("签单日期：(\\d{4}-\\d{2}-\\d{2})");
        Matcher matcher = pattern.matcher(text);
        if (matcher.find()) {
            try {
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                Date signDate = dateFormat.parse(matcher.group(1));
                insurance.setSignDate(signDate);
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
    }

    private static void extractInsurancePeriod(String text, Insurance insurance) {
        Pattern pattern = Pattern.compile("保险期间[\\s\\u00A0]*自.*?(\\d{4})年(\\d{2})月(\\d{2})日(\\d{1,2})时(\\d{1,2})分起至(\\d{4})年(\\d{2})月(\\d{2})日(\\d{1,2})时(\\d{1,2})分止");
        Matcher matcher = pattern.matcher(text);
        if (matcher.find()) {
            int startYear = Integer.parseInt(matcher.group(1));
            int startMonth = Integer.parseInt(matcher.group(2));
            int startDay = Integer.parseInt(matcher.group(3));
            int startHour = Integer.parseInt(matcher.group(4));
            int startMinute = Integer.parseInt(matcher.group(5));

            int endYear = Integer.parseInt(matcher.group(6));
            int endMonth = Integer.parseInt(matcher.group(7));
            int endDay = Integer.parseInt(matcher.group(8));
            int endHour = Integer.parseInt(matcher.group(9));
            int endMinute = Integer.parseInt(matcher.group(10));

            Calendar calendar = Calendar.getInstance();
            calendar.set(startYear, startMonth - 1, startDay, startHour, startMinute, 0);
            Date startDate = calendar.getTime();

            calendar.set(endYear, endMonth - 1, endDay, endHour, endMinute, 0);
            Date endDate = calendar.getTime();

            insurance.setBeginDate(startDate);
            insurance.setEndDate(endDate);
        }
    }

    private static void extractLossInsuranceFee(String text, Insurance insurance) {
        Pattern pattern = Pattern.compile("机动车损失保险\\s*/\\s*\\d+\\.\\d+\\s*(\\d+\\.\\d+)");
        Matcher matcher = pattern.matcher(text);
        if (matcher.find()) {
            Double insuranceMoney = Double.valueOf(matcher.group(1));
            insurance.setInsuranceMoney(insuranceMoney);
        }
    }

    private static void extractThirdPartyInsuranceAmount(String text, Insurance insurance) {
        Pattern pattern = Pattern.compile("机动车第三者责任保险\\s*/\\s*(\\d+\\.\\d+)\\s*\\d+\\.\\d+");
        Matcher matcher = pattern.matcher(text);
        if (matcher.find()) {
            Double thirdPartyLimit = Double.valueOf(matcher.group(1));
            insurance.setThirdPartyLimit(thirdPartyLimit);
        }
    }

    private static void extractThirdPartyInsuranceFee(String text, Insurance insurance) {
        Pattern pattern = Pattern.compile("机动车第三者责任保险\\s*/\\s*\\d+\\.\\d+\\s*(\\d+\\.\\d+)");
        Matcher matcher = pattern.matcher(text);
        if (matcher.find()) {
            Double thirdPartyAmount = Double.valueOf(matcher.group(1));
            insurance.setThirdPartyAmount(thirdPartyAmount);
        }
    }
}
