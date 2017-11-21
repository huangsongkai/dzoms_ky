package com.dz.kaiying.controller;

import com.dz.kaiying.service.ZuoTaoService;
import com.dz.kaiying.util.Result;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;


/**
 * Created by huang on 2017/4/17.
 */
@Controller
@RequestMapping(value = "/zt")
public class ZuoTaoController {


    @Resource
    ZuoTaoService zuoTaoService;


    @RequestMapping(value = "", method = RequestMethod.GET)
    public Result listZT(){
       return zuoTaoService.listZT();
    }




}
