package com.dz.kaiying.controller;

import com.dz.kaiying.DTO.SaveZuoTaoDTO;
import com.dz.kaiying.service.ItemService;
import com.dz.kaiying.service.ZuoTaoService;
import com.dz.kaiying.util.Result;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;


/**
 * Created by huang on 2017/4/17.
 */
@Controller
@RequestMapping(value = "/zt")
public class ZuoTaoController {


    @Resource
    ZuoTaoService zuoTaoService;
    @Resource
    ItemService itemService;

    @RequestMapping(value = "/jumpZuoTao", method = RequestMethod.GET)
    public String jumpZuoTao(){
        return "zuotao/zuo_tao";
    }
    @RequestMapping(value = "/jumpZuoTaoH", method = RequestMethod.GET)
    public String jumpZuoTaoH(){
        return "zuotao/zuo_tao_h";
    }


    /**
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    public Result listZT(HttpServletRequest request){
        Map<String,String> map=new HashMap<>();
        isEmptyParas(map,"createTime", request.getParameter("createTime"));
        isEmptyParas(map,"endTime", request.getParameter("endTime"));
        String carNumber=request.getParameter("carNumber");
        isEmptyParas(map,"cph",carNumber );
        isEmptyParas(map,"employeeId", request.getParameter("employeeId"));
       return zuoTaoService.listZT(map);
    }
    private void isEmptyParas(Map<String, String> map,String mapName, String carNumber) {
        if(!StringUtils.isEmpty(carNumber)){
            map.put(mapName,carNumber);
        }
    }

    //座套信息导出
    @RequestMapping(value = "/ZTexportExcel", method = RequestMethod.GET)
    public Result sgexportExcel (HttpServletRequest request, HttpServletResponse response) throws Exception {
        return zuoTaoService.ZTExportExcel(request, response);
    }
    /**
     * 查询车牌号
     */
    @RequestMapping(value = "/chepaihaoA", method = RequestMethod.GET)
    @ResponseBody
    public Result chepaihaoA(@RequestParam String number){
        return itemService.chepaihaoA(number);
    }

    /**
     * 保存座套信息
     * @return
     */
    @RequestMapping(value = "/zuotao", method = RequestMethod.POST)
    @ResponseBody
    public Result savezuotao(@RequestBody SaveZuoTaoDTO saveZuoTaoDTO){
        saveZuoTaoDTO.setCreateDate(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date()));
        return itemService.savezuotao(saveZuoTaoDTO);
    }






}
