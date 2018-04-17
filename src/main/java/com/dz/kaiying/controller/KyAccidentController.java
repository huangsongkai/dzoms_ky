package com.dz.kaiying.controller;

import com.dz.kaiying.service.SgService;
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
//事故Controller
@Controller
@RequestMapping(value = "/sg")
public class KyAccidentController {

    @Resource
    SgService sgService;


    @RequestMapping(value = "/querysg", method = RequestMethod.GET)
    @ResponseBody
    public Result querysg (HttpServletRequest request) throws Exception {
        Map<String,String> map = new HashMap<>();
        String cph =request.getParameter("cph");
        isEmptyParas(map,"cph",cph);
        String cxStartTime =request.getParameter("cxStartTime");
        isEmptyParas(map,"cxStartTime",cxStartTime);
        String cxEndTime =request.getParameter("cxEndTime");
        isEmptyParas(map,"cxEndTime",cxEndTime);
        String StartCreateDateTime =request.getParameter("startCreateDateTime");
        isEmptyParas(map,"startCreateDateTime",StartCreateDateTime);
        String endCreateDateTime =request.getParameter("endCreateDateTime");
        isEmptyParas(map,"endCreateDateTime",endCreateDateTime);
        return sgService.querysg(request,map);
    }
    private void isEmptyParas(Map<String, String> map, String mapName, String value) {
        if(!StringUtils.isEmpty(value)){
            map.put(mapName,value);
        }
    }

    @RequestMapping(value = "/sgExportExcel", method = RequestMethod.GET)
    public void sgExportExcel (HttpServletRequest request, HttpServletResponse response) throws Exception {
        System.out.println("   ");
        sgService.sgExportExcl(response);
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
