package com.dz.kaiying.controller;

import com.dz.kaiying.util.Result;

/**
 * Created by song on 2017/7/5.
 */
public class BaseController {
    Result success(String msg, Object o){
        Result result = new Result();
        result.setSuccess(msg, o);
        return result;
    }

    Result fail(String msg){
        Result result = new Result();
        result.setFailed(msg);
        return result;
    }
}
