package com.dz.kaiying.controller;

import com.dz.kaiying.DTO.DriversAndHistoryDTO;
import com.dz.kaiying.DTO.ItemPurchaseSubmitDTO;
import com.dz.kaiying.DTO.ItemPurchaseUpadteDTO;
import com.dz.kaiying.model.Item;
import com.dz.kaiying.model.LingYongDTO;
import com.dz.kaiying.service.ActivitiUtilService;
import com.dz.kaiying.service.ItemService;
import com.dz.kaiying.util.Result;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
        return "zuotao/zuo_tao";
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
        itemService.startitem(itemId, num, "office_item_purchase", request);
        return "activity/task_list";
    }

    /**
     *  运营部采购 启动流程并传值
     */
    @RequestMapping(value = "/yybstartprocess", method = RequestMethod.GET)
    public String yybstartprocess (HttpServletRequest request) throws Exception {
        String itemId = request.getParameter("itemId");
        String num = request.getParameter("num");
        itemService.startitem(itemId, num, "operation_item_purchase", request);
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
        itemService.startitem(itemId, num, "item_grant", request);
        return "activity/task_list";
    }


//--------------------------------------------------------------------------------------------------------------------

    /**
     * 采购商品查询
     * @return
     */
    @RequestMapping(value = "/listpurchase/{state}", method = RequestMethod.GET)
    @ResponseBody
    public Result listpurchaseitem(@PathVariable String state){
        return itemService.listpurchaseitem(state);
    }
    /**
     * 商品库存修改
     * @return
     */
    @RequestMapping(value = "/listpurchase/{state}", method = RequestMethod.POST)
    @ResponseBody
    public Result listpurchaseNumUpdate(@PathVariable String state, @RequestBody ItemPurchaseUpadteDTO itemPurchaseUpadteDTO,  HttpServletRequest request){
        return itemService.listpurchaseNumUpdate(state, itemPurchaseUpadteDTO, request);
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
    /**
     * 查询车牌号
     */
    @RequestMapping(value = "/chepaihaoA", method = RequestMethod.GET)
    @ResponseBody
    public Result chepaihaoA(@RequestParam String number){
        return itemService.chepaihaoA(number);
    }
    /**
     * 领用查询
     */
    @RequestMapping(value = "/goodsList", method = RequestMethod.GET)
    @ResponseBody
    public Result goodsList(){
        return itemService.goodsList();
    }
    /**
     * 物品领用()
     */
    @RequestMapping(value = "/driversAndHistory", method = RequestMethod.GET)
    @ResponseBody
    public DriversAndHistoryDTO driversAndHistory(@RequestParam String vehicle, @RequestParam Integer itemId){
        return itemService.driversAndHistory(vehicle, itemId);
    }
    /**
     * 领用保存
     */
    @RequestMapping(value = "/submit", method = RequestMethod.POST)
    @ResponseBody
    public Result submit(@RequestBody ItemPurchaseSubmitDTO value){
        return itemService.submit(value);
    }
    /**
     * 办公室发放物品保存
     */
    @RequestMapping(value = "/TZbgslingyong1", method = RequestMethod.POST)
    @ResponseBody
    public Result submitTZbgslingyong1 (HttpServletRequest request, @RequestBody ItemPurchaseSubmitDTO value) throws Exception {
        return itemService.submitTZbgslingyong(value, request);
    }
    /**
     * 跳转运营部物品发放记录
     */
    @RequestMapping(value = "/jumpYybHistory", method = RequestMethod.GET)
    public String jumpYybHistory (HttpServletRequest request) throws Exception {
        return "item/yyb_item_history";
    }
    /**
     * 跳转办公室物品发放记录
     */
    @RequestMapping(value = "/jumpBgsHistory", method = RequestMethod.GET)
    public String jumpBgsHistory (HttpServletRequest request) throws Exception {
        return "item/bgs_item_history";
    }
    /**
     * 办公室发放物品记录 办公室state=2
     */
    @RequestMapping(value = "/officeHistory", method = RequestMethod.GET)
    @ResponseBody
    public Result officeHistory (HttpServletRequest request) throws Exception {
    String personName=request.getParameter("personName");
    String createTime=request.getParameter("createTime");
    String createEndTime=request.getParameter("createEndTime");
    String department=request.getParameter("department");
    return itemService.officeHistory(personName,createTime,createEndTime,department);
    }

    /**
     * 办公室发放物品下载
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/downloadOfficeHistory", method = RequestMethod.GET)
    public void empExportExclMonth(HttpServletResponse response)throws Exception{
        itemService.officeHistoryExportExcl(response);
    }
    /**
     * 运营部发放物品记录办公室state=1
     */
    @RequestMapping(value = "/history", method = RequestMethod.GET)
    @ResponseBody
    public Result history (HttpServletRequest request) throws Exception {
        Map<String,String> map=new HashMap<>();
        String carNumber=request.getParameter("carNumber");
        isEmptyParas(map,"carId", carNumber);
        isEmptyParas(map,"createTime", request.getParameter("createTime"));
        isEmptyParas(map,"endTime", request.getParameter("endTime"));
        isEmptyParas(map,"idNumber", request.getParameter("idNumber"));
        isEmptyParas(map,"personName", request.getParameter("personName"));
        isEmptyParas(map,"itemName", request.getParameter("itemName"));
        return itemService.history(map);
    }

    /**
     * 办公室物品出库
     */
    @RequestMapping(value = "/agree", method = RequestMethod.POST)
    @ResponseBody
    public Result agree(@RequestBody Map<String,Object> params){
        String id = params.get("id").toString();
        return itemService.agree(id);
    }
    /**
     * 办公室物品驳回
     */
    @RequestMapping(value = "/deny", method = RequestMethod.POST)
    @ResponseBody
    public Result deny(@RequestBody Map<String,Object> params){
        String id = params.get("id").toString();
        return itemService.deny(id);
    }

    private void isEmptyParas(Map<String, String> map,String mapName, String carNumber) {
        if(!StringUtils.isEmpty(carNumber)){
            map.put(mapName,carNumber);
        }
    }

    /**
     * 运营部发放物品下载
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/downloadHistory", method = RequestMethod.GET)
    public void downloadHistory(HttpServletResponse response)throws Exception{
        itemService.historyExportExcl(response);
    }

}
