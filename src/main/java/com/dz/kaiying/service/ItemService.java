package com.dz.kaiying.service;

import com.dz.kaiying.DTO.*;
import com.dz.kaiying.model.*;
import com.dz.kaiying.repository.hiber.HibernateDao;
import com.dz.kaiying.util.Result;
import com.dz.module.driver.Driver;
import com.dz.module.user.User;
import com.dz.module.vehicle.Vehicle;
import org.activiti.engine.*;
import org.activiti.engine.task.Task;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.*;

/**
* Created by song.
*/
@Service
public class ItemService extends BaseService{
    //@Resource
    //private IItemDao iItemDao;

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
    @Resource
    HibernateDao<ItemPurchaseRecord, Integer> itemPurchaseRecordDao;
    @Resource
    HibernateDao<Vehicle, Integer> vehicleDao1;
    @Resource
    HibernateDao<Driver, Integer> diverDao;

    private static Map<Integer,ItemsOutDTO> officePort =new HashMap<>();

    private static Map<Integer,OperItemsOutDTO> history =new HashMap<>();

    private SimpleDateFormat sformat=new SimpleDateFormat("yyyy-MM-dd");

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

    public Result startitem(String itemId, String num, String processName, HttpServletRequest request) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String userName = user.getUname();
        List<Item> itemList = itemDao.find("from Item where id =" + itemId);
        Map map = new HashMap();
        map.put("商品id",itemId);
        map.put("数量",num);
        map.put("商品名称",itemList.get(0).getItemName());
        map.put("userName1", userName);
        activitiUtilService.startProcessByRuntime(processName,map);
        result.setSuccess("流程启动成功",null);
        return result;
    }

    public Result savezuotao(SaveZuoTaoDTO saveZuoTaoDTO) {
        //SimpleDateFormat sdf  = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        SaveZuoTaoDetailDTO saveZuoTaoDetailDTO = saveZuoTaoDTO.getIssueType();
        ZuoTao zuotao = new ZuoTao();
        zuotao.setCph(saveZuoTaoDTO.getCph());
        zuotao.setEmployeeId(saveZuoTaoDTO.getEmployeeId());
        zuotao.setDzps(saveZuoTaoDetailDTO.getDzps()+"");
        zuotao.setDzwz(saveZuoTaoDetailDTO.getDzwz()+"");
        zuotao.setXzps(saveZuoTaoDetailDTO.getXzps()+"");
        zuotao.setXzwz(saveZuoTaoDetailDTO.getXzwz()+"");
        if (saveZuoTaoDTO.getCreateDate()!=null)
            zuotao.setCreateTime(saveZuoTaoDTO.getCreateDate());
        else
            zuotao.setCreateTime("");
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

    public Result listpurchaseNumUpdate(String state, ItemPurchaseUpadteDTO itemPurchaseUpadteDTO, HttpServletRequest request) {
        List<Storage> storageList = storageDao.find("from Storage where state = '"+state+"' and itemId = "+itemPurchaseUpadteDTO.getItemId());
        if (storageList.size() != 0){
            Storage stairStorage = (Storage) storageList.get(0);
            stairStorage.setItemTotalNum(stairStorage.getItemTotalNum()+itemPurchaseUpadteDTO.getNum());
            stairStorage.setItemPurchasingPrice(1.1);
            stairStorage.setState(state);
            storageDao.update(stairStorage);
        }else{
            Storage stairStorage = new Storage();
            stairStorage.setItemId(itemPurchaseUpadteDTO.getItemId());
            stairStorage.setItemPurchasingPrice(1.1);
            stairStorage.setState(state);
            stairStorage.setItemTotalNum(itemPurchaseUpadteDTO.getNum());
            storageDao.save(stairStorage);
        }
        //修改库存记录
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        ItemPurchaseRecord itemPurchaseRecord = new ItemPurchaseRecord();
        itemPurchaseRecord.setItemId(itemPurchaseUpadteDTO.getItemId());
        itemPurchaseRecord.setItemRemarks(itemPurchaseUpadteDTO.getRemark());
        itemPurchaseRecord.setItemState(state);
        itemPurchaseRecord.setName(user.getUname());
        itemPurchaseRecord.setItemNum(itemPurchaseUpadteDTO.getNum());
        itemPurchaseRecord.setDate(new Date());
        itemPurchaseRecordDao.save(itemPurchaseRecord);
        result.setSuccess("库存修改成功",null);
        return result;
    }

    public Result goodsList() {
        List<Item> itemList = itemDao.find("from Item where itemState = 1 ");
        List<Testlocal> itemReceive = new ArrayList<>();
        for (Item item : itemList) {
            Testlocal itemReceiveDTO = new  Testlocal();
            List StorageList = storageDao.find("from Storage where itemId = "+item.getId());
            if (StorageList.size() != 0){
                Storage storage = (Storage) StorageList.get(0);
                itemReceiveDTO.setItemPurchasingPrice(storage.getItemPurchasingPrice()+"");
                itemReceiveDTO.setItemRemarks(item.getItemRemarks());
                itemReceiveDTO.setItemTotalNum(storage.getItemTotalNum()+"");
            }else{
                itemReceiveDTO.setItemPurchasingPrice("");
                itemReceiveDTO.setItemRemarks("");
                itemReceiveDTO.setItemTotalNum("");
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

    public Result chepaihaoA(String number) {
        List<String> chepai =  vehicleDao1.find("select licenseNum from Vehicle where licenseNum like'%"+number+"%' ");
        result.setSuccess("查询成功",chepai);
        return result;
    }

    public DriversAndHistoryDTO driversAndHistory(String vehicle, Integer itemId) {
        DriversAndHistoryDTO driversAndHistoryDTO = new DriversAndHistoryDTO();
        List<DriversPurchase> driversPurchaseList = new ArrayList<>();
        List<History1> historyList = new ArrayList<>();
        //驾驶员信息
        List<Vehicle> vehicleList =  vehicleDao1.find(" from Vehicle where licenseNum = '"+vehicle+"' ");
        for (Vehicle vehicle1 : vehicleList) {
            List<Driver> driverList = diverDao.find("from Driver where carframeNum = '"+vehicle1.getCarframeNum()+"'");
            for (Driver driver : driverList) {
                DriversPurchase drivers = new DriversPurchase();
                drivers.setName(driver.getName());
                drivers.setId(driver.getIdNum()+"");
                driversPurchaseList.add(drivers);
            }
        }
        //领取历史查询
        List<LingYong> lingYongList= lingYongDao.find(" from LingYong where carId = '"+vehicle+"' and itemId = "+itemId+"");
        for (LingYong lingYong : lingYongList) {
            History1 history = new History1();
            history.setDriverName(lingYong.getPersonName());
            List<Item> itemList = itemDao.find("from Item where id = "+itemId+" ");
            Item item = itemList.get(0);
            history.setItemName(item.getItemName());
            history.setDriverName(lingYong.getPersonName());
            history.setItemType(item.getItemType());
            history.setNumber(lingYong.getCount()+"");
            history.setTime(lingYong.getDate()+"");
            historyList.add(history);
        }
        driversAndHistoryDTO.setDrivers(driversPurchaseList);
        driversAndHistoryDTO.setHistory(historyList);
        return driversAndHistoryDTO;

    }

    public Result submit(ItemPurchaseSubmitDTO value) {
        List<Storage> storageList = storageDao.find("from Storage where itemId = "+value.getItemId());
        //扣库存
        if (storageList.size() != 0){
            Storage stairStorage = (Storage) storageList.get(0);
            if (stairStorage.getItemTotalNum()>=value.getCount()){
                stairStorage.setItemTotalNum(stairStorage.getItemTotalNum() - value.getCount());
                storageDao.update(stairStorage);
                //保存领用记录
                LingYong lingYong = new LingYong();
                lingYong.setDate(new Date());
                lingYong.setCarId(value.getCarNumber());
                lingYong.setCount(value.getCount());
                lingYong.setIdNumber(value.getIdNumber());
                lingYong.setItemId(value.getItemId());
                lingYong.setPersonName(value.getRecipient());
                lingYong.setState0(1);
                lingYongDao.save(lingYong);
                result.setSuccess("领用成功",null);
            }else {
                result.setFailed("库存不足领用失败");
            }
        }else{
            result.setFailed("库存不足领用失败");
        }
        return result;
    }

    public Result submitTZbgslingyong(ItemPurchaseSubmitDTO value, HttpServletRequest request) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String userName = user.getUname();
        //保存领用记录
        LingYong lingYong = new LingYong();
        lingYong.setDate(new Date());
        lingYong.setCount(value.getNum());
        lingYong.setItemId(value.getItemId());
        lingYong.setPersonName(userName);
        lingYong.setState0(2);
        lingYong.setState(0);
        lingYongDao.save(lingYong);
        result.setSuccess("领用成功",lingYong);
        return result;
    }

    /**
     * 运营部发放物品
     * @param values
     * @return
     */
    public Result history(Map<String,String> values) {
        List<LingYong> lingyongList = new ArrayList<>();
        String sql= "from LingYong where state0 = 1 ";
        if(!StringUtils.isEmpty(values.get("createTime"))){
            sql+="and date BETWEEN '"+values.get("createTime")+"' and '"+values.get("endTime")+"'";
        }
        for (String name:values.keySet()) {
            switch (name){
                case "carId": sql+=addSql(name,values);
                    break;
                case "idNumber": sql+=addSql(name,values);
                    break;
                case "personName": sql+=addSql(name,values);
                    break;
            }
        }
        lingyongList = lingYongDao.find(sql);
        List<OperItemsOutDTO> listItems = new ArrayList<>();
        if(lingyongList.size()>0) {
            listItems = getOperItemsOutDTOs(values.get("itemName") == null ? "":values.get("itemName"), lingyongList);
        }
            if(listItems.size()>0) {
            history.clear();
            for (int i = 1; i <= listItems.size(); i++) {    //存入缓存
                history.put(i, listItems.get(i - 1));
            }
        }
        result.setSuccess("成功",listItems);
        return result;
    }
    private List<OperItemsOutDTO> getOperItemsOutDTOs(String itemName,List<LingYong> ly){
        List<OperItemsOutDTO> listItems  = new ArrayList<>();
        if (StringUtils.isEmpty(itemName)) {
            for (LingYong lingyong : ly) {
                List<Item> itemList = itemDao.find("from Item where id = " + lingyong.getItemId());
                OperItemsOutDTO itemsOut = new OperItemsOutDTO();
                itemsOut.setId(lingyong.getId());
                itemsOut.setPersonName(lingyong.getPersonName());
                itemsOut.setItemName(itemList == null ? "" : itemList.get(0).getItemName());
                itemsOut.setCount(lingyong.getCount() == null ? 0 : lingyong.getCount() );
                if(lingyong.getDate() == null){
                    itemsOut.setTime("");
                }else{

                    itemsOut.setTime(lingyong.getDate().toString());
                }
                itemsOut.setIdNumber(lingyong.getIdNumber());
                itemsOut.setCarId(lingyong.getCarId());
                itemsOut.setState(lingyong.getState());
                if(lingyong.getApplyTime() == null){
                    itemsOut.setApplyTime("");
                }else{
                    itemsOut.setApplyTime(lingyong.getApplyTime().toString());
                }

                listItems.add(itemsOut);
            }
            return listItems;
        }
        for (LingYong lingyong : ly) {
            List<Item> itemList = itemDao.find("from Item where id = " + lingyong.getItemId());
           if (!itemName.trim().equals(itemList.get(0).getItemName())) {
                continue;
            }
            OperItemsOutDTO itemsOut = new OperItemsOutDTO();
            itemsOut.setId(lingyong.getId());
            itemsOut.setPersonName(lingyong.getPersonName());
            itemsOut.setItemName(itemList == null ? "" : itemList.get(0).getItemName());
            itemsOut.setCount(lingyong.getCount() == null ? 0 : lingyong.getCount());
            if(lingyong.getDate() == null){
                itemsOut.setTime("");
            }else{
                itemsOut.setTime(lingyong.getDate().toString());
            }
            itemsOut.setIdNumber(lingyong.getIdNumber());
            itemsOut.setCarId(lingyong.getCarId());
            itemsOut.setState(lingyong.getState());
            if(lingyong.getApplyTime() == null){
                itemsOut.setApplyTime("");
            }else{
                itemsOut.setApplyTime(lingyong.getApplyTime().toString());
            }
            listItems.add(itemsOut);
        }
        return listItems;
    }
    private String addSql(String values, Map<String,String> map) {
        if(!StringUtils.isEmpty(map.get(values))){
            return " and "+values+" = '"+map.get(values)+"'";
        }
        return "";
    }

    /**
     * 办公室发放物品下载
     */
    public void officeHistoryExportExcl(HttpServletResponse response)throws Exception{
        if (officePort.size()==0)return;   //如果为空无法下载
        EmpExportService export=new EmpExportService();
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet = wb.createSheet();
        HSSFCellStyle style = getHssfCellStyle(wb);   //设置字体格式
        Row row = sheet.createRow((short) 0);
        Cell cel0=row.createCell(0);
        cel0.setCellStyle(style);
        cel0.setCellValue("编号");
        Cell cel1=row.createCell(1);
        cel1.setCellStyle(style);
        cel1.setCellValue("领用人姓名");
        Cell cel2=row.createCell(2);
        cel2.setCellStyle(style);
        cel2.setCellValue("部门");
        Cell cel3=row.createCell(3);
        cel3.setCellStyle(style);
        cel3.setCellValue("物品名");
        Cell cel4=row.createCell(4);
        cel4.setCellStyle(style);
        cel4.setCellValue("数量");
        Cell cel5=row.createCell(5);
        cel5.setCellStyle(style);
        cel5.setCellValue("时间");

        for (Map.Entry<Integer, ItemsOutDTO> entry : officePort.entrySet()) {
            Row row1 = sheet.createRow(entry.getKey());
            row1.createCell(0).setCellValue(entry.getValue().getId());
            row1.createCell(1).setCellValue(entry.getValue().getPersonName());
            row1.createCell(2).setCellValue(entry.getValue().getDepartment());
            row1.createCell(3).setCellValue(entry.getValue().getItemName());
            row1.createCell(4).setCellValue(entry.getValue().getCount());
            row1.createCell(5).setCellValue(entry.getValue().getTime());
        }
        /*officePort.forEach(key,value)->{};*/
        export.IOWriteExcel(response,wb,"办公室发放物品.xls");
    }

    /**
     * 运营部发放物品下载
     * @param rep
     */
    public void historyExportExcl(HttpServletResponse rep)throws Exception{
        if (history.size()==0)return;   //如果为空无法下载
        EmpExportService export=new EmpExportService();
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet = wb.createSheet();
        HSSFCellStyle style = getHssfCellStyle(wb);   //设置字体格式
        Row row = sheet.createRow((short) 0);
        Cell cel0=row.createCell(0);
          cel0.setCellStyle(style);
          cel0.setCellValue("编号");
        Cell cel1=row.createCell(1);
          cel1.setCellStyle(style);
          cel1.setCellValue("领用人姓名");
        Cell cel2=row.createCell(2);
          cel2.setCellStyle(style);
          cel2.setCellValue("物品名");
        Cell cel3=row.createCell(3);
          cel3.setCellStyle(style);
          cel3.setCellValue("身份证");
        Cell cel4=row.createCell(4);
          cel4.setCellStyle(style);
          cel4.setCellValue("车牌号");
        Cell cel6=row.createCell(6);
          cel6.setCellStyle(style);
          cel6.setCellValue("时间");
        Cell cel5=row.createCell(5);
          cel5.setCellStyle(style);
          cel5.setCellValue("数量");

        for (Map.Entry<Integer, OperItemsOutDTO> entry : history.entrySet()) {
            Row row1 = sheet.createRow(entry.getKey());
            row1.createCell(0).setCellValue(entry.getValue().getId());
            row1.createCell(1).setCellValue(entry.getValue().getPersonName());
            row1.createCell(2).setCellValue(entry.getValue().getItemName());
            row1.createCell(3).setCellValue(entry.getValue().getIdNumber());
            row1.createCell(4).setCellValue(entry.getValue().getCarId());
            row1.createCell(5).setCellValue(entry.getValue().getCount());
            row1.createCell(6).setCellValue(entry.getValue().getTime());
        }
        export.IOWriteExcel(rep,wb,"运营部发放物品.xls");


    }

    /**
     * 设置Excel字体格式
     * @param wb
     * @return
     */
    private HSSFCellStyle getHssfCellStyle(HSSFWorkbook wb) {
        HSSFFont font =  wb.createFont();
        font.setFontHeightInPoints((short)12);            //设置字体的大小
        font.setFontName("微软雅黑");                        //设置字体的样式，如：宋体、微软雅黑等
        font.setItalic(false);                            //斜体true为斜体
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);    //对文中进行加粗
        font.setColor(HSSFColor.BLACK.index);            //设置字体的颜色
        HSSFCellStyle style = wb.createCellStyle();
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 居中
        style.setFont(font);
        return style;
    }

    //办公室领用物品
    public Result officeHistory(String personName,String starTime,String endTime,String department) {
        List<LingYong> lingyongList = new ArrayList<>();
        String sql= "from LingYong where state0 = 2 ";
        if((!StringUtils.isEmpty(starTime))&&(!StringUtils.isEmpty(endTime))){
            sql+="and date BETWEEN '"+starTime+"' and '"+endTime+"'";
        }
        if(personName!=null&&personName.trim()!=""){
            sql+=" and personName like '%"+personName+"%'";
        }
            lingyongList = lingYongDao.find(sql);
        List<ItemsOutDTO> listItems = new ArrayList<>();
        if(lingyongList.size() > 0) {
            listItems = getItemsOutDTOs(department, lingyongList);
            if(listItems.size()>0) {
                officePort.clear();
                for (int i = 1; i <= listItems.size(); i++) {    //存入缓存
                    officePort.put(i, listItems.get(i - 1));
                }
            }
        }
        result.setSuccess("成功",listItems);
        return result;
    }

    private List<ItemsOutDTO> getItemsOutDTOs(String department, List<LingYong> lingyongList) {
        List<ItemsOutDTO> listItems = new ArrayList<>();
        if (department == null || department.trim() == "") {
            for (LingYong lingyong : lingyongList) {
                List<User> userList = userDao.find("from User where uname ='" + lingyong.getPersonName() + "'");
                if(userList.size()>0){
                    User user = userList.get(0);
                    List<Item> itemList = itemDao.find("from Item where id = " + lingyong.getItemId());
                    ItemsOutDTO itemsOut = new ItemsOutDTO();
                    itemsOut.setId(lingyong.getId());
                    itemsOut.setCount(lingyong.getCount());
                    itemsOut.setItemName(itemList.get(0).getItemName());
                    itemsOut.setPersonName(lingyong.getPersonName());
                    itemsOut.setTime(sformat.format(lingyong.getDate()));
                    itemsOut.setDepartment(user.getDepartment().trim());
                    itemsOut.setState(lingyong.getState());
                    itemsOut.setData(lingyong.getDate()+"");
                    itemsOut.setApplyTime(lingyong.getApplyTime()+"");
                    listItems.add(itemsOut);
                }
            }
            return listItems;
        }
        for (LingYong lingyong : lingyongList) {
            List<User> userList = userDao.find("from User where uname ='" + lingyong.getPersonName() + "'");
            if (userList.size() > 0) {
                User user = userList.get(0);
            if (!department.trim().equals(user.getDepartment())) {
                continue;
            }
                ItemsOutDTO itemsOut = new ItemsOutDTO();
                itemsOut.setId(lingyong.getId());
                itemsOut.setCount(lingyong.getCount());
                List<Item> itemList = itemDao.find("from Item where id = " + lingyong.getItemId());
                itemsOut.setItemName(itemList.get(0).getItemName());
                itemsOut.setPersonName(lingyong.getPersonName());
                itemsOut.setTime(sformat.format(lingyong.getDate()));
                itemsOut.setDepartment(department.trim());
                itemsOut.setState(lingyong.getState());
                itemsOut.setApplyTime(lingyong.getApplyTime() + "");
                listItems.add(itemsOut);
            }
        }
        return listItems;
    }

    public Result agree(String id) {
        List<LingYong> lingYongList = lingYongDao.find("from LingYong where id = " + id + "");
        List<Storage> storageList = storageDao.find("from Storage where itemId = "+lingYongList.get(0).getItemId());
        //扣库存
        if (storageList.size() != 0){
            Storage stairStorage = (Storage) storageList.get(0);
            if (stairStorage.getItemTotalNum()>=lingYongList.get(0).getCount()){
                stairStorage.setItemTotalNum(stairStorage.getItemTotalNum() - lingYongList.get(0).getCount());
                storageDao.update(stairStorage);
                //保存领用记录
                lingYongList.get(0).setState(1);
                lingYongList.get(0).setApplyTime(new Date());
                lingYongDao.update(lingYongList.get(0));
                result.setSuccess("领用成功",lingYongList.get(0));
            }else {
                result.setFailed("库存不足领用失败");
            }
        }else{
            result.setFailed("库存不足领用失败");
        }
        return result;
    }

    public Result deny(String id) {
        List<LingYong> lingYongList = lingYongDao.find("from LingYong where id = " + id + "");
        lingYongDao.delete(lingYongList.get(0));
        result.setSuccess("驳回成功",null);
        return result;

    }

    class Testlocal{
        private Integer itemId;
        private String itemName;
        private String itemUnit;
        private String itemType;
        private String itemTotalNum;
        private String itemPurchasingPrice;
        private String itemRemarks;

        public Integer getItemId() {
            return itemId;
        }

        public void setItemId(Integer itemId) {
            this.itemId = itemId;
        }

        public String getItemName() {
            return itemName;
        }

        public void setItemName(String itemName) {
            this.itemName = itemName;
        }

        public String getItemUnit() {
            return itemUnit;
        }

        public void setItemUnit(String itemUnit) {
            this.itemUnit = itemUnit;
        }

        public String getItemType() {
            return itemType;
        }

        public void setItemType(String itemType) {
            this.itemType = itemType;
        }

        public String getItemTotalNum() {
            return itemTotalNum;
        }

        public void setItemTotalNum(String itemTotalNum) {
            this.itemTotalNum = itemTotalNum;
        }

        public String getItemPurchasingPrice() {
            return itemPurchasingPrice;
        }

        public void setItemPurchasingPrice(String itemPurchasingPrice) {
            this.itemPurchasingPrice = itemPurchasingPrice;
        }

        public String getItemRemarks() {
            return itemRemarks;
        }

        public void setItemRemarks(String itemRemarks) {
            this.itemRemarks = itemRemarks;
        }
    }
}