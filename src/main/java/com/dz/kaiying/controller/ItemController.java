package com.dz.kaiying.controller;

import com.dz.kaiying.DTO.SaveZuoTaoDTO;
import com.dz.kaiying.model.Item;
import com.dz.kaiying.model.LingYongDTO;
import com.dz.kaiying.service.ActivitiUtilService;
import com.dz.kaiying.service.ItemService;
import com.dz.kaiying.util.Result;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by huang on 2017/4/17.
 */
@Controller
@RequestMapping(value = "/item")
public class ItemController {

    @Resource
    ItemService itemService;
    @Resource
    ActivitiUtilService activitiUtilService;


    /**
     * 启动采购流程
     * @return
     */
    @RequestMapping(value = "/startPurchase", method = RequestMethod.GET)
    @ResponseBody
    public Result startPurchase(){
        Map map = new HashMap();
        return activitiUtilService.startProcessByRuntime("item_purchase",map);
    }

    /**
     * 结束一个task
     * @return
     */
    @RequestMapping(value = "/complete", method = RequestMethod.GET)
    @ResponseBody
    public Result complete(){
        Map map = new HashMap();
        return activitiUtilService.complete("", map, null);
    }

    /**
     * 采购商品查询
     * @return
     */
    @RequestMapping(value = "/listpurchase/{state}", method = RequestMethod.GET)
    @ResponseBody
    public Result listpurchaseitem(@PathVariable String state){
        Map map = new HashMap();
        return itemService.listpurchaseitem(state);
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


    /**
     * 保运营部采购修改库存信息
     * @return
     */
    @RequestMapping(value = "/yybupateStorage", method = RequestMethod.POST)
    @ResponseBody
    public Result yybupateStorage(@RequestBody Map<Integer,String> map){

        return itemService.yybupateStorage(map);
    }

//    /**
//     * 增加库存
//     * @return
//     */
//    @RequestMapping(value = "/putStorage", method = RequestMethod.GET)
//    @ResponseBody
//    public Result putStorage(){
//        Map map = new HashMap();
//        return activitiUtilService.complete("", map, null);
//    }


    /**
     * 物品管理  1为运营部商品 2 为办公室商品
     */
    @RequestMapping(value = "/{itemState}",method = RequestMethod.GET)
    @ResponseBody
    public Result listItem(@PathVariable String itemState ){
        return itemService.listItem(itemState);
    }

    @RequestMapping(value = "/{itemState}",method = RequestMethod.PUT)
    @ResponseBody
    public Result editItem(@PathVariable String itemState, @RequestBody Item item){
        return itemService.editItem(itemState,item);
    }

    @RequestMapping(value = "/{itemId}",method = RequestMethod.DELETE)
    @ResponseBody
    public Result deleteItem(@PathVariable int[] itemId ){
        return itemService.deleteItem(itemId);
    }

    @RequestMapping(value = "/{itemState}",method = RequestMethod.POST)
    @ResponseBody
    public Result saveItem(@PathVariable String itemState, @RequestBody Item item){
        return itemService.saveItem(itemState, item);
    }


    /**
     * 运营部 物品领用查询 1为运营部商品 2 为办公室商品
     */
    @RequestMapping(value = "/queryStorage/{state}",method = RequestMethod.GET)
    @ResponseBody
    public Result lingyong(@PathVariable String state){
        return itemService.queryStorage(state);
    }


    /**
     * 运营部 物品领用记录保存
     */
    @RequestMapping(value = "/lingYong",method = RequestMethod.POST)
    @ResponseBody
    public Result SaveLingYong(@RequestBody LingYongDTO lingYongDTO){
        return itemService.saveLingYong(lingYongDTO);
    }

    /**
     * 运营部领用记录查询
     */
    @RequestMapping(value = "/lingYong",method = RequestMethod.GET)
    @ResponseBody
    public Result listLingYong(){
        return itemService.listLingYong();
    }


    /**
     * 跳转座套详细信息
     */
    @RequestMapping(value = "/listzuotao", method = RequestMethod.GET)
    public String TZListHistory (HttpServletRequest request) throws Exception {
        return "item/zuo_tao";
    }

    /**
     * 跳转运营部采购
     */
    @RequestMapping(value = "/tzyybpurchase", method = RequestMethod.GET)
    public String tzyybpurchase (HttpServletRequest request) throws Exception {
        return "item/yun_ying_cai_gou";
    }

    /**
     * 跳转办公室采购
     */
    @RequestMapping(value = "/tzbgspurchase", method = RequestMethod.GET)
    public String tzbgspurchase (HttpServletRequest request) throws Exception {
        return "item/ban_gong_cai_gou";
    }

    /**
     * 跳转运营部物品管理
     */
    @RequestMapping(value = "/yybItemManager", method = RequestMethod.GET)
    public String yybItemManager (HttpServletRequest request) throws Exception {
        return "item/yyb_item_manager";
    }

    /**
     * 跳转办公室物品管理
     */
    @RequestMapping(value = "/bgsItemManager", method = RequestMethod.GET)
    public String bgsItemManager (HttpServletRequest request) throws Exception {
        return "item/bgs_item_manager";
    }


    /**
     *  办公室采购 启动流程并传值
     */
    @RequestMapping(value = "/bgsstartprocess", method = RequestMethod.GET)
    public String bgsstartprocess (HttpServletRequest request) throws Exception {
        String itemId = request.getParameter("itemId");
        String num = request.getParameter("num");
        itemService.startitem(itemId, num, "office_item_purchase");
        return "activity/task_list";
    }

    /**
     *  运营部采购 启动流程并传值
     */
    @RequestMapping(value = "/yybstartprocess", method = RequestMethod.GET)
    public String yybstartprocess (HttpServletRequest request) throws Exception {
        String itemId = request.getParameter("itemId");
        String num = request.getParameter("num");
        itemService.startitem(itemId, num, "operation_item_purchase");
        return "activity/task_list";
    }


    /**
     * 跳转运营部物品发放记录跳转
     */
    @RequestMapping(value = "/TZitemhistory", method = RequestMethod.GET)
    public String TZitemhistory (HttpServletRequest request) throws Exception {
        return "item/item_history";
    }

    /**
     * 跳转运营部物品发放记录跳转
     */
    @RequestMapping(value = "/TZyyblingyong", method = RequestMethod.GET)
    public String TZyyblingyong (HttpServletRequest request) throws Exception {
        return "item/yyb_lingyong";
    }
    /**
     * 跳转办公室物品发放记录跳转
     */
    @RequestMapping(value = "/TZbgslingyong", method = RequestMethod.GET)
    public String TZbgslingyong (HttpServletRequest request) throws Exception {
        return "item/bgs_lingyong";
    }

    /**
     * 启动办公室发放流程
     */
    @RequestMapping(value = "/startbgsitem", method = RequestMethod.GET)
    public String startbgsitem (HttpServletRequest request) throws Exception {
        String itemId = request.getParameter("itemId");
        String num = request.getParameter("num");
        itemService.startitem(itemId, num, "item_grant");
        return "activity/task_list";
    }



}
