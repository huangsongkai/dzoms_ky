
package com.dz.kaiying.service;

import com.dz.kaiying.model.KyAccident;
import com.dz.kaiying.model.KyYiJue;
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
//todo
@Service
public class SgService {
    @Resource
    HibernateDao<KyAccident, Integer> bxDao;  //事故dao

    @Resource
    HibernateDao<KyYiJue, Integer> yjDao;  //已决dao
    private Result result = new Result();


    public Result querysg() {
        List accident = bxDao.find("from KyAccident");//事故查询
        result.setSuccess("查询成功", accident);
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

        //该处可调用service相应方法进行数据保存到数据库中，现只对数据输出
        for (int i = 0; i < chuxian.size(); i++) {
            List<Object> lo = chuxian.get(i);
            KyAccident accident = new KyAccident();
//            accident.setSgclbm(String.valueOf(lo.get(0))); //事故处理部门
            accident.setBarq(String.valueOf(lo.get(0))); //报案日期
            accident.setBasj(String.valueOf(lo.get(1))); //报案时间
            accident.setJasj(String.valueOf(lo.get(2))); //结案时间
            accident.setTpbz(String.valueOf(lo.get(3))); //通赔标志
            accident.setYwly(String.valueOf(lo.get(4))); //业务来源
            accident.setBdh(String.valueOf(lo.get(5))); //保单号
            accident.setBdgsjg(String.valueOf(lo.get(6))); //保单归属机构
            accident.setQbrq(String.valueOf(lo.get(7))); //起保日期
            accident.setZbrq(String.valueOf(lo.get(8))); //终保日期
            accident.setCdrq(String.valueOf(lo.get(9))); //初等日期
            accident.setTk(String.valueOf(lo.get(10))); //条款
            accident.setBf(String.valueOf(lo.get(11)));//保费
            accident.setBah(String.valueOf(lo.get(12)));//报案号
            accident.setLah(String.valueOf(lo.get(13))); //立案号
            accident.setAjxz(String.valueOf(lo.get(14))); //案件性质
            accident.setCxrq(String.valueOf(lo.get(15)));//出险日期
            accident.setSgclfs(String.valueOf(lo.get(16)));//处理方式
            accident.setLarq(String.valueOf(lo.get(17)));//立案日期
            accident.setJarq(String.valueOf(lo.get(18)));//结案日期
            accident.setGsje(String.valueOf(lo.get(19)));//估损金额
            accident.setGjpk(String.valueOf(lo.get(20)));//估计赔款
            accident.setPfje(String.valueOf(lo.get(21)));//赔付金额
            accident.setBar(String.valueOf(lo.get(22))); //报案人
            accident.setBardh(String.valueOf(lo.get(23)));//报案人电话
            accident.setCky(String.valueOf(lo.get(24)));//查勘员1
            accident.setGsje(String.valueOf(lo.get(25)));//查勘员2
            accident.setClrdm(String.valueOf(lo.get(26)));//处理人代码
            accident.setBdjbr(String.valueOf(lo.get(27)));//保单经办人代码
            accident.setBdgsr(String.valueOf(lo.get(28)));//保单归属人代码
            accident.setCxdz(String.valueOf(lo.get(29)));//出险地址
            accident.setCxyy(String.valueOf(lo.get(30)));//出险原因
            accident.setJsr(String.valueOf(lo.get(31))); //驾驶人
            accident.setJsz(String.valueOf(lo.get(32)));//驾驶证
            accident.setCpxh(String.valueOf(lo.get(33)));//厂牌型号
            accident.setCph(String.valueOf(lo.get(34)));//车牌号
            accident.setBbxr(String.valueOf(lo.get(35)));//被保险人
            accident.setCxjg(String.valueOf(lo.get(36))); //出险经过
            bxDao.save(accident);
            System.out.println("打印信息--> ");
        }

        for (int i = 0; i < yijue.size(); i++) {
            List<Object> lo = yijue.get(i);
            KyYiJue yj = new KyYiJue();
            yj.setPdh(String.valueOf(lo.get(0))); //赔单号
            yj.setXzdm(String.valueOf(lo.get(1))); //险种代码
            yj.setBdgsjg(String.valueOf(lo.get(2)));//保单归属机构
            yj.setTkdm(String.valueOf(lo.get(3)));
            yj.setJssh( String.valueOf(lo.get(4)));
            yj.setLah(String.valueOf(lo.get(5)));
            yj.setBah(String.valueOf(lo.get(6))); //报案号
            yj.setBarq(String.valueOf(lo.get(7)));//报案日期
            yj.setBdh(String.valueOf(lo.get(8)));//保单号
            yj.setQbrq(String.valueOf(lo.get(9)));//起报日期
            yj.setZbrq(String.valueOf(lo.get(10)));//终保日期
            yj.setBe(String.valueOf(lo.get(11)));//保额
            yj.setBf(String.valueOf(lo.get(12)));//保费
            yj.setXcgzj(String.valueOf(lo.get(13)));
            yj.setPalb(String.valueOf(lo.get(14)));
            yj.setCxyy(String.valueOf(lo.get(15)));
            yj.setSglx(String.valueOf(lo.get(16)));
            yj.setSglx(String.valueOf(lo.get(17)));
            yj.setHprq(String.valueOf(lo.get(18)));//核赔日期
            yj.setHpr(String.valueOf(lo.get(19)));
            yj.setLsrdm(String.valueOf(lo.get(20)));
            yj.setLsr(String.valueOf(lo.get(21))); //理算人
            yj.setCxrq(String.valueOf(lo.get(22)));
            yj.setLarq(String.valueOf(lo.get(23))); //立案日期
            yj.setJarq(String.valueOf(lo.get(24))); //结案日期
            yj.setPfje(String.valueOf(lo.get(25)));
            yj.setCwfkje(String.valueOf(lo.get(26)));
            yj.setBbxr(String.valueOf(lo.get(27))); //被保险人
            yj.setLkrlx(String.valueOf(lo.get(28)));
            yj.setLkr(String.valueOf(lo.get(29)));
            yj.setLkrdh(String.valueOf(lo.get(30)));
            yj.setZjlx(String.valueOf(lo.get(31)));
            yj.setZjhm(String.valueOf(lo.get(32))); //证件号码
            yj.setKhh(String.valueOf(lo.get(33)));//开户行
            yj.setYhdm(String.valueOf(lo.get(34))); //银行代码
            yj.setYhzh(String.valueOf(lo.get(35)));
            yj.setQydm(String.valueOf(lo.get(36)));//区域代码
            yj.setGsbz(String.valueOf(lo.get(37)));//公私标志
            yj.setBar(String.valueOf(lo.get(38)));
            yj.setBardh(String.valueOf(lo.get(39)));
            yj.setBdjbr(String.valueOf(lo.get(40)));
            yj.setCxdd(String.valueOf(lo.get(41)));
            yj.setCph(String.valueOf(lo.get(42)));
            yj.setCx(String.valueOf(lo.get(43)));
            yj.setYwly(String.valueOf(lo.get(44)));
            yj.setTpbz(String.valueOf(lo.get(45)));
            yj.setCkydm1(String.valueOf(lo.get(46)));
            yj.setCky1(String.valueOf(lo.get(47)));
            yj.setCkydm2(String.valueOf(lo.get(48)));
            yj.setCky2(String.valueOf(lo.get(49)));
            yjDao.save(yj);
            System.out.println("打印信息--> ");
        }
        result.setSuccess("导出成功", null);
        return "sg/accident_list";
    }

    public static void main(String[] args) throws Exception {

        File file = new File("/Users/zhangyanqi/Desktop/xin.xls");
        FileInputStream in = new FileInputStream(file);
        List<List<Object>>[] sheets = new ImportExcelUtil().getBankListByExcelDivideBySheet(in, "xin.xls");
        in.close();

        List<List<Object>> yijue = sheets[0];
        List<List<Object>> chuxian = sheets[1];

        //该处可调用service相应方法进行数据保存到数据库中，现只对数据输出
        for (int i = 0; i < chuxian.size(); i++) {
            List<Object> lo = chuxian.get(i);
            System.out.println(lo.get(0));
        }

        for (int i = 0; i < yijue.size(); i++) {
            List<Object> lo = yijue.get(i);
            System.out.println(lo.get(0));
        }
    }
}
