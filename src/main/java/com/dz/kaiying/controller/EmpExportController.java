package com.dz.kaiying.controller;

import com.dz.kaiying.service.EmpExportService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by 24244 on 2018/3/7.
 */
@Controller
@RequestMapping(value = "/duty2")
public class EmpExportController {
    @Resource
    EmpExportService empExportService;

    @RequestMapping(value = "/monthStatistics", method = RequestMethod.GET)
    public void empExportExcl(HttpServletResponse response)throws Exception{
        empExportService.monthAssessmentExportExcl(response);
    }
}
