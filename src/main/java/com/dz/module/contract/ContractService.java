package com.dz.module.contract;

import com.dz.common.global.Page;
import com.dz.common.global.ToDo;
import com.dz.common.global.WaitDeal;
import com.dz.common.global.WaitToDo;
import com.dz.common.other.ObjectAccess;
import com.dz.module.driver.Driver;
import com.dz.module.user.Role;
import com.dz.module.vehicle.Vehicle;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Transformer;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

@Service
//@WaitDeal(name = "contractService")
public class ContractService implements WaitToDo{
	private static final class ToDoSortComparator implements Comparator<ToDo> {
		public int compare(ToDo arg0,ToDo arg1){
			if(arg0==null||arg0.getMsg()==null){
				if(arg1==null||arg1.getMsg()==null) return 0;
				
				return - arg1.getMsg().compareTo(arg0.getMsg());
			}
			
			return arg0.getMsg().compareTo(arg1.getMsg());
		}
	}

	public long searchAllAvaliableCount(Date date,String dept){
		return contractDao.contractSearchAllAvaliableCount(date,dept);
	}
	@Autowired
	private ContractDao contractDao;

	public boolean contractWrite(Contract contract) {
		if(contract==null){
			return false;
		}
		return contractDao.contractWrite(contract);
	}
	
	public int contractSearchTotal(){
		return contractDao.contractSearchTotal();
	}
	
	public List<Contract> contractSearch(Page page){
		return contractDao.contractSearch(page);
	}

	public int contractSearchAvilableTotal() {
		return contractDao.contractSearchAvilableTotal();
	}

	public List<Contract> contractSearchAvilable(Page page) {
		return contractDao.contractSearchAvilable(page);
	}
	public List<Contract> contractSearchAllAvilable() {
		return contractDao.contractSearchAllAvilable();
	}

	public Contract contractShow(String id) {
		return contractDao.contractShow(id);
	}

	public boolean contractRevise(Contract c) {
		return contractDao.contractRevise(c);
	}

	public Contract contractShowAb(String id) {
		return contractDao.contractShowAb(id);
	}

	public boolean contractAbandon(Contract c) {
		return contractDao.contractAbandon(c);
	}

	public int contractSearchAbandonedTotal() {
		return contractDao.contractSearchAbandonedTotal();
	}

	public List<Contract> contractSearchAbandoned(Page page) {
		return contractDao.contractSearchAbandoned(page);
	}

	public int contractSearchConditionTotal(Integer contractid,
			String contractor, Long rent, Boolean isabandoned, String sort, String desc) {
		return contractDao.contractSearchConditionTotal(contractid,contractor,rent,isabandoned,sort,desc);
	}

	public List<Contract> contractSearchCondition(Page page, Integer contractid,
			String contractor, Long rent, Boolean isabandoned, String sort, String desc) {
		return contractDao.contractSearchCondition(page,contractid,contractor,rent,isabandoned,sort,desc);
	}
	
	public int selectAllByStatesCount(Contract contract,Vehicle vehicle,Driver driver,Date beginDate,Date endDate,Short[] states) {
		return contractDao.selectAllByStatesCount(contract, vehicle, driver, beginDate, endDate, states);
	}
	public List<Contract> selectAllByStates(Page page,Contract contract,Vehicle vehicle,Driver driver,Date beginDate,Date endDate,Short[] states) {
		return contractDao.selectAllByStates(page, contract, vehicle, driver, beginDate, endDate, states);
	}

	public ContractDao getContractDao() {
		return contractDao;
	}

	public void setContractDao(ContractDao contractDao) {
		this.contractDao = contractDao;
	}
	
	public Contract selectByCarId(String id){
		return contractDao.selectByCarId(id);
	}

	@SuppressWarnings("unchecked")
	@Override
	public Map<String, List<ToDo>> waitToDo(Role role) {
		Map<String, List<ToDo>> map = new TreeMap<String, List<ToDo>>();
		List<ToDo> toDolist = new ArrayList<ToDo>();
		List<Contract> approvalList;
		
		switch(role.getRname()){
		case "分部经理":
			break;
		case "运营部经理":
			break;
		case "副总经理":
			break;
		case "保险员":
			break;
		case "收款员":
			break;
		case "财务负责人":
			break;
		case "财务经理":
			break;
		case "办公室主任":
			approvalList = contractDao.contractSearchByState((short) 3);
			toDolist.addAll((List<ToDo>) CollectionUtils.collect(approvalList, new Transformer(){
				@Override
				public Object transform(Object arg0) {
					Contract comp =(Contract) arg0;
					StringBuilder msg = new StringBuilder("");
					if(!StringUtils.isEmpty(comp.getCarframeNum())){
						Vehicle v = (Vehicle) ObjectAccess.getObject("com.dz.module.vehicle.Vehicle", comp.getCarframeNum());
						if(v!=null){
							if(!StringUtils.isEmpty(v.getDept())){
								msg.append(v.getDept());
							}
						}
						msg.append(",");
						if(v!=null){
							if(!StringUtils.isEmpty(v.getLicenseNum())){
								msg.append(v.getLicenseNum());
							}
						}
						msg.append(",");
						msg.append(comp.getCarframeNum()).append(",");
					}else{
						msg.append(",,");
					}
					
					if(!StringUtils.isEmpty(comp.getIdNum())){
						Driver v = (Driver) ObjectAccess.getObject("com.dz.module.driver.Driver", comp.getIdNum());
						if(v!=null){
							if(!StringUtils.isEmpty(v.getName())){
								msg.append(v.getName());
							}
						}
						msg.append(",");
						msg.append(comp.getIdNum());
					}else{
						msg.append(",");
					}
					
					
					return new ToDo(msg.toString(),"待创建","/DZOMS/contract/contractPreAdd.action?contract.id="+comp.getId());
				}
			}));
			break;
		case "证照员":
		
			break;
		default:
			break;
		}
		Collections.sort(toDolist, new ToDoSortComparator());
		map.put("合同新增", toDolist);
		
		toDolist = new ArrayList<ToDo>();
		switch(role.getRname()){
		case "分部经理":
			break;
		case "运营部经理":
			break;
		case "副总经理":
			break;
		case "保险员":
			break;
		case "收款员":
			break;
		case "财务负责人":
			break;
		case "财务经理":
			break;
		case "办公室主任":
			approvalList = contractDao.contractSearchByState((short) 4);
			toDolist.addAll((List<ToDo>) CollectionUtils.collect(approvalList, new Transformer(){
				@Override
				public Object transform(Object arg0) {
					Contract comp =(Contract) arg0;
					StringBuilder msg = new StringBuilder("");
					if(!StringUtils.isEmpty(comp.getCarframeNum())){
						Vehicle v = (Vehicle) ObjectAccess.getObject("com.dz.module.vehicle.Vehicle", comp.getCarframeNum());
						if(v!=null){
							if(!StringUtils.isEmpty(v.getDept())){
								msg.append(v.getDept());
							}
						}
						msg.append(",");
						if(v!=null){
							if(!StringUtils.isEmpty(v.getLicenseNum())){
								msg.append(v.getLicenseNum());
							}
						}
						msg.append(",");
						msg.append(comp.getCarframeNum()).append(",");
					}else{
						msg.append(",,");
					}
					
					if(!StringUtils.isEmpty(comp.getIdNum())){
						Driver v = (Driver) ObjectAccess.getObject("com.dz.module.driver.Driver", comp.getIdNum());
						if(v!=null){
							if(!StringUtils.isEmpty(v.getName())){
								msg.append(v.getName());
							}
						}
						msg.append(",");
						msg.append(comp.getIdNum());
					}else{
						msg.append(",");
					}
					return new ToDo(msg.toString(),"待废止","/DZOMS/contract/contractPreAbandon.action?contract.id="+comp.getId());
				}
			}));
			break;
		case "证照员":
			break;
		default:
			break;
		}
		Collections.sort(toDolist, new ToDoSortComparator());
		map.put("合同废止", toDolist);
		
		return map;
	}

	public void changeState(Contract contract, int state) {
		contractDao.changeState(contract.getId(), state);
	}
	
	public Contract selectById(int id){
		return contractDao.selectById(id);
	}
	
	public boolean addRentFirstDivide(RentFirstDivide rentFirstDivide){
		return contractDao.addRentFirstDivide(rentFirstDivide);
	}

	public int searchAllAvaliableCount(Date time, String department,
			String licenseNum) {
		
		return contractDao.contractSearchAllAvaliableCount(time,department,licenseNum);
	}
}
