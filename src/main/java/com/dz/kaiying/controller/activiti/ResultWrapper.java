package com.dz.kaiying.controller.activiti;

import com.dz.kaiying.util.Result;
import org.springframework.stereotype.Service;


/**
 * Created by song on 2017/3/27.
 */
@Service
public class ResultWrapper {
    public Result nullCheckResult(Object output){
        Result result = new Result();
        if(null == output){
            result.setFailed("null");
            return result;
        }
        result.setSuccess("", output);
        return result;
    }

    public Result success(String msg){
        return success(msg, null);
    }

    public Result success(String msg, Object data){
        Result result = new Result();
        result.setSuccess(msg, data);
        return result;
    }


    public Result error(String msg){
        Result result = new Result();
        result.setFailed(msg);
        return result;
    }

}
