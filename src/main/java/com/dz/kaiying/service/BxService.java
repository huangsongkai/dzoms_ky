package com.dz.kaiying.service;

import com.dz.kaiying.model.KyAccident;
import com.dz.kaiying.model.KyInsurance;
import com.dz.kaiying.repository.hiber.HibernateDao;
import com.dz.kaiying.util.ExportExcelUtil;
import com.dz.kaiying.util.ImportExcelUtil;
import com.dz.kaiying.util.Result;
import org.apache.poi.ss.usermodel.*;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.List;

/**
 * Created by huang on 2017/7/20.
 */
@Service
public class BxService {

    @Resource
    HibernateDao<KyInsurance, Integer> bxDao;  //保险dao

    private Result result = new Result();

    public Result querybx() {
        List insurance = bxDao.find("from KyInsurance");
        result.setSuccess("查询成功",insurance);
        return result;
    }

    public Result exportExcel(HttpServletRequest request, HttpServletResponse response) throws IOException {
        OutputStream os = null;
        Workbook wb = null;    //工作薄

        try {
            //数据库取值
            List<KyInsurance> insurance = bxDao.find("from KyInsurance");
            //导出Excel文件数据
            ExportExcelUtil util = new ExportExcelUtil();
            File file =util.getExcelDemoFile("classes/ExcelDemo/保险模板.xlsx");
            String sheetName="sheet1";
            wb = writeNewExcel(file, sheetName, insurance);
            String fileName="保险信息.xlsx";
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition", "attachment;filename="+ URLEncoder.encode(fileName, "utf-8"));
            os = response.getOutputStream();
            wb.write(os);
        } catch (Exception e) {
            e.printStackTrace();
        }
        finally{
            os.flush();
            os.close();
            wb.close();
        }
        result.setSuccess("导出成功",null);
        return result;
    }


    public  Workbook writeNewExcel(File file,String sheetName,List<KyInsurance> lis) throws Exception{
        Workbook wb = null;
        Row row = null;
        Cell cell = null;

        FileInputStream fis = new FileInputStream(file);
        wb = new ImportExcelUtil().getWorkbook(fis, file.getName());	//获取工作薄
        Sheet sheet = wb.getSheet(sheetName);

        //循环插入数据
        int lastRow = sheet.getLastRowNum()-2;    //插入数据的数据ROW
        CellStyle cs = setSimpleCellStyle(wb);    //Excel单元格样式
        for (int i = 0; i < lis.size(); i++) {
            row = sheet.createRow(lastRow+i); //创建新的ROW，用于数据插入

            //按项目实际需求，在该处将对象数据插入到Excel中
            KyInsurance vo  = lis.get(i);
            if(null==vo){
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
     * @return
     */
    public  CellStyle setSimpleCellStyle(Workbook wb){
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

        //该处可调用service相应方法进行数据保存到数据库中，现只对数据输出
        for (int i = 0; i < listob.size(); i++) {
            List<Object> lo = listob.get(i);
            KyInsurance insurance = new KyInsurance();
            KyAccident.class.getFields();//
            insurance.setBdh(String.valueOf(lo.get(1)));
            insurance.setCph(String.valueOf(lo.get(2)));
            insurance.setBbxr(String.valueOf(lo.get(3)));
            insurance.setBxqq(String.valueOf(lo.get(4)));
            insurance.setBxzq(String.valueOf(lo.get(5)));
            insurance.setZbe(String.valueOf(lo.get(6)));
            insurance.setZbf(String.valueOf(lo.get(7)));
            insurance.setLrsj(String.valueOf(lo.get(8)));
            bxDao.save(insurance);
            System.out.println("打印信息--> ");
        }
        result.setSuccess("导出成功", null);
        return "bx/insurance_list";
    }
}
