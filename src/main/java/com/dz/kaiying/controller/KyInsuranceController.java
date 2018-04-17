package com.dz.kaiying.controller;

import com.dz.kaiying.service.BxService;
import com.dz.kaiying.util.Result;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;


/**
 * Created by huang on 2017/4/17.
 */
//保险Controller
@Controller
@RequestMapping(value = "/bx")
public class KyInsuranceController {

    @Resource
    BxService bxService;

    /**
     * 保险信息查询
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/querybx", method = RequestMethod.GET)
    @ResponseBody
    public Result querybx (HttpServletRequest request) throws Exception {
        Map<String,String> map=new HashMap<>();
        String bdh = request.getParameter("bdh");
        isEmptyParas(map,"bdh", bdh);
        isEmptyParas(map,"createTime", request.getParameter("createTime"));
        isEmptyParas(map,"endTime", request.getParameter("endTime"));
        isEmptyParas(map,"cph", request.getParameter("carNum")); //传值需要修改
        return bxService.querybx(map);
    }
    private void isEmptyParas(Map<String, String> map, String mapName, String carNumber) {
        if(!StringUtils.isEmpty(carNumber)){
            map.put(mapName,carNumber);
        }
    }

    /**
     * 保险信息下载
     */
    @RequestMapping(value = "/insurance/download", method = RequestMethod.GET)
    public void insuranceExportExcl (HttpServletRequest request, HttpServletResponse response) throws Exception {
        bxService.insuranceExportExcl(response);
    }

    //保险信息导出
    @RequestMapping(value = "/exportExcel", method = RequestMethod.GET)
    public Result sgexportExcel (HttpServletRequest request, HttpServletResponse response) throws Exception {
        System.out.println("   ");
        return bxService.exportExcel(request, response);
    }

    //保险信息导入
    @RequestMapping(value = "/importExcel", method = RequestMethod.POST)
    public String sgimportExcel (HttpServletRequest request, HttpServletResponse response) throws Exception {
        System.out.println(" ");
        return bxService.importExcel(request, response);
    }

    /**
     * 跳转事故展示页
     */
    @RequestMapping(value = "/listbx", method = RequestMethod.GET)
    public String listbx (HttpServletRequest request) throws Exception {
        return "bx/insurance_list";
    }

    /**
     * 跳转保险上传页
     */
    @RequestMapping(value = "/uploadPicture", method = RequestMethod.GET)
    public String uploadPicture (HttpServletRequest request) throws Exception {
        return "bx/upload_pictures";
    }





}
