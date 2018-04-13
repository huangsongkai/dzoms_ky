package com.dz.kaiying.service;

import com.dz.kaiying.model.ZuoTao;
import com.dz.kaiying.model.ZuoTaoCopy;
import com.dz.kaiying.repository.hiber.HibernateDao;
import com.dz.kaiying.util.Result;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by huang on 2017/7/7.
 */
//座套管理
@Service
public class ZuoTaoService extends BaseService{
    @Resource
    HibernateDao<ZuoTao, Integer> zuoTaoDao;

    private Result result = new Result();
    private static Map<Integer,ZuoTaoCopy> ZTMap =new HashMap<>();

    public Result listZT(Map<String,String> map) {
        String sql=" from ZuoTao ";
        if (map.size()>0) {
            sql += "where ";
            for (String name : map.keySet()) {
                switch (name) {
                    case "cph":
                        sql += addSql(name, map);
                        break;
                    case "employeeId":
                        sql += addSql(name, map);
                        break;
                }
            }
            if (!StringUtils.isEmpty(map.get("createTime")) && !StringUtils.isEmpty(map.get("endTime"))) {
                sql += "and date BETWEEN '" + map.get("createTime") + "' and '" + map.get("endTime") + "'";
            }
        }
        //SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:ss:mm");
            List<ZuoTao> zuoTaoList = zuoTaoDao.find(sql);
        List<ZuoTaoCopy> zuoTaoList1 =new ArrayList<>();
        for (ZuoTao zt:zuoTaoList) {
            ZuoTaoCopy ztc=new ZuoTaoCopy();
            ztc.setCph(zt.getCph());
            if(!StringUtils.isEmpty(zt.getCreateTime()))
                ztc.setCreateTime(zt.getCreateTime());
            else
                ztc.setCreateTime("");
            ztc.setDzps(zt.getDzps());
            ztc.setDzwz(zt.getDzwz());
            ztc.setEmployeeId(zt.getEmployeeId());
            ztc.setId(zt.getId());
            ztc.setXzps(zt.getXzps());
            ztc.setXzwz(zt.getXzwz());
            zuoTaoList1.add(ztc);
        }
        //存入内存方便下载
        if(zuoTaoList1.size()>0) {
            ZTMap.clear();
            for (int i = 1; i <= zuoTaoList1.size(); i++) {    //存入缓存
                ZTMap.put(i, zuoTaoList1.get(i - 1));
            }
        }
            result.setSuccess("查询成功", zuoTaoList1);
        return result;
    }
    private String addSql(String values, Map<String,String> map) {
        if(!StringUtils.isEmpty(map.get(values))){
            return values+" = '"+map.get(values)+"'";
        }
        return "";
    }

    /**
     * 座套发放记录下载
     * @param request
     * @param response
     * @return
     * @throws IOException
     */

    public Result ZTExportExcel(HttpServletRequest request, HttpServletResponse response) throws IOException {
        if (ZTMap.size()==0) {
            result.setSuccess("下载失败",null);
            return result;
        }
        EmpExportService export=new EmpExportService();
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet = wb.createSheet();
        //sheet.setColumnWidth(15,80);
        HSSFCellStyle style = getHssfCellStyle(wb);   //设置字体格式
        Row row = sheet.createRow((short) 0);
        Cell cel0=row.createCell(0);
        cel0.setCellStyle(style);
        cel0.setCellValue("序号");

        Cell cel1=row.createCell(1);
        cel1.setCellStyle(style);
        cel1.setCellValue("车牌号");

        Cell cel2=row.createCell(2);
        cel2.setCellStyle(style);
        cel2.setCellValue("员工工号");

        Cell cel3=row.createCell(3);
        cel3.setCellStyle(style);
        cel3.setCellValue("小座破损");

        Cell cel4=row.createCell(4);
        cel4.setCellStyle(style);
        cel4.setCellValue("小座污渍");

        Cell cel5=row.createCell(5);
        cel5.setCellStyle(style);
        cel5.setCellValue("大座破损");

        Cell cel6=row.createCell(6);
        cel6.setCellStyle(style);
        cel6.setCellValue("大座污渍");

        Cell cel7=row.createCell(7);
        cel7.setCellStyle(style);
        cel7.setCellValue("时间");
        for (Map.Entry<Integer, ZuoTaoCopy> entry : ZTMap.entrySet()) {
            Row row1 = sheet.createRow(entry.getKey());
            row1.createCell(0).setCellValue(entry.getValue().getId());
            sheet.autoSizeColumn(0,true);
            row1.createCell(1).setCellValue(entry.getValue().getCph());
            sheet.autoSizeColumn(1,true);
            row1.createCell(2).setCellValue(entry.getValue().getEmployeeId());
            sheet.autoSizeColumn(2,true);
            row1.createCell(3).setCellValue(entry.getValue().getXzps());
            sheet.autoSizeColumn(3,true);
            row1.createCell(4).setCellValue(entry.getValue().getXzwz());
            sheet.autoSizeColumn(4,true);
            row1.createCell(5).setCellValue(entry.getValue().getDzps());
            sheet.autoSizeColumn(5,true);
            row1.createCell(6).setCellValue(entry.getValue().getDzwz());
            sheet.autoSizeColumn(6,true);
            row1.createCell(7).setCellValue(entry.getValue().getCreateTime());
            sheet.autoSizeColumn(7,true);
        }
        export.IOWriteExcel(response,wb,"座套发放记录.xls");

        result.setSuccess("导出成功", null);
        return result;
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
       // style.setWrapText(true);  // 设置单元格水平方向对其方式
        return style;
    }
}
