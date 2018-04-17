
package com.dz.kaiying.service;

import com.dz.kaiying.model.KyAccident;
import com.dz.kaiying.model.KyYiJue;
import com.dz.kaiying.repository.hiber.HibernateDao;
import com.dz.kaiying.util.ExportExcelUtil;
import com.dz.kaiying.util.ImportExcelUtil;
import com.dz.kaiying.util.Result;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by huang on 2017/7/20.
 */
//todo
@Service
public class SgService {
    @Resource
    HibernateDao<KyAccident, Integer> bxDao;  //事故dao

    @Resource
    HibernateDao<KyYiJue, Integer> yjDao;  //已决dao
    private Result result = new Result();
    //Map<Integer,KyAccident> sgMap = new HashMap<>();
    List<KyAccident> sgList =null;
    /**
     * /事故查询
     * @return
     */
    public Result querysg(HttpServletRequest request, Map<String ,String> mapSG) {

        String selectedTime = request.getParameter("selectedTime");
        String year = "";
        String month = "";
        String sql ="from KyAccident ";
        if(mapSG.size()>0){
            if(!StringUtils.isEmpty(mapSG.get("cph"))){
                sql += "where cph = '"+mapSG.get("cph")+"'";
                sql = getSQLConditions(mapSG.get("cxStartTime"),mapSG.get("cxEndTime"), sql," and cxrq");
                sql = getSQLConditions(mapSG.get("startCreateDateTime"),mapSG.get("endCreateDateTime"), sql," and createDate");
            }else {  //cph为空
                if(!StringUtils.isEmpty(mapSG.get("cxStartTime"))&&!StringUtils.isEmpty(mapSG.get("cxEndTime"))){
                    sql += " where cxrq BETWEEN '"+mapSG.get("cxStartTime")+"' and '"+mapSG.get("cxEndTime")+"'";
                    sql = getSQLConditions(mapSG.get("startCreateDateTime"),mapSG.get("endCreateDateTime"), sql," and createDate");
                }else {  //cph为空，出险时间为空
                    sql = getSQLConditions(mapSG.get("startCreateDateTime"),mapSG.get("endCreateDateTime"), sql," where createDate");
                }
            }
        }else {
            if (!StringUtils.isEmpty(selectedTime)) {
                sql = getMonthTime(selectedTime, year, month, sql);//按照出险日期查询整月信息
            }
        }
        List<KyAccident> accident = bxDao.find(sql);//事故查询
        if(accident.size()>0){
            sgList =new ArrayList<>(accident);
            /*sgMap.clear();
            for (int i = 1; i <= accident.size(); i++) {    //存入缓存
                sgMap.put(i, accident.get(i - 1));
            }*/
        }
        result.setSuccess("查询成功", accident);
        return result;
    }

    /**
     * sg列表下载
     */
    public void sgExportExcl(HttpServletResponse rep)throws Exception{
        if (sgList.size()==0)return;   //如果为空无法下载
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet = wb.createSheet();
        HSSFCellStyle style = getHssfCellStyle(wb);   //设置字体格式
        Row row = sheet.createRow((short) 0);
        generateExcelTitle(style, row);
        int v =1;
        for (KyAccident ka:sgList) {
            Field[] fields = ka.getClass().getDeclaredFields();
            Row row1 = sheet.createRow(v);
            for (int i = 0; i < fields.length; i++)
            {
                String name = fields[i].getName();
                String type = fields[i].getGenericType().toString();
                fields[i].setAccessible(true);
                name = name.replaceFirst(name.substring(0, 1), name.substring(0, 1)
                        .toUpperCase());
                // 如果type是类类型，则前面包含"class "，后面跟类名
                Method m = ka.getClass().getMethod("get" + name);
                if (type.equals("class java.lang.String"))
                {
                    // 调用getter方法获取属性值
                    String value = (String) m.invoke(ka);
                    if (value != null)
                    {
                        row1.createCell(i).setCellValue(value);
                        sheet.autoSizeColumn(i,true);
                    }
                }
                if (type.equals("class java.lang.Integer"))
                {
                    // 调用getter方法获取属性值
                    Integer value = (Integer) m.invoke(ka);
                    if (value != null)
                    {
                        row1.createCell(i).setCellValue(value);
                        sheet.autoSizeColumn(i,true);
                    }
                }
                fields[i].setAccessible(false);
                }
            v++;
        }
        EmpExportService export=new EmpExportService();
        export.IOWriteExcel(rep,wb,"事故列表.xls");
    }

    private void generateExcelTitle(HSSFCellStyle style, Row row) {
        Cell cel0=row.createCell(0);
        cel0.setCellStyle(style);
        cel0.setCellValue("序号");

        Cell cel1=row.createCell(1);
        cel1.setCellStyle(style);
        cel1.setCellValue("事故处理部门");

        Cell cel2=row.createCell(2);
        cel2.setCellStyle(style);
        cel2.setCellValue("报案日期");

        Cell cel3=row.createCell(3);
        cel3.setCellStyle(style);
        cel3.setCellValue("报案时间");

        Cell cel4=row.createCell(4);
        cel4.setCellStyle(style);
        cel4.setCellValue("结案时间");
        ;
        Cell cel5=row.createCell(5);
        cel5.setCellStyle(style);
        cel5.setCellValue("通赔标志");

        Cell cel6=row.createCell(6);
        cel6.setCellStyle(style);
        cel6.setCellValue("业务来源");

        Cell cel7=row.createCell(7);
        cel7.setCellStyle(style);
        cel7.setCellValue("保单号");

        Cell cel8=row.createCell(8);
        cel8.setCellStyle(style);
        cel8.setCellValue("保单归属机构");

        Cell cel9=row.createCell(9);
        cel9.setCellStyle(style);
        cel9.setCellValue("启保日期");

        Cell cel10=row.createCell(10);
        cel10.setCellStyle(style);
        cel10.setCellValue("终保日期");

        Cell cel11=row.createCell(11);
        cel11.setCellStyle(style);
        cel11.setCellValue("初登日期");

        Cell cel12=row.createCell(12);
        cel12.setCellStyle(style);
        cel12.setCellValue("条款");

        Cell cel13=row.createCell(13);
        cel13.setCellStyle(style);
        cel13.setCellValue("保费");

        Cell cel14=row.createCell(14);
        cel14.setCellStyle(style);
        cel14.setCellValue("报案号");
        ;
        Cell cel15=row.createCell(15);
        cel15.setCellStyle(style);
        cel15.setCellValue("立案号");

        Cell cel16=row.createCell(16);
        cel16.setCellStyle(style);
        cel16.setCellValue("案件性质");

        Cell cel17=row.createCell(17);
        cel17.setCellStyle(style);
        cel17.setCellValue("出险日期");

        Cell cel18=row.createCell(18);
        cel18.setCellStyle(style);
        cel18.setCellValue("事故处理方式");

        Cell cel19=row.createCell(19);
        cel19.setCellStyle(style);
        cel19.setCellValue("立案日期");

        Cell cel20=row.createCell(20);
        cel20.setCellStyle(style);
        cel20.setCellValue("结案日期");

        Cell cel21=row.createCell(21);
        cel21.setCellStyle(style);
        cel21.setCellValue("估损金额");

        Cell cel22=row.createCell(22);
        cel2.setCellStyle(style);
        cel2.setCellValue("估计赔偿");

        Cell cel23=row.createCell(23);
        cel23.setCellStyle(style);
        cel23.setCellValue("赔付金额");

        Cell cel24=row.createCell(24);
        cel24.setCellStyle(style);
        cel24.setCellValue("报案人");
        ;
        Cell cel25=row.createCell(25);
        cel25.setCellStyle(style);
        cel25.setCellValue("报案人电话");

        Cell cel26=row.createCell(26);
        cel26.setCellStyle(style);
        cel26.setCellValue("查勘员1");

        Cell cel27=row.createCell(27);
        cel27.setCellStyle(style);
        cel27.setCellValue("勘察员2");

        Cell cel28=row.createCell(28);
        cel28.setCellStyle(style);
        cel28.setCellValue("处理人代码");

        Cell cel29=row.createCell(29);
        cel29.setCellStyle(style);
        cel29.setCellValue("保单经办人");

        Cell cel30=row.createCell(30);
        cel30.setCellStyle(style);
        cel30.setCellValue("保单归属人");

        Cell cel31=row.createCell(31);
        cel31.setCellStyle(style);
        cel31.setCellValue("出险地址");

        Cell cel32=row.createCell(32);
        cel32.setCellStyle(style);
        cel32.setCellValue("出险原因");

        Cell cel33=row.createCell(33);
        cel33.setCellStyle(style);
        cel33.setCellValue("驾驶人");

        Cell cel34=row.createCell(34);
        cel34.setCellStyle(style);
        cel34.setCellValue("驾驶证");
        ;
        Cell cel35=row.createCell(35);
        cel35.setCellStyle(style);
        cel35.setCellValue("厂牌型号");

        Cell cel36=row.createCell(36);
        cel36.setCellStyle(style);
        cel36.setCellValue("车牌号");

        Cell cel37=row.createCell(37);
        cel37.setCellStyle(style);
        cel37.setCellValue("被保险人");

        Cell cel38=row.createCell(38);
        cel38.setCellStyle(style);
        cel38.setCellValue("出险经过");

        Cell cel39=row.createCell(39);
        cel39.setCellStyle(style);
        cel39.setCellValue("创建时间");
    }

    private HSSFCellStyle getHssfCellStyle(HSSFWorkbook wb) {
        HSSFFont font =  wb.createFont();
        font.setFontHeightInPoints((short)12);            //设置字体的大小
        font.setFontName("微软雅黑");                        //设置字体的样式，如：宋体、微软雅黑等
        font.setItalic(false);                            //斜体true为斜体
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);    //对文中进行加粗
        font.setColor(HSSFColor.BLACK.index);            //设置字体的颜色
        HSSFCellStyle style = wb.createCellStyle();
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 居中
        style.setFont(font);
        return style;
    }
    /**
     *
     * @param startTime 初始时间
     * @param endTime 最后时间
     * @param sql
     * @param whereOrAnd  条件
     * @return
     */
    private String getSQLConditions(String startTime, String endTime, String sql, String whereOrAnd) {
        if(!StringUtils.isEmpty(startTime)&&!StringUtils.isEmpty(endTime)){
            sql += whereOrAnd+" BETWEEN '"+startTime+"' and '"+endTime+"'";
        }
        return sql;
    }

    //判断是否是闰年闰月
    private String getMonthTime(String selectedTime, String year, String month, String sql) {
        int days = 30;
        if(!StringUtils.isEmpty(selectedTime)){
            String[] str = selectedTime.split("-");
            year = str[0];
            month = str[1];
        }
        if(year != "" && month != ""){
            boolean runnian = (Integer.valueOf(year)%4 == 0) && (Integer.valueOf(year)%100 != 0) || (Integer.valueOf(year)%400 == 0);
            switch(Integer.valueOf(month)){
                case 1:
                case 3:
                case 5:
                case 7:
                case 8:
                case 10:
                case 12:
                    days = 31;
                    break;
                case 4:
                case 6:
                case 9:
                case 11:
                    days = 30;
                    break;
                default:
                    if(runnian)
                        days = 29;
                    else
                        days = 28;
            }
            sql += " where cxrq BETWEEN '" + selectedTime + "-1' and '" + selectedTime + "-" + days+"'";
        }
        return sql;
    }

    public Result exportExcel(HttpServletRequest request, HttpServletResponse response) throws IOException {
        OutputStream os = null;
        Workbook wb = null;    //工作薄

        try {
            //数据库取值
            List<KyAccident> accident = bxDao.find("from KyAccident");

            //导出Excel文件数据
            ExportExcelUtil util = new ExportExcelUtil();
            File file = util.getExcelDemoFile("classes/ExcelDemo/事故模板.xlsx");
            String sheetName = "sheet1";
            wb = writeNewExcel(file, sheetName, accident);

            String fileName = "事故信息导出.xlsx";
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition", "attachment;filename=" + URLEncoder.encode(fileName, "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            os.flush();
            os.close();
            wb.close();
        }

        result.setSuccess("导出成功", null);
        return result;
    }


    public Workbook writeNewExcel(File file, String sheetName, List<KyAccident> lis) throws Exception {
        Workbook wb = null;
        Row row = null;
        Cell cell = null;

        FileInputStream fis = new FileInputStream(file);
        wb = new ImportExcelUtil().getWorkbook(fis, file.getName());    //获取工作薄
        Sheet sheet = wb.getSheet(sheetName);

        //循环插入数据
        int lastRow = sheet.getLastRowNum() - 2;    //插入数据的数据ROW
        CellStyle cs = setSimpleCellStyle(wb);    //Excel单元格样式
        for (int i = 0; i < lis.size(); i++) {
            row = sheet.createRow(lastRow + i); //创建新的ROW，用于数据插入

            //按项目实际需求，在该处将对象数据插入到Excel中
            KyAccident vo = lis.get(i);
            if (null == vo) {
                break;
            }
            //Cell赋值开始
            cell = row.createCell(0);
            cell.setCellValue(i);
            cell.setCellStyle(cs);

            cell = row.createCell(1);
            cell.setCellValue(vo.getBasj());
            cell.setCellStyle(cs);

            cell = row.createCell(2);
            cell.setCellValue(vo.getJasj());
            cell.setCellStyle(cs);

            cell = row.createCell(3);
            cell.setCellValue(vo.getBdh());
            cell.setCellStyle(cs);

            cell = row.createCell(4);
            cell.setCellValue(vo.getCdrq());
            cell.setCellStyle(cs);

            cell = row.createCell(5);
            cell.setCellValue(vo.getLah());
            cell.setCellStyle(cs);

            cell = row.createCell(6);
            cell.setCellValue(vo.getAjxz());
            cell.setCellStyle(cs);

            cell = row.createCell(7);
            cell.setCellValue(vo.getCxrq());
            cell.setCellStyle(cs);

            cell = row.createCell(8);
            cell.setCellValue(vo.getSgclfs());
            cell.setCellStyle(cs);

            cell = row.createCell(9);
            cell.setCellValue(vo.getGsje());
            cell.setCellStyle(cs);

            cell = row.createCell(10);
            cell.setCellValue(vo.getGjpk());
            cell.setCellStyle(cs);

            cell = row.createCell(11);
            cell.setCellValue(vo.getPfje());
            cell.setCellStyle(cs);

            cell = row.createCell(12);
            cell.setCellValue(vo.getBar());
            cell.setCellStyle(cs);

            cell = row.createCell(13);
            cell.setCellValue(vo.getBardh());
            cell.setCellStyle(cs);

            cell = row.createCell(14);
            cell.setCellValue(vo.getCky());
            cell.setCellStyle(cs);

            cell = row.createCell(15);
            cell.setCellValue(vo.getCxdz());
            cell.setCellStyle(cs);

            cell = row.createCell(16);
            cell.setCellValue(vo.getCxyy());
            cell.setCellStyle(cs);

            cell = row.createCell(17);
            cell.setCellValue(vo.getJsr());
            cell.setCellStyle(cs);

            cell = row.createCell(18);
            cell.setCellValue(vo.getJsz());
            cell.setCellStyle(cs);

            cell = row.createCell(19);
            cell.setCellValue(vo.getCpxh());
            cell.setCellStyle(cs);

            cell = row.createCell(20);
            cell.setCellValue(vo.getCph());
            cell.setCellStyle(cs);

            cell = row.createCell(21);
            cell.setCellValue(vo.getCxjg());
            cell.setCellStyle(cs);
        }
        return wb;
    }


    /**
     * 描述：设置简单的Cell样式
     *
     * @return
     */
    public CellStyle setSimpleCellStyle(Workbook wb) {
        CellStyle cs = wb.createCellStyle();

        cs.setBorderBottom(CellStyle.BORDER_THIN); //下边框
        cs.setBorderLeft(CellStyle.BORDER_THIN);//左边框
        cs.setBorderTop(CellStyle.BORDER_THIN);//上边框
        cs.setBorderRight(CellStyle.BORDER_THIN);//右边框
        cs.setAlignment(CellStyle.ALIGN_CENTER); // 居中

        return cs;
    }


    /**
     * 将 出险 和  已决 excel写入系统
     *
     * @param request
     * @return
     * @throws Exception
     */
    public String importExcel(HttpServletRequest request) throws Exception {
        CommonsMultipartResolver commonsMultipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
        commonsMultipartResolver.setDefaultEncoding("utf-8");
        MultipartHttpServletRequest multipartRequest = commonsMultipartResolver.resolveMultipart(request);
        System.out.println("通过传统方式form表单提交方式导入excel文件！");
        InputStream in = null;
        MultipartFile file = multipartRequest.getFile("upfile");
        if (file.isEmpty()) {
            throw new Exception("文件不存在！");
        }
        in = file.getInputStream();
        List<List<Object>>[] sheets = new ImportExcelUtil().getBankListByExcelDivideBySheet(in, file.getOriginalFilename());
        in.close();

        List<List<Object>> yijue = sheets[0];
        List<List<Object>> chuxian = sheets[1];
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        //该处可调用service相应方法进行数据保存到数据库中，现只对数据输出
        for (int i = 0; i < chuxian.size(); i++) {
            List<Object> lo = chuxian.get(i);
            KyAccident accident = new KyAccident();
            accident.setBarq(String.valueOf(lo.get(0))); //报案日期
            accident.setJasj(String.valueOf(lo.get(1))); //结案时间
            accident.setTpbz(String.valueOf(lo.get(2))); //通赔标志
            accident.setYwly(String.valueOf(lo.get(3))); //业务来源
            accident.setBdh(String.valueOf(lo.get(4))); //保单号
            accident.setBdgsjg(String.valueOf(lo.get(5))); //保单归属机构
            accident.setQbrq(String.valueOf(lo.get(6))); //起保日期
            accident.setZbrq(String.valueOf(lo.get(7))); //终保日期
            accident.setCdrq(String.valueOf(lo.get(8))); //初等日期
            accident.setTk(String.valueOf(lo.get(9))); //条款
            accident.setBf(String.valueOf(lo.get(10)));//保费
            accident.setBah(String.valueOf(lo.get(11)));//报案号
            accident.setLah(String.valueOf(lo.get(12))); //立案号
            accident.setAjxz(String.valueOf(lo.get(13))); //案件性质
            accident.setCxrq(String.valueOf(lo.get(14)));//出险日期
            accident.setLarq(String.valueOf(lo.get(15)));//立案日期
            accident.setJarq(String.valueOf(lo.get(16)));//结案日期
            accident.setGsje(String.valueOf(lo.get(17)));//估损金额
            accident.setGjpk(String.valueOf(lo.get(18)));//估计赔款
            accident.setPfje(String.valueOf(lo.get(19)));//赔付金额
            accident.setBar(String.valueOf(lo.get(20))); //报案人
            accident.setBardh(String.valueOf(lo.get(21)));//报案人电话
            accident.setCky(String.valueOf(lo.get(22)));//查勘员1
            accident.setGsje(String.valueOf(lo.get(23)));//查勘员2
            accident.setClrdm(String.valueOf(lo.get(24)));//处理人代码
            accident.setBdjbr(String.valueOf(lo.get(25)));//保单经办人代码
            accident.setBdgsr(String.valueOf(lo.get(26)));//保单归属人代码
            accident.setCxdz(String.valueOf(lo.get(27)));//出险地址
            accident.setCxyy(String.valueOf(lo.get(28)));//出险原因
            accident.setJsr(String.valueOf(lo.get(29))); //驾驶人
            accident.setJsz(String.valueOf(lo.get(30)));//驾驶证
            accident.setCpxh(String.valueOf(lo.get(31)));//厂牌型号
            accident.setCph(String.valueOf(lo.get(32)));//车牌号
            accident.setBbxr(String.valueOf(lo.get(33)));//被保险人
            accident.setCxjg(String.valueOf(lo.get(34))); //出险经过
            accident.setCreateDate(sdf.format(new Date()));
            bxDao.save(accident);
           // System.out.println("打印信息1--> "+accident.toString());
        }

        for (int i = 0; i < yijue.size(); i++) {
            List<Object> lo = yijue.get(i);
            KyYiJue yj = new KyYiJue();
            yj.setPdh(String.valueOf(lo.get(0))); //赔单号
            yj.setXzdm(String.valueOf(lo.get(1))); //险种代码
            yj.setBdgsjg(String.valueOf(lo.get(2)));//保单归属机构
            yj.setTkdm(String.valueOf(lo.get(3)));
            yj.setJssh(String.valueOf(lo.get(4)));
            yj.setLah(String.valueOf(lo.get(5)));
            yj.setBah(String.valueOf(lo.get(6))); //报案号
            yj.setBarq(String.valueOf(lo.get(7)));//报案日期
            yj.setBdh(String.valueOf(lo.get(8)));//保单号
            yj.setQbrq(String.valueOf(lo.get(9)));//起报日期
            yj.setZbrq(String.valueOf(lo.get(10)));//终保日期
            yj.setBe(String.valueOf(lo.get(11)));//保额
            yj.setBf(String.valueOf(lo.get(12)));//保费
            yj.setXcgzj(String.valueOf(lo.get(13)));//新车购置
            yj.setPalb(String.valueOf(lo.get(14)));//陪案类别
            yj.setCxyy(String.valueOf(lo.get(15)));
            yj.setSglx(String.valueOf(lo.get(16)));
            yj.setHprq(String.valueOf(lo.get(17)));//核赔日期
            yj.setHpr(String.valueOf(lo.get(18)));//核赔人
            yj.setLsrdm(String.valueOf(lo.get(19)));
            yj.setLsr(String.valueOf(lo.get(20))); //理算人
            yj.setCxrq(String.valueOf(lo.get(21)));
            yj.setLarq(String.valueOf(lo.get(22))); //立案日期
            yj.setJarq(String.valueOf(lo.get(23))); //结案日期
            yj.setPfje(String.valueOf(lo.get(24)));
            yj.setCwfkje(String.valueOf(lo.get(25)));
            yj.setBbxr(String.valueOf(lo.get(26))); //被保险人
            yj.setLkrlx(String.valueOf(lo.get(27)));
            yj.setLkr(String.valueOf(lo.get(28)));
            yj.setLkrdh(String.valueOf(lo.get(29)));
            yj.setZjlx(String.valueOf(lo.get(30)));
            yj.setZjhm(String.valueOf(lo.get(31))); //证件号码
            yj.setKhh(String.valueOf(lo.get(32)));//开户行
            yj.setYhdm(String.valueOf(lo.get(33))); //银行代码
            yj.setYhzh(String.valueOf(lo.get(34)));//银行账号
            yj.setQydm(String.valueOf(lo.get(35)));//区域代码
            yj.setGsbz(String.valueOf(lo.get(36)));//公私标志
            yj.setBar(String.valueOf(lo.get(37)));//报案人
            yj.setBardh(String.valueOf(lo.get(38)));//报案电话
            yj.setBdjbr(String.valueOf(lo.get(39)));
            yj.setCxdd(String.valueOf(lo.get(40)));
            yj.setCph(String.valueOf(lo.get(41)));
            yj.setCx(String.valueOf(lo.get(42)));
            yj.setYwly(String.valueOf(lo.get(43)));
            yj.setTpbz(String.valueOf(lo.get(44)));//通赔标志
            yjDao.save(yj);
            System.out.println("打印信息2--> "+yj.toString());
       }
        result.setSuccess("导出成功", null);
        return "sg/accident_list";
    }

    //测试...........................................................................................................
    public static void main(String[] args) throws Exception {

        File file = new File("/Users/zhangyanqi/Desktop/事故.xls");
        FileInputStream in = new FileInputStream(file);
        List<List<Object>>[] sheets = new ImportExcelUtil().getBankListByExcelDivideBySheet(in, "xin.xls");
        in.close();

        List<List<Object>> yijue = sheets[0];
        List<List<Object>> chuxian = sheets[1];

        //该处可调用service相应方法进行数据保存到数据库中，现只对数据输出
        for (int i = 0; i < chuxian.size(); i++) {
            List<Object> lo = chuxian.get(i);
            KyAccident accident = new KyAccident();
            accident.setBarq(String.valueOf(lo.get(0))); //报案日期
            accident.setJasj(String.valueOf(lo.get(1))); //结案时间
            accident.setTpbz(String.valueOf(lo.get(2))); //通赔标志
            accident.setYwly(String.valueOf(lo.get(3))); //业务来源
            accident.setBdh(String.valueOf(lo.get(4))); //保单号
            accident.setBdgsjg(String.valueOf(lo.get(5))); //保单归属机构
            accident.setQbrq(String.valueOf(lo.get(6))); //起保日期
            accident.setZbrq(String.valueOf(lo.get(7))); //终保日期
            accident.setCdrq(String.valueOf(lo.get(8))); //初等日期
            accident.setTk(String.valueOf(lo.get(9))); //条款
            accident.setBf(String.valueOf(lo.get(10)));//保费
            accident.setBah(String.valueOf(lo.get(11)));//报案号
            accident.setLah(String.valueOf(lo.get(12))); //立案号
            accident.setAjxz(String.valueOf(lo.get(13))); //案件性质
            accident.setCxrq(String.valueOf(lo.get(14)));//出险日期
            accident.setLarq(String.valueOf(lo.get(15)));//立案日期
            accident.setJarq(String.valueOf(lo.get(16)));//结案日期
            accident.setGsje(String.valueOf(lo.get(17)));//估损金额
            accident.setGjpk(String.valueOf(lo.get(18)));//估计赔款
            accident.setPfje(String.valueOf(lo.get(19)));//赔付金额
            accident.setBar(String.valueOf(lo.get(20))); //报案人
            accident.setBardh(String.valueOf(lo.get(21)));//报案人电话
            accident.setCky(String.valueOf(lo.get(22)));//查勘员1
            accident.setGsje(String.valueOf(lo.get(23)));//查勘员2
            accident.setClrdm(String.valueOf(lo.get(24)));//处理人代码
            accident.setBdjbr(String.valueOf(lo.get(25)));//保单经办人代码
            accident.setBdgsr(String.valueOf(lo.get(26)));//保单归属人代码
            accident.setCxdz(String.valueOf(lo.get(27)));//出险地址
            accident.setCxyy(String.valueOf(lo.get(28)));//出险原因
            accident.setJsr(String.valueOf(lo.get(29))); //驾驶人
            accident.setJsz(String.valueOf(lo.get(30)));//驾驶证
            accident.setCpxh(String.valueOf(lo.get(31)));//厂牌型号
            accident.setCph(String.valueOf(lo.get(32)));//车牌号
            accident.setBbxr(String.valueOf(lo.get(33)));//被保险人
            accident.setCxjg(String.valueOf(lo.get(34))); //出险经过
           // System.out.println("打印信息1--> ");
        }

        for (int i = 0; i < yijue.size(); i++) {
            List<Object> lo = yijue.get(i);
            KyYiJue yj = new KyYiJue();
            yj.setPdh(String.valueOf(lo.get(0))); //赔单号
            yj.setXzdm(String.valueOf(lo.get(1))); //险种代码
            yj.setBdgsjg(String.valueOf(lo.get(2)));//保单归属机构
            yj.setTkdm(String.valueOf(lo.get(3)));
            yj.setJssh(String.valueOf(lo.get(4)));
            yj.setLah(String.valueOf(lo.get(5)));
            yj.setBah(String.valueOf(lo.get(6))); //报案号
            yj.setBarq(String.valueOf(lo.get(7)));//报案日期
            yj.setBdh(String.valueOf(lo.get(8)));//保单号
            yj.setQbrq(String.valueOf(lo.get(9)));//起报日期
            yj.setZbrq(String.valueOf(lo.get(10)));//终保日期
            yj.setBe(String.valueOf(lo.get(11)));//保额
            yj.setBf(String.valueOf(lo.get(12)));//保费
            yj.setXcgzj(String.valueOf(lo.get(13)));//新车购置
            yj.setPalb(String.valueOf(lo.get(14)));//陪案类别
            yj.setCxyy(String.valueOf(lo.get(15)));
            yj.setSglx(String.valueOf(lo.get(16)));
            yj.setHprq(String.valueOf(lo.get(17)));//核赔日期
            yj.setHpr(String.valueOf(lo.get(18)));//核赔人
            yj.setLsrdm(String.valueOf(lo.get(19)));
            yj.setLsr(String.valueOf(lo.get(20))); //理算人
            yj.setCxrq(String.valueOf(lo.get(21)));
            yj.setLarq(String.valueOf(lo.get(22))); //立案日期
            yj.setJarq(String.valueOf(lo.get(23))); //结案日期
            yj.setPfje(String.valueOf(lo.get(24)));
            yj.setCwfkje(String.valueOf(lo.get(25)));
            yj.setBbxr(String.valueOf(lo.get(26))); //被保险人
            yj.setLkrlx(String.valueOf(lo.get(27)));
            yj.setLkr(String.valueOf(lo.get(28)));
            yj.setLkrdh(String.valueOf(lo.get(29)));
            yj.setZjlx(String.valueOf(lo.get(30)));
            yj.setZjhm(String.valueOf(lo.get(31))); //证件号码
            yj.setKhh(String.valueOf(lo.get(32)));//开户行
            yj.setYhdm(String.valueOf(lo.get(33))); //银行代码
            yj.setYhzh(String.valueOf(lo.get(34)));//银行账号
            yj.setQydm(String.valueOf(lo.get(35)));//区域代码
            yj.setGsbz(String.valueOf(lo.get(36)));//公私标志
            yj.setBar(String.valueOf(lo.get(37)));//报案人
            yj.setBardh(String.valueOf(lo.get(38)));//报案电话
            yj.setBdjbr(String.valueOf(lo.get(39)));
            yj.setCxdd(String.valueOf(lo.get(40)));
            yj.setCph(String.valueOf(lo.get(41)));
            yj.setCx(String.valueOf(lo.get(42)));
            yj.setYwly(String.valueOf(lo.get(43)));
            yj.setTpbz(String.valueOf(lo.get(44)));//通赔标志
           // System.out.println("打印信息2--> ");
        }
    }
}
