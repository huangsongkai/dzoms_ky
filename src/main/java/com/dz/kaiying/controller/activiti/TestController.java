package com.dz.kaiying.controller.activiti;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by song on 2017/3/28.
 */
@RestController
@RequestMapping(value = "/test")
public class TestController {
    @RequestMapping(value="/t",method= RequestMethod.GET,produces={"application/xml", "application/json"})
    public String aaa(){
        return "aaa";

    }
}
