package com.dz.kaiying.controller;

import com.dz.kaiying.DTO.SaveZuoTaoDTO;
import com.dz.kaiying.service.ItemService;
import com.dz.kaiying.service.ZuoTaoService;
import com.dz.kaiying.util.Result;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;


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

    @RequestMapping(value = "jumpZuoTao", method = RequestMethod.GET)
    public String jumpZuoTao(){
        return "zuotao/zuo_tao";
    }
    @RequestMapping(value = "jumpZuoTaoH", method = RequestMethod.GET)
    public String jumpZuoTaoH(){
        return "zuotao/zuo_tao_h";
    }



    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public Result listZT(){
       return zuoTaoService.listZT();
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

        return itemService.savezuotao(saveZuoTaoDTO);
    }






}
