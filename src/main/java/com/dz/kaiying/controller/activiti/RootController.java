package com.dz.kaiying.controller.activiti;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by song on 2017/1/7.
 */
@Controller
public class RootController {
    @RequestMapping(value = "/activiti")
    public String index(){
        return "indexActiviti";
    }


}
