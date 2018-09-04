package com.dz.kaiying.controller;

import com.dz.kaiying.service.ZuoTaoService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;


/**
 * Created by huang on 2017/4/17.
 */
//事故Controller
@Controller
@RequestMapping(value = "/accident")
public class AccidentController {


    @Resource
    ZuoTaoService zuoTaoService;






}
