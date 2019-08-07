package com.dz.module.driver.accident;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.TimePass;
import com.dz.common.global.ToDo;
import com.dz.common.global.WaitDeal;
import com.dz.common.global.WaitToDo;
import com.dz.module.user.Role;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.*;

@Repository(value = "accidentDao")
@WaitDeal(name = "accidentDao")
public class AccidentDaoImp implements AccidentDao,WaitToDo{
	
	@Override
	public String addOrUpdateAccident(Accident accident) {
		Transaction tx = null;
		try{
			Session session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			BigDecimal carLoss = null;
			BigDecimal carPaid = null;
			BigDecimal peopleLoss = null;
			Accident sql_accident = (Accident)session.get(Accident.class,accident.getAccId());
			if(sql_accident != null){
				carLoss = BigDecimal.valueOf(sql_accident.getCarLoss() == null ? 0l : sql_accident.getCarLoss().doubleValue());
				carPaid = BigDecimal.valueOf(sql_accident.getCarPaid()==null?0l:sql_accident.getCarPaid().doubleValue());
				peopleLoss = BigDecimal.valueOf(sql_accident.getPeopleLoss()==null?0l:sql_accident.getPeopleLoss().doubleValue());
			}
			accident.setCarLoss(carLoss);
			accident.setCarPaid(carPaid);
			accident.setPeopleLoss(peopleLoss);
			session.clear();
			session.saveOrUpdate(accident);
			tx.commit();
			return "success";
		}catch(HibernateException he){
			he.printStackTrace();
			tx.rollback();
			return "data_error";
		}finally{
			HibernateSessionFactory.closeSession();
		}
	}
	//更新审核状态
	@Override
	public String updateStatus(Accident accident, int status) {
		Transaction tx = null;
		try{
			Session session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			Accident acc = (Accident) session.get(Accident.class, accident.getAccId());
			System.out.println(acc);
			if(acc!=null){
				acc.setStatus(status);
				session.update(acc);
			}
			System.out.println(acc);
			tx.commit();
			return "success";
		}catch(HibernateException he){
			he.printStackTrace();
			tx.rollback();
			return "data_error";
		}finally{
			HibernateSessionFactory.closeSession();
		}
	}
	//更新损失
	@Override
	public String updateLoss(Accident accident,Loss loss) {
		Transaction tx = null;
		try{
			Session session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			Accident acc = (Accident) session.get(Accident.class, accident.getAccId());
            loss = loss != null?loss:new Loss();
			System.out.println(loss.getPeopleLoss());
			System.out.println(accident);
			acc.setPeopleLoss(loss.getPeopleLoss());
			acc.setCarLoss(loss.getCarLoss());
			acc.setCarPaid(loss.getCarPaid());
			session.update(acc);
			tx.commit();
			return "success";
		}catch(HibernateException he){
			he.printStackTrace();
			tx.rollback();
			return "data_error";
		}finally{
			HibernateSessionFactory.closeSession();
		}
	}
	/*
	 * @param driverId,0选择待审核，1选择待修改，2选择待赔付，3选择未完成，4选择全部完成
	 * @param style,
	 */
	@SuppressWarnings("unchecked")
	@Override
	public List<Accident> selectAccidents(String driverId, int style,TimePass tp) {
		String sql = "from Accident where ";
		String con;
		switch(style){
		case 0:
			con = " status = 0 ";
			break;
		case 1:
			con = " status = 1 ";
			break;
		case 2:
			con = " status = 2 ";
			break;
		case 3:
			con = " status in (0,1,2)  ";
			break;
		case 4:
		default:
			con = " 1 = 1 ";
			break;
		}
		sql += con;
//		sql += driverId == null ? "":" and driverId = '"+driverId+"'";
		Transaction trans = null;
		List<Accident> list;
		try{
			Session session = HibernateSessionFactory.getSession();
			trans = session.beginTransaction();
			list = session.createQuery(sql).list();
			trans.commit();
		}catch(HibernateException he){
			he.printStackTrace();
			list = new ArrayList<>();
			trans.rollback();
		}finally {
            HibernateSessionFactory.closeSession();
        }
        List<Accident> results = new ArrayList<>();
		for(Accident acc : list){
            if(tp == null || tp.isTimeInIt(acc.getTime())){
                results.add(acc);
            }
        }
        return results;
	}

	@Override
	public boolean addCheck(Accident ac, int checker, Date time) {
		Transaction tx = null;
		try{
			Session session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			Accident acc = (Accident) session.get(Accident.class, ac.getAccId());
			System.out.println(acc);
			acc.setCheck_time(time);
			acc.setChecker(checker);
			session.update(acc);
			System.out.println(acc);
			tx.commit();
			return true;
		}catch(HibernateException he){
			he.printStackTrace();
			tx.rollback();
			return false;
		}finally{
			HibernateSessionFactory.closeSession();
		}
	}

	@Override
	public boolean addPay(Accident ac, String payer, Date time,BigDecimal money) {
		Transaction tx = null;
		try{
			Session session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			Accident acc = (Accident) session.get(Accident.class, ac.getAccId());
			System.out.println(acc);
			acc.setPay_time(time);
			acc.setPayer(payer);
			acc.setMoney(money);
			session.update(acc);
			System.out.println("check"+acc);
			tx.commit();
			return true;
		}catch(HibernateException he){
			he.printStackTrace();
			tx.rollback();
			return false;
		}finally{
			HibernateSessionFactory.closeSession();
		}
	}

	@Override
	public Accident accidentSelectById(Accident accident) {
		Transaction tx = null;
		Accident sql_acc = null;
		try{
			Session session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			sql_acc = (Accident) session.get(Accident.class, accident.getAccId());
			tx.commit();
		}catch(HibernateException he){
			he.printStackTrace();
			tx.rollback();
		}finally{
			HibernateSessionFactory.closeSession();
		}
		return sql_acc;
	}

	@Override
	public Map<String, List<ToDo>> waitToDo(Role role) {
		Map<String,List<ToDo>> map1 = new HashMap<String,List<ToDo>>();
		List<ToDo> list = new ArrayList<ToDo>();
		switch (role.getRname()){
			case "分部经理":
				List<Accident> accidents = selectAccidents(null,0,null);
				for(Accident a:accidents){
					ToDo todo = new ToDo();
					todo.setMsg("车架号 ： "+a.getCarId());
					todo.setState("待审核");
					todo.setUrl("javascript:openView('/DZOMS/driver/accident/accident_check.jsp',['"+a.getAccId()+"'],0);");
					list.add(todo);
				}
				break;
			case "办公室主任":
				List<Accident> accidents1 = selectAccidents(null,1,null);
				for(Accident a:accidents1){
					ToDo todo = new ToDo();
					todo.setMsg("车架号 ： "+a.getCarId());
					todo.setState("待修改");
					todo.setUrl("javascript:openView(\"/DZOMS/driver/accident/accident_check.jsp\",[\""+a.getAccId()+"\"],1);");
					list.add(todo);
				}
				break;
			case "财务经理":
				List<Accident> accidents2 = selectAccidents(null,2,null);
				for(Accident a:accidents2){
					ToDo todo = new ToDo();
					todo.setMsg("车架号 ： "+a.getCarId());
					todo.setState("待赔付");
					todo.setUrl("javascript:openView(\"/DZOMS/driver/accident/accident_check.jsp\",[\""+a.getAccId()+"\"],2);");
					list.add(todo);
				}
				break;
			default:
		}
		map1.put("事故处理",list);
		return map1;
	}

	@Override
	public boolean addInsuranceDetail(AccidentInsurance insurance) {
		Transaction tx = null;
		Accident sql_acc = null;
		try{
			Session session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			Query query = session.createQuery("from AccidentInsurance where accId=:accId");
			query.setInteger("accId",insurance.getAccId());
			Object obj = query.uniqueResult();
			if(obj != null)
				session.delete(obj);
			session.saveOrUpdate(insurance);
			tx.commit();
			return true;
		}catch(HibernateException he){
			he.printStackTrace();
			tx.rollback();
			return false;
		}catch (Exception e){
			e.printStackTrace();
			return false;
		}finally{
			HibernateSessionFactory.closeSession();
		}
	}

	@Override
	public AccidentInsurance getInsurance(int accId) {
		Transaction tx = null;
		try{
			Session session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			Query query = session.createQuery("from AccidentInsurance  ai where accId = :accId");
			query.setInteger("accId",accId);
			AccidentInsurance ai = (AccidentInsurance) query.uniqueResult();
			List<String> files = new ArrayList<>();
			for(String f:ai.getFilePaths()){
				files.add(f);
			}
			session.evict(ai);
			ai.setFilePaths(files);
			tx.commit();
			return ai;
		}catch(HibernateException he){
			he.printStackTrace();
			tx.rollback();
			return null;
		}finally{
			HibernateSessionFactory.closeSession();
		}
	}
}
