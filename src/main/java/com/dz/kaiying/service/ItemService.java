package com.dz.kaiying.service;

import com.dz.kaiying.DTO.ItemReceiveDTO;
import com.dz.kaiying.DTO.SaveZuoTaoDTO;
import com.dz.kaiying.DTO.SaveZuoTaoDetailDTO;
import com.dz.kaiying.model.*;
import com.dz.kaiying.repository.hiber.HibernateDao;
import com.dz.kaiying.util.Result;
import com.dz.module.user.User;
import org.activiti.engine.*;
import org.activiti.engine.task.Task;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
* Created by song.
*/
@Service
public class ItemService extends BaseService{

    //流程相关
    @Resource
    RuntimeService runtimeService;
    @Resource
    ProcessEngine processEngine;
    @Resource
    TaskService taskService;
    @Resource
    RepositoryService repositoryService;
    @Resource
    HistoryService historyService;
    @Resource
    ActivitiUtilService activitiUtilService;




    @Resource
    HibernateDao<JobDuty, Integer> jobDutiesDao;
    @Resource
    HibernateDao<User, Integer> userDao;
    @Resource
    HibernateDao<Storage, Integer> storageDao;

    @Resource
    HibernateDao<Item, Integer> itemDao;
    @Resource
    HibernateDao<LingYong, Integer>lingYongDao;
    @Resource
    HibernateDao<ZuoTao, Integer> zuoTaoDao;







    private Result result = new Result();

    /**
     * 采购流程 进入办公室
     * @param task
     * @param eventName
     */
    public void putStorage(Task task, String eventName){

        String itemId = (String) taskService.getVariable(task.getId() + "", "商品id");
        String num = (String) taskService.getVariable(task.getId() + "", "数量");
//        String processInstanceId = task.getProcessInstanceId();
//        Map<String, Object> map = new HashMap<String, Object>();
//        List<HistoricVariableInstance> historyVariableList = historyService.createHistoricVariableInstanceQuery().processInstanceId(processInstanceId).list();
//        if (historyVariableList.size() != 0){
//            for (HistoricVariableInstance variableInstance : historyVariableList) {
//                map.put(variableInstance.getVariableName(),variableInstance.getValue() );
//                System.out.println("variable: " + variableInstance.getVariableName() + " = " + variableInstance.getValue());
//            }
//            String item_id = map.get("item_id").toString();
//            String purchase_num = map.get("purchase_num").toString();
            List stairStorageList = storageDao.find("from Storage where itemId = "+itemId);
            if (stairStorageList.size() != 0){
                Storage stairStorage = (Storage) stairStorageList.get(0);
                stairStorage.setItemTotalNum(stairStorage.getItemTotalNum()+Integer.parseInt(num));
                stairStorage.setItemPurchasingPrice(1.1);
                stairStorage.setState("1");
                storageDao.update(stairStorage);
            }else{
                Storage stairStorage = new Storage();
                stairStorage.setItemId(Integer.parseInt(itemId));
                stairStorage.setItemPurchasingPrice(1.1);
                stairStorage.setState("2");
                //stairStorage.setId("1");
                stairStorage.setItemTotalNum(Integer.parseInt(num));
                storageDao.save(stairStorage);
            }

    }



    /**
     * 办公室审批出库
     * @param task
     * @param eventName
     */
    public void deleteStorage(Task task, String eventName){

        String itemId = (String) taskService.getVariable(task.getId() + "", "商品id");
        String num = (String) taskService.getVariable(task.getId() + "", "数量");



        LingYong lingYong = new LingYong();
        List<Storage> storageList = storageDao.find("from Storage where state = '2' and itemId = "+itemId);
        if (storageList.size() != 0){
            Integer storageCount = storageList.get(0).getItemTotalNum();
            if (storageCount>=Integer.parseInt(num)){
                storageList.get(0).setItemTotalNum(storageCount-Integer.parseInt(num));
                storageDao.update(storageList.get(0));
            }else{
                result.setFailed("库存不足");
            }
        }else{
            result.setFailed("库存不足");
        }
        result.setSuccess("保存成功",null);
    }




    /**
     * 采购流程 进入运营部
     * @param task
     * @param eventName
     */
    public void putStorage1(Task task, String eventName){

        String itemId = (String) taskService.getVariable(task.getId() + "", "商品id");
        String num = (String) taskService.getVariable(task.getId() + "", "数量");
//        String processInstanceId = task.getProcessInstanceId();
//        Map<String, Object> map = new HashMap<String, Object>();
//        List<HistoricVariableInstance> historyVariableList = historyService.createHistoricVariableInstanceQuery().processInstanceId(processInstanceId).list();
//        if (historyVariableList.size() != 0){
//            for (HistoricVariableInstance variableInstance : historyVariableList) {
//                map.put(variableInstance.getVariableName(),variableInstance.getValue() );
//                System.out.println("variable: " + variableInstance.getVariableName() + " = " + variableInstance.getValue());
//            }
//            String item_id = map.get("item_id").toString();
//            String purchase_num = map.get("purchase_num").toString();
        List stairStorageList = storageDao.find("from Storage where itemId = "+itemId);
        if (stairStorageList.size() != 0){
            Storage stairStorage = (Storage) stairStorageList.get(0);
            stairStorage.setItemTotalNum(stairStorage.getItemTotalNum()+Integer.parseInt(num));
            stairStorage.setItemPurchasingPrice(1.1);
            stairStorage.setState("1");
            storageDao.update(stairStorage);
        }else{
            Storage stairStorage = new Storage();
            stairStorage.setItemId(Integer.parseInt(itemId));
            stairStorage.setItemPurchasingPrice(1.1);
            stairStorage.setState("1");
            //stairStorage.setId("1");
            stairStorage.setItemTotalNum(Integer.parseInt(num));
            storageDao.save(stairStorage);
        }

    }

    public Result queryStorage(String state) {
        List<ItemReceiveDTO>  itemReceiveDTOList = new ArrayList<>();
        List<Storage> StorageList = storageDao.find("from Storage where state = '"+state+"' "); //运营部物品
        for (Storage l1Storage : StorageList) {
            List<Item> itemList = itemDao.find("from Item where id =" + l1Storage.getItemId());
            ItemReceiveDTO itemReceiveDTO = new ItemReceiveDTO();
            itemReceiveDTO.setItemId(l1Storage.getItemId());
            itemReceiveDTO.setItemName(itemList.get(0).getItemName());
            itemReceiveDTO.setItemPurchasingPrice(l1Storage.getItemPurchasingPrice());
            itemReceiveDTO.setItemRemarks(l1Storage.getItemRemarks());
            itemReceiveDTO.setItemTotalNum(l1Storage.getItemTotalNum());
            itemReceiveDTO.setItemType(itemList.get(0).getItemType());
            itemReceiveDTO.setItemUnit(itemList.get(0).getItemUnit());
            itemReceiveDTOList.add(itemReceiveDTO);
        }
        result.setSuccess("查询成功",itemReceiveDTOList);
        return result;
    }

    public Result saveLingYong(LingYongDTO lingYongDTO) {
        LingYong lingYong = new LingYong();
        lingYong.setItemId(lingYongDTO.getItemId());
        List<Storage> storageList = storageDao.find("from Storage where state = '1' and itemId = "+lingYongDTO.getItemId());
        if (storageList.size() != 0){
            Integer storageCount = storageList.get(0).getItemTotalNum();
            if (storageCount>=lingYongDTO.getCount()){
                storageList.get(0).setItemTotalNum(storageCount-lingYongDTO.getCount());
                storageDao.update(storageList.get(0));
            }else{
                result.setFailed("库存不足");
                return result;
            }
        }else{
            result.setFailed("库存不足");
            return result;
        }
        lingYong.setCarId(lingYongDTO.getCarId());
        lingYong.setCount(lingYongDTO.getCount());
        lingYong.setIdNumber(lingYongDTO.getIdNumber());
        lingYong.setPersonName(lingYongDTO.getRecipient());
        lingYongDao.save(lingYong);
        result.setSuccess("保存成功",null);
        return result;
    }

    public Result listLingYong() {
        List lingYongList = lingYongDao.find("from LingYong");
        result.setSuccess("查询成功",lingYongList);
        return result;
    }

    public Result listItem(String itemState) {
        List<Item> item = itemDao.find("from Item where itemState =" + itemState);
        result.setSuccess("查询成功",item);
        return result;
    }

    public Result editItem(String itemState, Item item) {
         item.setItemState(itemState);
         itemDao.update(item);
        result.setSuccess("修改成功",item);
        return result;
    }

    public Result deleteItem(int[] itemId) {
        for ( int item: itemId) {
            itemDao.deleteByKey(Item.class,item);
        }

        result.setSuccess("删除成功",null);
        return result;
    }

    public Result saveItem(String itemState, Item item) {
        item.setItemState(itemState);
        itemDao.save(item);
        result.setSuccess("保存成功",item);
        return result;
    }

    public Result listpurchaseitem(String itemState) {
        List<Item> itemList = itemDao.find("from Item where itemState =" + itemState);
        List<ItemReceiveDTO> itemReceive = new ArrayList<>();
        for (Item item : itemList) {
            ItemReceiveDTO itemReceiveDTO = new  ItemReceiveDTO();
            List StorageList = storageDao.find("from Storage where itemId = "+item.getId());
            if (StorageList.size() != 0){
                Storage storage = (Storage) StorageList.get(0);
                itemReceiveDTO.setItemPurchasingPrice(storage.getItemPurchasingPrice());
                itemReceiveDTO.setItemRemarks(storage.getItemRemarks());
                itemReceiveDTO.setItemTotalNum(storage.getItemTotalNum());
            }else{
                itemReceiveDTO.setItemPurchasingPrice(0.0);
                itemReceiveDTO.setItemRemarks("");
                itemReceiveDTO.setItemTotalNum(0);
            }
            itemReceiveDTO.setItemId(item.getId());
            itemReceiveDTO.setItemUnit(item.getItemUnit());
            itemReceiveDTO.setItemName(item.getItemName());
            itemReceiveDTO.setItemType(item.getItemType());
            itemReceive.add(itemReceiveDTO);
        }

        result.setSuccess("查询成功",itemReceive);
        return result;

    }

    public Result startitem(String itemId, String num, String processName) {
        List<Item> itemList = itemDao.find("from Item where id =" + itemId);
        Map map = new HashMap();
        map.put("商品id",itemId);
        map.put("数量",num);
        map.put("商品名称",itemList.get(0).getItemName());
        activitiUtilService.startProcessByRuntime(processName,map);
        result.setSuccess("流程启动成功",null);
        return result;
    }

    public Result savezuotao(SaveZuoTaoDTO saveZuoTaoDTO) {
        SaveZuoTaoDetailDTO saveZuoTaoDetailDTO = saveZuoTaoDTO.getIssueType();
        ZuoTao zuotao = new ZuoTao();
        zuotao.setCph(saveZuoTaoDTO.getCph());
        zuotao.setEmployeeId(saveZuoTaoDTO.getEmployeeId());
        zuotao.setDzps(saveZuoTaoDetailDTO.getDzps()+"");
        zuotao.setDzwz(saveZuoTaoDetailDTO.getDzwz()+"");
        zuotao.setXzps(saveZuoTaoDetailDTO.getXzps()+"");
        zuotao.setXzwz(saveZuoTaoDetailDTO.getXzwz()+"");
        zuoTaoDao.save(zuotao);
        result.setSuccess("保存成功",null);
        return result;
    }

    public Result yybupateStorage(Map<Integer, String> map) {

        for(Map.Entry<Integer, String> entry : map.entrySet())
        {
            List<Storage> storageList = storageDao.find("from Storage where state = '1' and itemId = "+entry.getKey());
            if (storageList.size() != 0){
                Storage stairStorage = (Storage) storageList.get(0);
                stairStorage.setItemTotalNum(Integer.parseInt(entry.getValue()));
                stairStorage.setItemPurchasingPrice(1.1);
                stairStorage.setState("1");
                storageDao.update(stairStorage);
            }else{
                Storage stairStorage = new Storage();
                stairStorage.setItemId((Integer)entry.getKey());
                stairStorage.setItemPurchasingPrice(1.1);
                stairStorage.setState("2");
                //stairStorage.setId("1");
                stairStorage.setItemTotalNum(Integer.parseInt(entry.getValue()));
                storageDao.save(stairStorage);
            }
            System.out.println(entry.getKey() + " = " + entry.getValue());
        }
        result.setSuccess("库存修改成功",null);
        return result;
    }
}