package com.dz.kaiying.controller;

import com.dz.kaiying.service.DriverKpService;
import com.dz.kaiying.util.Result;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * Created by song on 2017/7/5.
 */
@Controller
@RequestMapping(value = "/driverKp")
public class DriverKpController extends BaseController{

    @Resource
    DriverKpService driverKpService;

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index () throws Exception {
        return "driverKp/index";
    }

    @ResponseBody
    @RequestMapping(value = "/dtoList/{ym}", method = RequestMethod.GET)
    public Result getDtoList (@PathVariable String ym) throws Exception {
        return success("success", driverKpService.getDtos(ym));
    }
    @ResponseBody
    @RequestMapping(value = "/dtoList", method = RequestMethod.GET)
    public Result getDtoListDefault () throws Exception {
        return getDtoList("");
    }
}
