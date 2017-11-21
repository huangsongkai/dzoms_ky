package com.dz.kaiying.service;

import com.dz.kaiying.model.KyAccident;
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
public class SgService {
    @Resource
    HibernateDao<KyAccident, Integer> bxDao;  //事故dao
    private Result result = new Result();


    public Result querysg() {
        List accident = bxDao.find("from KyAccident");//事故查询
        result.setSuccess("查询成功",accident);
        return result;
    }

    public Result exportExcel(HttpServletRequest request, HttpServletResponse response) throws IOException {
        OutputStream os = null;
        Workbook wb = null;    //工作薄

        try {
            //数据库取值
            List<KyAccident> accident = bxDao.find("from KyAccident");

            //导出Excel文件数据
            ExportExcelUtil util = new ExportExcelUtil();
            File file =util.getExcelDemoFile("classes/ExcelDemo/事故模板.xlsx");
            String sheetName="sheet1";
            wb = writeNewExcel(file, sheetName, accident);

            String fileName="事故信息导出.xlsx";
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


    public  Workbook writeNewExcel(File file,String sheetName,List<KyAccident> lis) throws Exception{
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
            KyAccident vo  = lis.get(i);
            if(null==vo){
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

    public String importExcel(HttpServletRequest request) throws Exception {
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
            KyAccident accident = new KyAccident();
            KyAccident.class.getFields();//
            accident.setBasj(String.valueOf(lo.get(1)));
            accident.setJasj(String.valueOf(lo.get(2)));
            accident.setBdh(String.valueOf(lo.get(3)));
            accident.setCdrq(String.valueOf(lo.get(4)));
            accident.setLah(String.valueOf(lo.get(5)));
            accident.setAjxz(String.valueOf(lo.get(6)));
            accident.setCxrq(String.valueOf(lo.get(7)));
            accident.setSgclfs(String.valueOf(lo.get(8)));
            accident.setGsje(String.valueOf(lo.get(9)));
            accident.setGjpk(String.valueOf(lo.get(10)));
            accident.setPfje(String.valueOf(lo.get(11)));
            accident.setBar(String.valueOf(lo.get(12)));
            accident.setBardh(String.valueOf(lo.get(13)));
            accident.setCky(String.valueOf(lo.get(14)));
            accident.setCxdz(String.valueOf(lo.get(15)));
            accident.setCxyy(String.valueOf(lo.get(16)));
            accident.setJsr(String.valueOf(lo.get(17)));
            accident.setJsz(String.valueOf(lo.get(18)));
            accident.setCpxh(String.valueOf(lo.get(19)));
            accident.setCph(String.valueOf(lo.get(20)));
            accident.setCxjg(String.valueOf(lo.get(21)));
            bxDao.save(accident);
            System.out.println("打印信息--> ");
        }
        result.setSuccess("导出成功", null);
        return "sg/accident_list";
    }
}
