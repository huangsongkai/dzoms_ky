package com.dz.kaiying.service;

import com.dz.kaiying.DTO.JobStatisticsMonthDTO;
import com.dz.kaiying.util.ExportExcelUtil;
import com.dz.kaiying.util.ImportExcelUtil;
import com.dz.kaiying.util.Result;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 24244 on 2018/3/6.
 */
@Service
public class EmpExportService {
    @Resource
    JobDutiesService jobDutiesService;

    /**
     * 查询并且排序员工
     * @return 规定顺序的Map
     */
    public Map<Integer,JobStatisticsMonthDTO> empSort(){
        Result result=jobDutiesService.monthStatistics();
        List<JobStatisticsMonthDTO> JobStatisticsMonthDTOList= (List<JobStatisticsMonthDTO>) result.getData();
        Map<Integer,JobStatisticsMonthDTO> jsm=new HashMap<Integer,JobStatisticsMonthDTO>();
        int num=23;//顺序23人
        for (int i=0;i<JobStatisticsMonthDTOList.size();i++){
            JobStatisticsMonthDTO dto=JobStatisticsMonthDTOList.get(i);
            String name=dto.getName();
            switch (name){
                case "王星":                                        //--1
                    jsm.put(1,dto);
                    break;
                case "汤伟丽":                                      //--2
                    jsm.put(2,dto);
                    break;
                case "孙大勇":                                      //--3
                    jsm.put(3,dto);
                    break;
                case "陈东慧":                                      //--4
                    jsm.put(4,dto);
                    break;
                case "明慧君":                                      //--5
                    jsm.put(5,dto);
                    break;
                case "冉铮":                                      //--6
                    jsm.put(6,dto);
                    break;
                case "夏滨":                                      //--7
                    jsm.put(7,dto);
                    break;
                case "金山":                                      //--8
                    jsm.put(8,dto);
                    break;
                case "郭庆辉":                                      //--9
                    jsm.put(9,dto);
                    break;
                case "赵立军":                                      //--10
                    jsm.put(10,dto);
                    break;
                case "王奇":                                      //--11
                    jsm.put(11,dto);
                    break;
                case "刘江龙":                                      //--12
                    jsm.put(12,dto);
                    break;
                case "胡越":                                      //--13
                    jsm.put(13,dto);
                    break;
                case "季兴仁":                                      //--14
                    jsm.put(14,dto);
                    break;
                case "王臻君":                                      //--15
                    jsm.put(15,dto);
                    break;
                case "尹丽波":                                      //--16
                    jsm.put(16,dto);
                    break;
                case "刘巍":                                      //--17
                    jsm.put(17,dto);
                    break;
                case "杨爽":                                      //--18
                    jsm.put(18,dto);
                    break;
                case "李志强":                                      //--19
                    jsm.put(19,dto);
                    break;
                case "赵顺":                                      //--20
                    jsm.put(20,dto);
                    break;
                case "刘波":                                      //--21
                    jsm.put(21,dto);
                    break;
                case "邹研":                                      //--22
                    jsm.put(22,dto);
                    break;
                case "常亮":                                      //--23
                    jsm.put(23,dto);
                    break;
                default:                                      //--24++
                    num+=1;
                    jsm.put(num,dto);
                    break;
            }
        }
            return jsm;
    }

    /**
     *
     * @throws Exception
     */
    public void utilExcl(HttpServletResponse response)throws Exception{
        Map<Integer,JobStatisticsMonthDTO> dto= empSort();
        ExportExcelUtil util = new ExportExcelUtil();
        File file = util.getExcelDemoFile("classes/ExcelDemo/月度绩效考核汇总表模板.xls");
        FileInputStream fis = new FileInputStream(file);
        Workbook workbook = new ImportExcelUtil().getWorkbook(fis, file.getName());    //获取工作薄
        Sheet sheet =  workbook.getSheet("Sheet1");
        for (int row = 0; row < dto.size(); row++){
            JobStatisticsMonthDTO jsmDTO=dto.get(row);
            Row rows=sheet.createRow(row+3);
            int numCol=sheet.getRow(2).getFirstCellNum();
            System.out.println(numCol);//获取第三行有几列
            for (int col = 0; col < numCol; col++){
                if(col==0){
                    rows.createCell(col).setCellValue(col+1);
                }else if(col==1){
                    rows.createCell(col).setCellValue(ObjSetString(jsmDTO,col));
                }else if(col==2){
                    rows.createCell(col).setCellValue(ObjSetString(jsmDTO,col));
                }else if (col==3){
                    rows.createCell(col).setCellValue(ObjSetString(jsmDTO,col));
                }else if (col==4){
                    rows.createCell(col).setCellValue(ObjSetString(jsmDTO,col));
                }else if (col==5){
                    rows.createCell(col).setCellValue(ObjSetString(jsmDTO,col));
                }else if (col==6){
                    rows.createCell(col).setCellValue(ObjSetString(jsmDTO,col));
                }else if (col==7){
                    rows.createCell(col).setCellValue(ObjSetString(jsmDTO,col));
                }
            }
        }
        ByteArrayOutputStream os = new ByteArrayOutputStream();
        BufferedInputStream bis=null;
        BufferedOutputStream bos=null;
        workbook.write(os);
        byte[] bytes = os.toByteArray();
        InputStream is = new ByteArrayInputStream(bytes);
        response.reset();
        response.setContentType("application/vnd.ms-excel;charset=utf-8");
        response.setHeader("Content-Disposition", new String(("attachment;filename=月度绩效考核汇总表.xls").getBytes("UTF-8"), "UTF-8"));
        ServletOutputStream out = response.getOutputStream();
        bis=new BufferedInputStream(is);
        bos=new BufferedOutputStream(out);
        byte[] buff = new byte[1024];
        int lengthByte=-1;
        while ((lengthByte=bis.read(buff,0,buff.length))!=-1){
            bos.write(buff,0,lengthByte);
        }
        if (bis!=null){
            bis.close();
        }
        if (bos!=null) {
            bos.close();
        }
    }

    private String ObjSetString(JobStatisticsMonthDTO jsmDTO,int col){
        if(col==1&&jsmDTO.getDepartment()!=null){
            return jsmDTO.getDepartment().toString();
        }else if(col==2&&jsmDTO.getName()!=null){
            return jsmDTO.getName().toString();
        }else if (col==3&&jsmDTO.getKpScore().getTotal()!=null){
            return jsmDTO.getKpScore().getTotal().toString();
        }else if (col==4&&jsmDTO.getKpScore().getLsxgz()!=null){
            return jsmDTO.getKpScore().getLsxgz().toString();
        }else if (col==5&&jsmDTO.getKpScore().getRcgz()!=null){
            return jsmDTO.getKpScore().getRcgz().toString();
        }else if (col==6&&jsmDTO.getKpScore().getXwgf()!=null){
            return jsmDTO.getKpScore().getXwgf().toString();
        }else if (col==7&&jsmDTO.getRemarks()!=null){
            return jsmDTO.getRemarks().toString();
        }
        return "";
    }
}
