package com.dz.kaiying.service;

import com.dz.kaiying.model.ZuoTao;
import com.dz.kaiying.repository.hiber.HibernateDao;
import com.dz.kaiying.util.Result;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by huang on 2017/7/7.
 */
//座套管理
@Service
public class ZuoTaoService extends BaseService{
    @Resource
    HibernateDao<ZuoTao, Integer> zuoTaoDao;

    private Result result = new Result();

    public Result listZT() {
        List zuoTaoList = zuoTaoDao.find("from ZuoTao");
        result.setSuccess("查询成功",zuoTaoList);
        return result;
    }


}
