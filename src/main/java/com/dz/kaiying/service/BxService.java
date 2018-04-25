package com.dz.kaiying.service;

import com.dz.kaiying.model.KyAccident;
import com.dz.kaiying.model.KyInsurance;
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
import java.net.URLEncoder;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by huang on 2017/7/20.
 */
@Service
public class BxService {

    @Resource
    HibernateDao<KyInsurance, Integer> bxDao;  //保险dao

    private Result result = new Result();

    private static Map<Integer,KyInsurance> insuranceMap =new HashMap<>();

    /**
     * 保险列表查询
     * @param map
     * @return
     */
    public Result querybx(Map<String,String> map) {
        String sql = "from KyInsurance";
        boolean joinSql = false;
        for (String key:map.keySet()) {
            if(key.equals("bdh") || key.equals("cph")) {
                sql += " where " + key + " = '" + map.get(key) + "'";
                joinSql =true;
                break;
            }
        }
        if(joinSql && !StringUtils.isEmpty(map.get("createTime"))){
            sql += " and bxzq BETWEEN '"+map.get("createTime")+"' and '"+map.get("endTime")+"'";
        }
        if(!joinSql && !StringUtils.isEmpty(map.get("createTime"))){
            sql += " where bxzq BETWEEN '"+map.get("createTime")+"' and '"+map.get("endTime")+"'";
        }
        List<KyInsurance> insurance = bxDao.find(sql);

        if(insurance.size()>0) {
            insuranceMap.clear();
            for (int i = 1; i <= insurance.size(); i++) {    //存入缓存
                insuranceMap.put(i, insurance.get(i - 1));
            }
        }
        result.setSuccess("查询成功", insurance);
        return result;
    }

    /**
     * 保险列表下载
     */
    public void insuranceExportExcl(HttpServletResponse rep)throws Exception{
        if (insuranceMap.size()==0)return;   //如果为空无法下载
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet = wb.createSheet();
        HSSFCellStyle style = getHssfCellStyle(wb);   //设置字体格式
        Row row = sheet.createRow((short) 0);
        Cell cel0=row.createCell(0);
        cel0.setCellStyle(style);
        cel0.setCellValue("序号");
        Cell cel1=row.createCell(1);
        cel1.setCellStyle(style);
        cel1.setCellValue("保单号");
        Cell cel2=row.createCell(2);
        cel2.setCellStyle(style);
        cel2.setCellValue("车牌号");
        Cell cel3=row.createCell(3);
        cel3.setCellStyle(style);
        cel3.setCellValue("被保险人");
        Cell cel4=row.createCell(4);
        cel4.setCellStyle(style);
        cel4.setCellValue("保险起期");
        ;
        Cell cel5=row.createCell(5);
        cel5.setCellStyle(style);
        cel5.setCellValue("保险止期");

        Cell cel6=row.createCell(6);
        cel6.setCellStyle(style);
        cel6.setCellValue("总保额");

        Cell cel7=row.createCell(7);
        cel7.setCellStyle(style);
        cel7.setCellValue("总保费");

        Cell cel8=row.createCell(8);
        cel8.setCellStyle(style);
        cel8.setCellValue("录入时间");

        for (Map.Entry<Integer, KyInsurance> entry : insuranceMap.entrySet()) {
            Row row1 = sheet.createRow(entry.getKey());
            row1.createCell(0).setCellValue(entry.getValue().getId());
            sheet.autoSizeColumn(0,true);
            row1.createCell(1).setCellValue(entry.getValue().getBdh());
            sheet.autoSizeColumn(1,true);
            row1.createCell(2).setCellValue(entry.getValue().getCph());
            sheet.autoSizeColumn(2,true);
            row1.createCell(3).setCellValue(entry.getValue().getBbxr());
            sheet.autoSizeColumn(3,true);
            row1.createCell(4).setCellValue(entry.getValue().getBxqq());
            sheet.autoSizeColumn(4,true);
            row1.createCell(5).setCellValue(entry.getValue().getBxzq());
            sheet.autoSizeColumn(5,true);
            row1.createCell(6).setCellValue(entry.getValue().getZbe());
            sheet.autoSizeColumn(6,true);
            row1.createCell(7).setCellValue(entry.getValue().getZbf());
            sheet.autoSizeColumn(7,true);
            row1.createCell(8).setCellValue(entry.getValue().getLrsj());
            sheet.autoSizeColumn(8,true);
        }
        EmpExportService export=new EmpExportService();
        export.IOWriteExcel(rep,wb,"保险列表.xls");
    }
    /**
     * 设置Excel字体格式
     * @param wb
     * @return
     */
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

    public Result exportExcel(HttpServletRequest request, HttpServletResponse response) throws IOException {
        OutputStream os = null;
        Workbook wb = null;    //工作薄

        try {
            //数据库取值
            List<KyInsurance> insurance = bxDao.find("from KyInsurance");
            //导出Excel文件数据
            ExportExcelUtil util = new ExportExcelUtil();
            File file = util.getExcelDemoFile("classes/ExcelDemo/保险模板.xlsx");
            String sheetName = "sheet1";
            wb = writeNewExcel(file, sheetName, insurance);
            String fileName = "保险信息.xlsx";
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


    public Workbook writeNewExcel(File file, String sheetName, List<KyInsurance> lis) throws Exception {
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
            KyInsurance vo = lis.get(i);
            if (null == vo) {
                break;
            }
            //Cell赋值开始
            cell = row.createCell(0);
            cell.setCellValue(i);
            cell.setCellStyle(cs);

            cell = row.createCell(1);
            cell.setCellValue(vo.getBdh());
            cell.setCellStyle(cs);

            cell = row.createCell(2);
            cell.setCellValue(vo.getCph());
            cell.setCellStyle(cs);

            cell = row.createCell(3);
            cell.setCellValue(vo.getBbxr());
            cell.setCellStyle(cs);

            cell = row.createCell(4);
            cell.setCellValue(vo.getBxqq());
            cell.setCellStyle(cs);

            cell = row.createCell(5);
            cell.setCellValue(vo.getZbe());
            cell.setCellStyle(cs);

            cell = row.createCell(6);
            cell.setCellValue(vo.getZbf());
            cell.setCellStyle(cs);

            cell = row.createCell(7);
            cell.setCellValue(vo.getLrsj());
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

    public String importExcel(HttpServletRequest request, HttpServletResponse response) throws Exception {
        CommonsMultipartResolver commonsMultipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
        commonsMultipartResolver.setDefaultEncoding("utf-8");
        MultipartHttpServletRequest multipartRequest = commonsMultipartResolver.resolveMultipart(request);
        System.out.println("通过传统方式form表单提交方式导入excel文件！");

        InputStream in = null;
        List<List<Object>> listob = null;
        MultipartFile file = multipartRequest.getFile("upfile");
        if (file.isEmpty()) {
            throw new Exception("文件不存在！");
        }
        in = file.getInputStream();
        listob = new ImportExcelUtil().getBankListByExcel(in, file.getOriginalFilename());
        in.close();
        if(listob.size() == 0) return "";
        Map<String,List<Object>> tbdh=new HashMap<>();
        for (List<Object> obj:listob) {
            Object objString = obj.get(1);
            if(tbdh.containsKey(String.valueOf(objString))){
                continue;
            }
            tbdh.put(String.valueOf(objString),obj);
        }
        //查询库中数据做对比
        List<KyInsurance> kInsurance = bxDao.find("from KyInsurance");
        //该处可调用service相应方法进行数据保存到数据库中，现只对数据输出
        for (List<Object> lo:tbdh.values()) {
            boolean equal = false;
            for (KyInsurance kyi:kInsurance) {
                if(kyi.getBdh().equals(lo.get(1))){
                    equal =true;
                    break;
                }
            }
            if(equal){
                continue;
            }
            KyInsurance insurance = new KyInsurance();
            insurance.setTbdh(String.valueOf(lo.get(0)));
            insurance.setBdh(String.valueOf(lo.get(1)));
            insurance.setTdh(String.valueOf(lo.get(2)));
            insurance.setCph(String.valueOf(lo.get(3)));
            insurance.setBbxr(String.valueOf(lo.get(4)));
            insurance.setBxqq(String.valueOf(lo.get(5)));
            insurance.setBxzq(String.valueOf(lo.get(6)));
            insurance.setCzr(String.valueOf(lo.get(7)));
            insurance.setZbe(String.valueOf(lo.get(8)));
            insurance.setZbf(String.valueOf(lo.get(9)));
            insurance.setLrsj(String.valueOf(lo.get(10)));
            insurance.setCreateDate(new Date(System.currentTimeMillis()));
            bxDao.save(insurance);
            System.out.println("打印信息--> ");
        }
        result.setSuccess("导出成功", null);
        return "bx/insurance_list";
    }


}
