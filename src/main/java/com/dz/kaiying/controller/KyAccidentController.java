package com.dz.kaiying.controller;

import com.dz.kaiying.service.SgService;
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
//事故Controller
@Controller
@RequestMapping(value = "/sg")
public class KyAccidentController {

    @Resource
    SgService sgService;


    @RequestMapping(value = "/querysg", method = RequestMethod.GET)
    @ResponseBody
    public Result querysg () throws Exception {
        return sgService.querysg();
    }


    //事故信息导出
    @RequestMapping(value = "/exportExcel", method = RequestMethod.GET)
    public Result sgexportExcel (HttpServletRequest request, HttpServletResponse response) throws Exception {
        System.out.println("   ");
        return sgService.exportExcel(request, response);
    }


    //事故信息导入
    @RequestMapping(value = "/importExcel", method = RequestMethod.POST)
    public String sgimportExcel (HttpServletRequest request) throws Exception {
        System.out.println("");
        return sgService.importExcel(request);
    }


    /**
     * 跳转事故展示页
     */
    @RequestMapping(value = "/listsg", method = RequestMethod.GET)
    public String TZListHistory (HttpServletRequest request) throws Exception {
        return "sg/accident_list";
    }

    /**
     * 跳转事故上传页
     */
    @RequestMapping(value = "/uploadPicture", method = RequestMethod.GET)
    public String uploadPicture (HttpServletRequest request) throws Exception {
        return "sg/upload_pictures";
    }







}
