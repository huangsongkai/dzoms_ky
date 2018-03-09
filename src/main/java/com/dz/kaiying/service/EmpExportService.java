package com.dz.kaiying.service;

import com.dz.kaiying.DTO.JobStatisticsMonthDTO;
import com.dz.kaiying.DTO.JobStatisticsYearDTO;
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
import java.net.URLEncoder;
import java.util.*;

/**
 * Created by 24244 on 2018/3/6.
 */
@Service
public class EmpExportService {
    @Resource
    JobDutiesService jobDutiesService;
    private List<String> addSortEmp(){
        List<String> empName=new ArrayList<>();
        empName.add("王星");
        empName.add("汤伟丽");
        empName.add("孙大勇");
        empName.add("陈东慧");
        empName.add("明慧君");
        empName.add("冉铮");
        empName.add("夏滨");
        empName.add("金山");
        empName.add("郭庆辉");
        empName.add("赵立军");
        empName.add("王奇");
        empName.add("刘江龙");
        empName.add("胡越");
        empName.add("季兴仁");
        empName.add("刘巍");
        empName.add("尹丽波");
        empName.add("王雅君");
        empName.add("杨爽");
        empName.add("李志强");
        empName.add("赵顺");
        empName.add("刘波");
        empName.add("邹研");
        empName.add("常亮");
        return empName;
    }
    /**
     * 查询并且排序员工
     * @return 规定顺序的Map
     */
    public Map<Integer,JobStatisticsMonthDTO> empSort(){
        Result result=jobDutiesService.monthStatistics();
        List<JobStatisticsMonthDTO> JobStatisticsMonthDTOList= (List<JobStatisticsMonthDTO>) result.getData();
        //System.out.println(JobStatisticsMonthDTOList.size());
        Map<Integer,JobStatisticsMonthDTO> jsm=new HashMap<Integer,JobStatisticsMonthDTO>();
        int num=23;//顺序23人
        for (int i=0;i<JobStatisticsMonthDTOList.size();i++){
            JobStatisticsMonthDTO dto=JobStatisticsMonthDTOList.get(i);
            String name=dto.getName();
            dataSort(jsm, i, dto, name);
        }
            return jsm;
    }

    private void dataSort(Map<Integer, JobStatisticsMonthDTO> jsm, int i, JobStatisticsMonthDTO dto, String name) {
        int num;
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
                num=i+2;
                jsm.put(num,dto);
                break;
        }
    }

    /**
     * 年度生成excl导出
     * @param response
     * @throws Exception
     */
    public void yearAssessmentExportExcl(HttpServletResponse response)throws Exception{
        Result result=jobDutiesService.yearStatistics();
        List<JobStatisticsYearDTO> listJsyDto= (List<JobStatisticsYearDTO>) result.getData();
        if (listJsyDto==null)return;
        Map<String,JobStatisticsYearDTO> mapJsyDto=new HashMap<>();
        for (JobStatisticsYearDTO dto:listJsyDto) {
            String name=dto.getName();
            mapJsyDto.put(name,dto);
        }
        Workbook workbook = getSheets("classes/ExcelDemo/年度绩效考核汇总表模板.xls");
        Sheet sheet =  workbook.getSheet("Sheet1");
        List<String> empName=addSortEmp();
        List<JobStatisticsYearDTO> lastListdto=new ArrayList<>();
        for (int i=0;i<empName.size();i++) {
            JobStatisticsYearDTO dto1=null;
            try{
                dto1=mapJsyDto.get(empName.get(i));
            }catch (Exception e){
                dto1=null;
            }
            //System.out.println(dto1);
            if(dto1==null){
                continue;
            }else {
                lastListdto.add(dto1);
                mapJsyDto.remove(empName.get(i),dto1);
            }
        }
        //System.out.println(lastListdto+"---数量"+lastListdto.size());
        for (JobStatisticsYearDTO dto:mapJsyDto.values()){
            lastListdto.add(dto);
        }
        for (int i=0;i<lastListdto.size();i++){
            Row rows=sheet.createRow(i+1);
            JobStatisticsYearDTO dto2=lastListdto.get(i);
            rows.createCell(0).setCellValue(dto2.getName()==null?"":dto2.getName().toString());
            rows.createCell(1).setCellValue(dto2.getDepartment()==null?"":dto2.getDepartment().toString());
            rows.createCell(2).setCellValue(dto2.getJanuary()==null?"":dto2.getJanuary().toString());
            rows.createCell(3).setCellValue(dto2.getFebruary()==null?"":dto2.getFebruary().toString());
            rows.createCell(4).setCellValue(dto2.getMarch()==null?"":dto2.getMarch().toString());
            rows.createCell(5).setCellValue(dto2.getApril()==null?"":dto2.getApril().toString());
            rows.createCell(6).setCellValue(dto2.getMay()==null?"":dto2.getMay().toString());
            rows.createCell(7).setCellValue(dto2.getJune()==null?"":dto2.getJune().toString());
            rows.createCell(8).setCellValue(dto2.getJuly()==null?"":dto2.getJuly().toString());
            rows.createCell(9).setCellValue(dto2.getAugust()==null?"":dto2.getAugust().toString());
            rows.createCell(10).setCellValue(dto2.getSeptember()==null?"":dto2.getSeptember().toString());
            rows.createCell(11).setCellValue(dto2.getOctober()==null?"":dto2.getOctober().toString());
            rows.createCell(12).setCellValue(dto2.getNovember()==null?"":dto2.getNovember().toString());
            rows.createCell(13).setCellValue(dto2.getDecember()==null?"":dto2.getDecember().toString());
            rows.createCell(14).setCellValue(dto2.getTotal()==null?"":dto2.getTotal().toString());
            rows.createCell(15).setCellValue(dto2.getAverage()==null?"":dto2.getAverage().toString());
        }
        IOWriteExcel(response, workbook,"年度绩效考核汇总表.xls");
    }

    public Workbook getSheets(String model) throws Exception {
        ExportExcelUtil util = new ExportExcelUtil();
        File file = util.getExcelDemoFile(model);
        FileInputStream fis = new FileInputStream(file);
        return new ImportExcelUtil().getWorkbook(fis, file.getName());
    }

    /**
     *
     * @param mapJsyDto
     *
     * @return
     */
    public JobStatisticsYearDTO getJobStatisticsYearDTO(Map<String, JobStatisticsYearDTO> mapJsyDto,List<String> empName) {
        JobStatisticsYearDTO dto=null;
        if(empName.size()<1)return null;
        for (int i=0;i<empName.size();i++){
            dto=mapJsyDto.get(empName.get(i));
            empName.remove(i);
            if(dto==null){
                continue;
            }else {
                return dto;
            }
        }
        return null;
    }

    /**
     *月度生成excl导出
     * @throws Exception
     */
    public void monthAssessmentExportExcl(HttpServletResponse response)throws Exception{
        Result result=jobDutiesService.monthStatistics();
        List<JobStatisticsMonthDTO> listJsyDto= (List<JobStatisticsMonthDTO>) result.getData();
        if (listJsyDto==null)return;
        Map<String,JobStatisticsMonthDTO> mapJsyDto=new HashMap<>();
        for (JobStatisticsMonthDTO dto:listJsyDto) {
            String name=dto.getName();
            mapJsyDto.put(name,dto);
        }
        Workbook workbook = getSheets("classes/ExcelDemo/月度绩效考核汇总表模板.xls");
        Sheet sheet =  workbook.getSheet("Sheet1");
        List<String> empName=addSortEmp();
        List<JobStatisticsMonthDTO> lastListdto=new ArrayList<>();
        for (int i=0;i<empName.size();i++) {
            JobStatisticsMonthDTO dto1=null;
            try{
                dto1=mapJsyDto.get(empName.get(i));
            }catch (Exception e){
                dto1=null;
            }
            if(dto1==null){
                continue;
            }else {
                lastListdto.add(dto1);
                mapJsyDto.remove(empName.get(i),dto1);
            }
        }
        for (JobStatisticsMonthDTO dto:mapJsyDto.values()){
            lastListdto.add(dto);
        }
        for (int i=0;i<lastListdto.size();i++) {
            JobStatisticsMonthDTO jsmDTO=lastListdto.get(i);
            Row rows=sheet.createRow(i+3);
            rows.createCell(0).setCellValue(i+1);
            rows.createCell(1).setCellValue(jsmDTO.getDepartment()==null?"":jsmDTO.getDepartment().toString());
            rows.createCell(2).setCellValue(jsmDTO.getName()==null?"":jsmDTO.getName().toString());
            rows.createCell(3).setCellValue(jsmDTO.getKpScore().getTotal()==null?"":jsmDTO.getKpScore().getTotal().toString());
            rows.createCell(4).setCellValue(jsmDTO.getKpScore().getLsxgz()==null?"":jsmDTO.getKpScore().getLsxgz().toString());
            rows.createCell(5).setCellValue(jsmDTO.getKpScore().getRcgz()==null?"":jsmDTO.getKpScore().getRcgz().toString());
            rows.createCell(6).setCellValue(jsmDTO.getKpScore().getXwgf()==null?"":jsmDTO.getKpScore().getXwgf().toString());
            rows.createCell(7).setCellValue(jsmDTO.getRemarks()==null?"":jsmDTO.getRemarks().toString());
        }
        IOWriteExcel(response, workbook,"月度绩效考核汇总表.xls");
    }

    /**
     *
     * @param response
     * @param workbook
     * @param excelName
     * @throws IOException
     */
    public void IOWriteExcel(HttpServletResponse response, Workbook workbook,String excelName) throws IOException {
        ByteArrayOutputStream os = new ByteArrayOutputStream();
        BufferedInputStream bis=null;
        BufferedOutputStream bos=null;
        workbook.write(os);
        byte[] bytes = os.toByteArray();
        InputStream is = new ByteArrayInputStream(bytes);
        ServletOutputStream out = getOutputStream(response,excelName);
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

    /**
     * 获取输出流
     * @param response
     * @param xlsName 生成文件名
     * @return
     * @throws IOException
     */
    public ServletOutputStream getOutputStream(HttpServletResponse response,String xlsName) throws IOException {
        response.reset();
        response.setContentType("application/vnd.ms-excel;charset=utf-8");
        response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(xlsName, "utf-8"));//new String(("attachment;filename=月度绩效考核汇总表.xls").getBytes("UTF-8"), "UTF-8"));
        return response.getOutputStream();
    }

}
