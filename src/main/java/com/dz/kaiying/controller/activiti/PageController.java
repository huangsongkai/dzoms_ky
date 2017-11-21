package com.dz.kaiying.controller.activiti;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by song on 2017/3/27.
 */
@Controller
@RequestMapping(value = "/activity/page")
public class PageController {

    @RequestMapping(value="/startProcess/{key}", method= RequestMethod.GET)
    public String start(@PathVariable String key) {
        return "activiti/start";
    }

}

