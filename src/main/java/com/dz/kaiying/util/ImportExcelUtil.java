package com.dz.kaiying.util;

import com.dz.kaiying.model.KyAccident;
import com.dz.kaiying.model.KyYiJue;
import com.dz.kaiying.repository.hiber.HibernateDao;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ImportExcelUtil {
    private final static String excel2003L = ".xls";    //2003- 版本的excel
    private final static String excel2007U = ".xlsx";   //2007+ 版本的excel

    /**
     * 描述：获取IO流中的数据，组装成List<List<Object>>对象
     *
     * @param in,
     * @param fileName
     * @return
     * @throws IOException
     */
    public List<List<Object>> getBankListByExcel(InputStream in, String fileName) throws Exception {
        List<List<Object>> list = null;

        //创建Excel工作薄
        Workbook work = this.getWorkbook(in, fileName);
        if (null == work) {
            throw new Exception("创建Excel工作薄为空！");
        }
        Sheet sheet = null;
        Row row = null;
        Cell cell = null;


        list = new ArrayList<List<Object>>();
        //遍历Excel中所有的sheet
        for (int i = 0; i < work.getNumberOfSheets(); i++) {
            sheet = work.getSheetAt(i);
            if (sheet == null) {
                continue;
            }
            //遍历当前sheet中的所有行
            for (int j = sheet.getFirstRowNum(); j <= sheet.getLastRowNum(); j++) {
                row = sheet.getRow(j);
                if (row == null || row.getFirstCellNum() == j) {
                    continue;
                }
                //遍历所有的列
                List<Object> li = new ArrayList<Object>();
                for (int y = row.getFirstCellNum(); y < row.getLastCellNum(); y++) {
                    cell = row.getCell(y);
                    li.add(this.getCellValue(cell));
                }
                list.add(li);
            }
        }
        work.close();
        return list;
    }

    /**
     * 描述：根据文件后缀，自适应上传文件的版本
     *
     * @param inStr,fileName
     * @return
     * @throws Exception
     */
    public Workbook getWorkbook(InputStream inStr, String fileName) throws Exception {
        Workbook wb = null;
        String fileType = fileName.substring(fileName.lastIndexOf("."));
        if (excel2003L.equals(fileType)) {
            wb = new HSSFWorkbook(inStr);  //2003-
        } else if (excel2007U.equals(fileType)) {
            wb = new XSSFWorkbook(inStr);  //2007+
        } else {
            throw new Exception("解析的文件格式有误！");
        }
        return wb;
    }

    /**
     * 描述：对表格中数值进行格式化
     *
     * @param cell 每个表格
     * @return 表格内容
     */
    public String getCellValue(Cell cell) {
        if (cell == null) {
            return null;
        }
        String value = null;
        DecimalFormat df = new DecimalFormat("0");  //格式化number String字符
        SimpleDateFormat sdf = new SimpleDateFormat("yyy-MM-dd");  //日期格式化
        DecimalFormat df2 = new DecimalFormat("0.00");  //格式化数字

        switch (cell.getCellType()) {
            case Cell.CELL_TYPE_STRING:
                String string = cell.getRichStringCellValue().getString();
                if (string != null) {
                    value = string.trim();
                } else {
                    value = "";
                }
                break;
            case Cell.CELL_TYPE_NUMERIC:
                if ("General".equals(cell.getCellStyle().getDataFormatString())) {
                    String s = df.format(cell.getNumericCellValue()).toString();
                    if (s != null) {
                        value = s.trim();
                    } else {
                        value = "";
                    }
                } else if ("m/d/yy".equals(cell.getCellStyle().getDataFormatString())) {
                    String s2 = sdf.format(cell.getDateCellValue());
                    if (s2 != null) {
                        value = s2.trim().toString();
                    } else {
                        value = "";
                    }
                } else {
                    String s3 = df2.format(cell.getNumericCellValue());
                    if (s3 != null) {
                        value = s3.trim().toString();
                    } else {
                        value = "";
                    }
                }
                break;
            case Cell.CELL_TYPE_BLANK:
                value = "";
                break;
            default:
                break;
        }
        return value;
    }


    /**
     * 描述：获取IO流中的数据，组装成List<List<Object>>对象
     *
     * @param in,
     * @param fileName
     * @return
     * @throws IOException
     */
    public List<List<Object>>[] getBankListByExcelDivideBySheet(InputStream in, String fileName) throws Exception {

        //创建Excel工作薄
        Workbook work = this.getWorkbook(in, fileName);
        if (null == work) {
            throw new Exception("创建Excel工作薄为空！");
        }
        Sheet sheet = null;
        Row row = null;
        Cell cell = null;

        List<List<Object>> yijue = new ArrayList<List<Object>>(); //已决 sheet
        List<List<Object>> chuxian = new ArrayList<List<Object>>(); //出险 sheet
        List<List<Object>>[] array = new ArrayList[2];
        array[0] = yijue;
        array[1] = chuxian;
        //遍历Excel中所有的sheet
        for (int i = 0; i < work.getNumberOfSheets(); i++) {
            sheet = work.getSheetAt(i);
            if (sheet == null) {
                continue;
            }
            List<String> listPAH=new ArrayList<>();//赔案号对比
            //遍历当前sheet中的所有行
            for (int j = sheet.getFirstRowNum(); j <=sheet.getLastRowNum(); j++) {
                String name = sheet.getSheetName();
                row = sheet.getRow(j);
                if (row == null || row.getFirstCellNum() == j) {//不读取第一行
                    continue;
                }
                //遍历所有的列
                List<Object> li = new ArrayList<Object>();
                String contrastPAHRow=contrastPAH(row,listPAH);
                String[] rowsString=contrastPAHRow.split("&");
                //System.out.println(rowsString[0]+"---"+rowsString[1]);
                if(rowsString[1].equals("1")){
                    continue;
                }
                if (row.getCell((short)0)==null||row.getCell(row.getFirstCellNum())==null||
                        row.getCell(row.getFirstCellNum()).toString().trim()==""){//如果赔案号为空则不加入到数据库中
                    continue;
                }
                listPAH.add(rowsString[0]);
                int cols = sheet.getRow(0).getPhysicalNumberOfCells();
                for (int y = 0; y < cols; y++) {
                    cell = row.getCell(y);
                    li.add(this.getCellValue(cell));
                }
                //将每列存入对应的sheet中
                if ("已决".equals(name)) {
                    yijue.add(li);
                }
                if ("出险".equals(name)) {
                    chuxian.add(li);
                }
            }
        }
        work.close();
        return array;
    }

    /**
     *
     * @return
     */
    private String contrastPAH(Row row,List<String> listPAH){
        String rowString="";
        for (int i = row.getFirstCellNum(); i < row.getLastCellNum(); i++) {
            Cell cellString = row.getCell(i);
            rowString+=getCellValue(cellString);
        }
        for (String PAH:listPAH) {
            if(rowString.equals(PAH)){
                return rowString+"&1";//有重复
            }
        }
        return rowString+"&2";//无重复
    }
    /**
     * 新写的方法
     * @param in
     * @param fileName
     * @return
     * @throws Exception
     */

    public List<KyAccident> getBankListByExcelDivideBySheet2(InputStream in, String fileName) throws Exception {
        //创建Excel工作薄
        Workbook work = this.getWorkbook(in, fileName);
        if (null == work) {
            throw new Exception("创建Excel工作薄为空！");
        }
        Sheet sheet = null;
        Row row = null;
        Cell cell = null;
        List<KyAccident> kyaccidentsList=new ArrayList<KyAccident>();//出险 sheet
        //List<KyYiJue> yijue =new ArrayList<KyYiJue>();//已决 sheet
        //遍历Excel中所有的sheet
        for (int i = 0; i < work.getNumberOfSheets(); i++) {
            sheet = work.getSheetAt(i);
            if (sheet == null) {
                continue;
            }
            String name = sheet.getSheetName();
            //将每列存入对应的sheet中
            if ("已决".equals(name)){
                for (int j = sheet.getFirstRowNum(); j < sheet.getLastRowNum()+1; j++) {
                    row = sheet.getRow(j);
                    if (row == null || row.getFirstCellNum() == j) {//不读取第一行
                        continue;
                    }
                    int cols = sheet.getRow(0).getPhysicalNumberOfCells();
                    //遍历所有的列
                    List<Object> lo = new ArrayList<Object>();
                    //System.out.println(row.getCell((short)0).toString());
                    if (row.getCell((short)0)==null||row.getCell(row.getFirstCellNum())==null||
                    row.getCell(row.getFirstCellNum()).toString().trim()==""){//如果赔案号为空则不加入到数据库中
                            continue;
                        }
                    for (int y = 0; y < cols; y++) {
                        cell = row.getCell(y);
                        lo.add(this.getCellValue(cell));
                    }
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
                   // yijue.add(yj);
                    //System.out.println(yijue);
                }
            }
            if ("出险".equals(name)){
                for (int j = sheet.getFirstRowNum(); j < sheet.getLastRowNum()+1; j++) {
                    row = sheet.getRow(j);
                    if (row == null || row.getFirstCellNum() == j) {//不读取第一行
                        continue;
                    }
                    int cols = sheet.getRow(0).getPhysicalNumberOfCells();
                    //遍历所有的列
                    List<Object> lo = new ArrayList<Object>();
                    //System.out.println(row.getCell((short)0).toString());
                    if (row.getCell((short)0)==null||row.getCell(row.getFirstCellNum())==null||
                            row.getCell(row.getFirstCellNum()).toString().trim()==""){//如果赔案号为空则不加入到数据库中
                        continue;
                    }
                    for (int y = 0; y < cols; y++) {
                        cell = row.getCell(y);
                        lo.add(this.getCellValue(cell));
                    }
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
                    kyaccidentsList.add(accident);
                    //System.out.println(yijue);
                }
            }
        }
        work.close();
        return kyaccidentsList;
    }
}
