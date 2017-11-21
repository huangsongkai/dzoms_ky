package com.dz.kaiying.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


/**
 * Created by huang on 2017/4/17.
 */
//工具
@Controller
public class KyUtilController {
    @RequestMapping(value = "/activity/*", method = RequestMethod.GET)
    public String TZ () throws Exception {
        return "/activity/default.jsp";
    }






}
