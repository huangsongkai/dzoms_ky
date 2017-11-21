package com.dz.module.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service
public class UserService {
	@Autowired
	UserDao userDao;
	/*public boolean saveUser(User user) {
		if (user == null) {
			return false;
		} 
		
		UserDao userDao = new UserDaoImpl();	
		
		return userDao.saveUser(user);
	}*/
	
	public String userLogin(User user){
		if (user == null) {
			return "user_null";
		}
		
		return userDao.userLogin(user);
	}

	public User getUser(User user){
		return userDao.getUser(user);
	}
	
	/**
	 * 获取当前用户的代办事宜
	 * @return
	 */
	public HashMap<String, ArrayList<String>> getCurrentMatter(ArrayList<Authority> authority)
	{
		HashMap<String, ArrayList<String>> result  = new HashMap<String, ArrayList<String>>();
		/*for(int i=0; i<authority.size(); i++)
		{
			if(authority.get(i).getAname().equals("综合办公室开业审批"))//新车开业审批单待审批
			{
				VehicleApprovalDaoImpl vehicleApproval = new VehicleApprovalDaoImpl();
				re.addAll(vehicleApproval.queryVehicleApprovalByState("1"));
				re.addAll(vehicleApproval.queryVehicleApprovalByState("5"));
			}
			else if(authority.get(i).getAname().equals("计财部开业审批"))//新车开业审批单待审批
			{
				VehicleApprovalDaoImpl vehicleApproval = new VehicleApprovalDaoImpl();
				re.addAll(vehicleApproval.queryVehicleApprovalByState("2"));
				re.addAll(vehicleApproval.queryVehicleApprovalByState("5"));
			}
			else if(authority.get(i).getAname().equals("运营管理部开业审批-分部经理"))//新车开业审批单待审批
			{
				VehicleApprovalDaoImpl vehicleApproval = new VehicleApprovalDaoImpl();
				re.addAll(vehicleApproval.queryVehicleApprovalByState("3.1"));
				re.addAll(vehicleApproval.queryVehicleApprovalByState("5"));
			}
			else if(authority.get(i).getAname().equals("运营管理部开业审批-保险员"))//新车开业审批单待审批
			{
				VehicleApprovalDaoImpl vehicleApproval = new VehicleApprovalDaoImpl();
				re.addAll(vehicleApproval.queryVehicleApprovalByState("3.2")); 
				re.addAll(vehicleApproval.queryVehicleApprovalByState("5"));
			}
			else if(authority.get(i).getAname().equals("运营管理部开业审批-部门经理"))//新车开业审批单待审批
			{
				VehicleApprovalDaoImpl vehicleApproval = new VehicleApprovalDaoImpl();
				re.addAll(vehicleApproval.queryVehicleApprovalByState("3.3"));
				re.addAll(vehicleApproval.queryVehicleApprovalByState("5"));
			}
			else if(authority.get(i).getAname().equals("主管副总经理开业审批"))//新车开业审批单待审批
			{
				VehicleApprovalDaoImpl vehicleApproval = new VehicleApprovalDaoImpl();
				re.addAll(vehicleApproval.queryVehicleApprovalByState("4"));
				re.addAll(vehicleApproval.queryVehicleApprovalByState("5"));
			}
			result.put("VehicleApproval", re);
		}*/
		return result;
	}

	public UserDao getUserDao() {
		return userDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	public List<User> getAllUsers(){
		return userDao.getAll();
	}
}
