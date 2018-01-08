package com.dz.kaiying.controller;

import com.dz.kaiying.model.DriverKpParams;
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

    @RequestMapping(value = "/calcParams", method = RequestMethod.GET)
    public String calcParams () throws Exception {
        return "driverKp/driverKpCalcParams";
    }

    @ResponseBody
    @RequestMapping(value = "/dtoList/{year}", method = RequestMethod.GET)
    public Result getDtoList (@PathVariable String year) throws Exception {
        return success("success", driverKpService.getDtosByYear(year));
    }
    @ResponseBody
    @RequestMapping(value = "/dtoList", method = RequestMethod.GET)
    public Result getDtoListDefault () throws Exception {
        return getDtoList("");
    }

    @ResponseBody
    @RequestMapping(value = "/calcParams", method = RequestMethod.POST)
    public Result postCalcParams (@RequestBody DriverKpParams driverKpParams) throws Exception {
        if(driverKpService.updateParams(driverKpParams))
            return success("success", "");
        return fail("error");
    }

    @ResponseBody
    @RequestMapping(value = "/calcParams", method = RequestMethod.GET)
    public Result getCalcParams () throws Exception {
        DriverKpParams driverKpParams = driverKpService.getCalcParams();
        if(driverKpParams == null)
            return fail("null");
        return success("success", driverKpParams);
    }
}

