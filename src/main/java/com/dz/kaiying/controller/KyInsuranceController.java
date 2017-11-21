package com.dz.kaiying.controller;

import com.dz.kaiying.service.BxService;
import com.dz.kaiying.util.Result;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Created by huang on 2017/4/17.
 */
//保险Controller
@Controller
@RequestMapping(value = "/bx")
public class KyInsuranceController {

    @Resource
    BxService bxService;


    @RequestMapping(value = "/querybx", method = RequestMethod.GET)
    @ResponseBody
    public Result querybx () throws Exception {
        return bxService.querybx();
    }


    //保险信息导出
    @RequestMapping(value = "/exportExcel", method = RequestMethod.GET)
    public Result sgexportExcel (HttpServletRequest request, HttpServletResponse response) throws Exception {
        System.out.println("   ");
        return bxService.exportExcel(request, response);
    }

    //事故信息导入
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
