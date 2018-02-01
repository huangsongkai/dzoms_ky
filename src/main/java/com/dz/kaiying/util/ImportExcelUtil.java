package com.dz.kaiying.util;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;


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
            for (int j = sheet.getFirstRowNum(); j < sheet.getLastRowNum(); j++) {
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
    public Object getCellValue(Cell cell) {
        if (cell == null) {
            return "";
        }
        Object value = null;
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
                    String s = df.format(cell.getNumericCellValue());
                    if (s != null) {
                        value = s.trim();
                    } else {
                        value = "";
                    }
                } else if ("m/d/yy".equals(cell.getCellStyle().getDataFormatString())) {
                    String s2 = sdf.format(cell.getDateCellValue());
                    if (s2 != null) {
                        value = s2.trim();
                    } else {
                        value = "";
                    }
                } else {
                    String s3 = df2.format(cell.getNumericCellValue());
                    if (s3 != null) {
                        value = s3.trim();
                    } else {
                        value = "";
                    }
                }
                break;
            case Cell.CELL_TYPE_BOOLEAN:
                value = cell.getBooleanCellValue();
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

            //遍历当前sheet中的所有行
            for (int j = sheet.getFirstRowNum(); j < sheet.getLastRowNum(); j++) {
                String name = sheet.getSheetName();
                row = sheet.getRow(j);
                if (row == null || row.getFirstCellNum() == j) {//不读取第一行
                    continue;
                }
                //遍历所有的列
                List<Object> li = new ArrayList<Object>();
                for (int y = row.getFirstCellNum(); y < row.getLastCellNum(); y++) {
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


}
