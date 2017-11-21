package com.dz.module.contract;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.Page;
import com.dz.module.driver.Driver;
import com.dz.module.vehicle.Vehicle;

import org.apache.commons.lang.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

@Repository(value="contractDao")
public class ContractDaoImpl implements ContractDao {
	@Override
	public Contract contractSearchRentAvaliable(String carfarameNum) {
		Session session = null;
		Transaction tx = null;
		Contract contract = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			Query query = session.createQuery("from Contract where carframeNum = :carframeNum and state in (0,-1)");
			query.setString("carframeNum",carfarameNum);
			contract = (Contract) query.uniqueResult();
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return contract;
	}

	public boolean contractWrite(Contract contract) throws HibernateException {
		boolean flag = false;
		Session session = null;
		Transaction tx = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();

			session.saveOrUpdate(contract);
			tx.commit();
			flag = true;
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return flag;
	}

	@Override
	public int contractSearchTotal() throws HibernateException {
		Session session = null;
		Transaction tx = null;
		int c = 0;
		try {
			session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			Query query = session.createQuery("select count(*) from Contract");
			c = Integer.parseInt(query.uniqueResult().toString());
			query = null;
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return c;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Contract> contractSearch(Page page) throws HibernateException {
		List<Contract> l = new ArrayList<Contract>();
		Session session = null;
		Transaction tx = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			Query query = session.createQuery("from Contract");
			query.setMaxResults(15);
			query.setFirstResult(page.getBeginIndex());
			l = query.list();
			query = null;
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return l;
	}

	@Override
	public int contractSearchAvilableTotal() throws HibernateException {
		Session session = null;
		Transaction tx = null;
		int c = 0;
		try {
			session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			Query query = session
					.createQuery("select count(*) from Contract where state in (0,-1)");
			c = Integer.parseInt(query.uniqueResult().toString());
			query = null;
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return c;
	}


	@SuppressWarnings("unchecked")
	@Override
	public List<Contract> contractSearchAvilable(Page page)
			throws HibernateException {
		List<Contract> l = new ArrayList<Contract>();
		Session session = null;
		Transaction tx = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			Query query = session
					.createQuery("from Contract where state in (0,1)");
			query.setMaxResults(15);
			query.setFirstResult(page.getBeginIndex());
			l = query.list();
			query = null;
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return l;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Contract> contractSearchAllAvilable()
			throws HibernateException {
		List<Contract> l = new ArrayList<Contract>();
		Session session = null;
		Transaction tx = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			Query query = session
					.createQuery("from Contract where state in (0,-1)");
			l = query.list();
			query = null;
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return l;
	}

	@Override
	public List<Contract> contractSearchAllAvilable(Date currentClearTime) {
		List<Contract> l = new ArrayList<Contract>();
		Session session = null;
		Transaction tx = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			Query query = session
					.createQuery("from Contract where state in (0,-1,1,4)");
			l = query.list();
			Iterator<Contract> iterators = l.iterator();
			filterContractThatStateEq1Charge(currentClearTime, iterators);
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return l;
	}

	/**
	 * 返回一个部门/全部 一个月 所有要收费的合同,
	 * @param currentClearTime 查询的月份
	 * @param dept 部门
	 * @param page 分页,如果为null,则不做分页限制.
	 * @return 合同列表.
	 */
	@Override
	public List<Contract> contractSearchAllAvilable(Date currentClearTime,String dept,Page page) {
		List<Contract> l = new ArrayList<Contract>();
		Session session = null;
		Transaction tx = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			Query query = null;
			if("全部".equals(dept)){
				query = session.createQuery("from Contract where state in (0,-1,1,4)");
			}else{
				query = session.createQuery("from Contract where state in (0,-1,1,4) and branchFirm = :dept");
				query.setString("dept",dept);
			}
			if(page!=null){
				query.setFirstResult(page.getBeginIndex());
				query.setMaxResults(page.getEveryPage());
			}
			l = query.list();
			Iterator<Contract> iterators = l.iterator();
			filterContractThatStateEq1Charge(currentClearTime, iterators);
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return l;
	}

	/**
	 * 过滤合同,返回那些已经废业但是还要收钱的合同.
	 * @param currentClearTime 清账年月
	 * @param iterators 要过滤的所有合同的迭代器.
	 */
	private void filterContractThatStateEq1Charge(Date currentClearTime, Iterator<Contract> iterators) {

		//相当于hql子句  and ((abandoned_final_time is null) or (YEAR(abandoned_final_time)*12+MONTH(abandoned_final_time)+(DAY(abandoned_final_time)>26)) >= (YEAR(:currentClearTime)*12+MONTH(:currentClearTime))))
		while(iterators.hasNext()){
			Contract contract = iterators.next();
			if(contract.getState() == 1){
				Date finalTime = contract.getAbandonedFinalTime();
				if(finalTime != null){
					int totalFinalMonth = finalTime.getYear()*12+finalTime.getMonth();
					if(finalTime.getDay() > 26){
						totalFinalMonth++;
					}
					int totalClearMonth = currentClearTime.getMonth()+currentClearTime.getYear()*12;
					if(totalFinalMonth < totalClearMonth)
						iterators.remove();
				}
			}
		}
	}

	@Override
	public long contractSearchAllAvaliableCount(Date time, String dept) {
		List<Contract> l = new ArrayList<Contract>();
		Session session = null;
		Transaction tx = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			Query query = null;
			if("全部".equals(dept)){
				query = session.createQuery("from Contract where state in (0,-1,1,4)");
			}else{
				query = session.createQuery("from Contract where state in (0,-1,1,4) and branchFirm = :dept");
				query.setString("dept",dept);
			}
			l = query.list();
			Iterator<Contract> iterators = l.iterator();
			filterContractThatStateEq1Charge(time, iterators);
			tx.commit();
			return l.size();
		} catch (HibernateException e) {
			e.printStackTrace();
			if (tx != null) {
				tx.rollback();
			}
			return 0;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Contract> contractSearchByState(Short state)
			throws HibernateException {
		List<Contract> l = new ArrayList<Contract>();
		Session session = null;
		try {
			session = HibernateSessionFactory.getSession();
			Query query = session
					.createQuery("from Contract where state = :state");
			query.setInteger("state", state);
			l = query.list();
		} catch (HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return l;
	}

	@Override
	public Contract contractShow(String id) throws HibernateException {
		Contract c = null;
		Session session = HibernateSessionFactory.getSession();
		Query query = session.createQuery("from Contract where contractId="
				+ id);
		c = (Contract) query.uniqueResult();
		HibernateSessionFactory.closeSession();
		return c;
	}

	@Override
	public boolean contractRevise(Contract c) throws HibernateException {
		boolean flag = false;
		Session session = null;
		Transaction tx = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			session.update(c);
			tx.commit();
			flag = true;
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return flag;
	}

	@Override
	public Contract contractShowAb(String id) throws HibernateException {
		Contract c = null;
		Session session = HibernateSessionFactory.getSession();
		Query query = session.createQuery("from Contract where contractId="
				+ id);
		c = (Contract) query.uniqueResult();
		HibernateSessionFactory.closeSession();
		return c;
	}

	@Override
	public boolean contractAbandon(Contract c) throws HibernateException {
		boolean flag = false;
		Session session = null;
		Transaction tx = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			session.update(c);
			tx.commit();
			flag = true;
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return flag;
	}

	@Override
	public int contractSearchAbandonedTotal() throws HibernateException {
		Session session = null;
		Transaction tx = null;
		int c = 0;
		try {
			session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			Query query = session
					.createQuery("select count(*) from Contract where state not in (0,-1)");
			c = Integer.parseInt(query.uniqueResult().toString());
			query = null;
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return c;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Contract> contractSearchAbandoned(Page page)
			throws HibernateException {
		List<Contract> l = new ArrayList<Contract>();
		Session session = null;
		Transaction tx = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			Query query = session
					.createQuery("from Contract where state not in (0,-1)");
			query.setMaxResults(15);
			query.setFirstResult(page.getBeginIndex());
			l = query.list();
			query = null;
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return l;
	}

	@Override
	public int contractSearchConditionTotal(Integer contractid,
											String contractor, Long rent, Boolean isabandoned, String sort,
											String desc) throws HibernateException {
		Session session = null;
		Transaction tx = null;
		int c = 0;
		try {
			session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			String sql = "select count(*) from Contract";
			if (contractid==null &&StringUtils.isEmpty(contractor) && rent==null) {
				sql += " where 1=1";
			} else {
				sql += " where 0=1";
			}
			if (contractid!=null) {
				sql += " or contractId=" + contractid;
			}
			if (!StringUtils.isEmpty(contractor)) {
				sql += " or contractorName=" + contractor;
			}
			if (rent!=null) {
				sql += " or rent=" + rent;
			}
			sql += " and isAbandoned=: isabandoned";
			if (sort.equals("0")) {
				sql += " order by contractId";
			} else if (sort.equals("1")) {
				sql += " order by rent";
			}
			if (desc.equals("0")) {
			} else if (desc.equals("1")) {
				sql += " desc";
			}
			System.out.println(sql);
			Query query = session.createQuery(sql);
			query.setBoolean("isabandoned", isabandoned);
			c = Integer.parseInt(query.uniqueResult().toString());
			query = null;
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return c;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Contract> contractSearchCondition(Page page, Integer contractid,
												  String contractor, Long rent, Boolean isabandoned, String sort,
												  String desc) throws HibernateException {
		List<Contract> l = new ArrayList<Contract>();
		Session session = null;
		Transaction tx = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			String sql = "from Contract";
			if (contractid==null &&StringUtils.isEmpty(contractor) && rent==null) {
				sql += " where 1=1";
			} else {
				sql += " where 0=1";
			}
			if (contractid!=null) {
				sql += " or contractId=" + contractid;
			}
			if (!StringUtils.isEmpty(contractor)) {
				sql += " or contractorName=" + contractor;
			}
			if (rent!=null) {
				sql += " or rent=" + rent;
			}
			sql += " and isAbandoned=: isabandoned";
			if (sort.equals("0")) {
				sql += " order by contractId";
			} else if (sort.equals("1")) {
				sql += " order by rent";
			}
			if (desc.equals("0")) {
			} else if (desc.equals("1")) {
				sql += " desc";
			}
			System.out.println(sql);
			Query query = session.createQuery(sql);
			query.setBoolean("isabandoned", isabandoned);
			query.setMaxResults(15);
			query.setFirstResult(page.getBeginIndex());
			l = query.list();
			query = null;
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return l;
	}

	//	@Override
//	public List<String> selectDriverByCar(Vehicle vehicle) {
//		Session session = null;
//		Transaction tx = null;
//		List<String> driverIds;
//		try {
//			session = HibernateSessionFactory.getSession();
//			tx = (Transaction) session.beginTransaction();
//			String sql = "from Contract where carframeNum = :carId";
//			Query query = session.createQuery(sql);
//			List<Contract> cs = query.list();
//			for(Contract c : cs){
//				driverIds.add(c.get)
//			}
//			tx.commit();
//		} catch (HibernateException e) {
//			if (tx != null) {
//				tx.rollback();
//			}
//			throw e;
//		} finally {
//			HibernateSessionFactory.closeSession();
//		}
//	}
	@Override
	public Contract selectByCarId(String id){
		Contract c = null;
		Session session = HibernateSessionFactory.getSession();
		Query query = session.createQuery("from Contract where carframeNum = :id and state=0");
		query.setMaxResults(1);
		query.setString("id",id);
		c = (Contract) query.uniqueResult();
		HibernateSessionFactory.closeSession();
		return c;
	}

	@Override
	public Contract selectByCarId(String id, Date d) {
		Contract c = null;
		try{
			Session session = HibernateSessionFactory.getSession();
//			Query query = session.createQuery("from Contract where carframeNum = :id and state=0");
			Query query = session.createQuery("from Contract where id=( select max(id) from Contract where carframeNum = :id and state!=3 and state!=2 and state>=0 ) ");
			query.setString("id",id);
			query.setMaxResults(1);
			c = (Contract) query.uniqueResult();

			Calendar dt = Calendar.getInstance();
			if(c!=null&&c.getContractBeginDate()!=null){
				dt.setTime(c.getContractBeginDate());
			}else{
				return c;
			}

			if(dt.get(Calendar.DATE)>26){

				dt.set(Calendar.DATE, 26);
			}else{
				dt.add(Calendar.MONTH, -1);
				dt.set(Calendar.DATE, 26);
			}

//			System.out.println("ContractDaoImpl.selectByCarId(),"+dt.toString());

			if(dt.getTime().before(d)){
				return c;
			}else{
				while(c.getContractFrom()!=null){
					Contract last = (Contract) session.get(Contract.class, c.getContractFrom());
					if(last!=null) c = last;
					else return c;

					dt.setTime(c.getContractBeginDate());
					if(dt.get(Calendar.DATE)>26){
						dt.add(Calendar.MONTH, 1);
						dt.set(Calendar.DATE, 26);
					}else{
						dt.set(Calendar.DATE, 26);
					}

					if(dt.getTime().before(d))
						return c;
				}
			}
		}finally{
			HibernateSessionFactory.closeSession();
		}

		return c;
	}

	@Override
	public BigDecimal getAccount(int contractId) {
		BigDecimal account = new BigDecimal(0);
		Session session = null;
		try {
			session = HibernateSessionFactory.getSession();
			Contract contract = (Contract)session.get(Contract.class, contractId);
			account = contract.getAccount();
		} catch (HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return account;
	}

	@Override
	public boolean updateAccount(int contractId,BigDecimal account) {
		boolean flag = false;
		Session session = null;
		Transaction tx = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			Contract contract = (Contract)session.get(Contract.class,contractId);
			contract.setAccount(account);
			tx.commit();
			flag = true;
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return flag;
	}

	@Override
	public void changeState(Integer contractId, int state) {
		Session session = null;
		Transaction tx = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			Contract c = (Contract) session.get(Contract.class, contractId);
			c.setState((short) state);
			session.update(c);

			Vehicle vehicle = (Vehicle) session.get(Vehicle.class, c.getCarframeNum());
			if(vehicle!=null){
				switch(state){
					case 0:
						vehicle.setState(1);
						break;
				}

				session.update(vehicle);
			}
			tx.commit();
		}catch(HibernateException e){
			tx.rollback();
			e.printStackTrace();
		}finally{
			HibernateSessionFactory.closeSession();
		}
	}

	@Override
	public Contract selectById(int id) {
		Contract c = null;
		Session session = HibernateSessionFactory.getSession();
		Query query = session.createQuery("from Contract where id = :id");
		query.setInteger("id",id);
		c = (Contract) query.uniqueResult();
		HibernateSessionFactory.closeSession();
		return c;
	}

	@Override
	public int selectAllByStatesCount(Contract contract, Vehicle vehicle,
									  Driver driver, Date beginDate, Date endDate, Short[] states) {

		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();

			String hql = "select count(*) from Contract c where c.state in (:states)";

			if(beginDate!=null){
				hql+=" and c.contractBeginDate >= :beginDate";
			}

			if(endDate!=null){
				hql+=" and c.contractBeginDate <= :endDate";
			}

			if(contract!=null){
				if(!StringUtils.isEmpty(contract.getIdNum())){
					hql+=" and c.idNum like :idNum";
				}

				if(!StringUtils.isEmpty(contract.getCarNum())){
					hql+=" and c.carNum like :carNum";
				}
			}

			Query query = session.createQuery(hql);

			if(beginDate!=null){
				query.setDate("beginDate", beginDate);
			}

			if(endDate!=null){
				query.setDate("endDate", endDate);
			}

			if(contract!=null){
				if(!StringUtils.isEmpty(contract.getIdNum())){
					query.setString("idNum", "%"+contract.getIdNum()+"%");
				}

				if(!StringUtils.isEmpty(contract.getCarNum())){
					query.setString("carNum", "%"+contract.getCarNum()+"%");
				}
			}
			query.setParameterList("states", states);
			return Integer.parseInt(query.uniqueResult().toString());
		}catch(HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Contract> selectAllByStates(Page page, Contract contract,
											Vehicle vehicle, Driver driver, Date beginDate, Date endDate,
											Short[] states) {
		Session session = null;
		try{
			session = HibernateSessionFactory.getSession();

			String hql = "from Contract c where c.state in (:states)";

			if(beginDate!=null){
				hql+=" and c.contractBeginDate >= :beginDate";
			}

			if(endDate!=null){
				hql+=" and c.contractBeginDate <= :endDate";
			}

			if(contract!=null){
				if(!StringUtils.isEmpty(contract.getIdNum())){
					hql+=" and c.idNum like :idNum";
				}

				if(!StringUtils.isEmpty(contract.getCarNum())){
					hql+=" and c.carNum like :carNum";
				}
			}

			Query query = session.createQuery(hql);

			if(beginDate!=null){
				query.setDate("beginDate", beginDate);
			}

			if(endDate!=null){
				query.setDate("endDate", endDate);
			}

			if(contract!=null){
				if(!StringUtils.isEmpty(contract.getIdNum())){
					query.setString("idNum", "%"+contract.getIdNum()+"%");
				}

				if(!StringUtils.isEmpty(contract.getCarNum())){
					query.setString("carNum", "%"+contract.getCarNum()+"%");
				}
			}
			query.setParameterList("states", states);
			if(page!=null){
				query.setMaxResults(page.getEveryPage());
				query.setFirstResult(page.getBeginIndex());
			}
			return query.list();
		}catch(HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}

	@Override
	public boolean addRentFirstDivide(RentFirstDivide rentFirstDivide){
		Session session = null;
		Transaction tx = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();

			session.saveOrUpdate(rentFirstDivide);
			tx.commit();
			return true;
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			return false;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}

	@Override
	public int contractSearchAllAvaliableCount(Date time, String dept,
											   String licenseNum) {
		Session session = null;
		Transaction tx = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			Query query = null;

			String hql="select count(*) from Contract where state in (0,-1,1,4) and (abandonedFinalTime is null or (YEAR(abandonedFinalTime)*12+MONTH(abandonedFinalTime)+(case when DAY(abandonedFinalTime)>26 then 1 else 0 end) >= (YEAR(:currentClearTime)*12+MONTH(:currentClearTime))) )";
			if (dept!=null&&!"全部".equals(dept)) {
				hql+="and branchFirm = :dept ";
			}

			if(!StringUtils.isEmpty(licenseNum)){
				hql+="and carNum like :carNum ";
			}

			query = session.createQuery(hql);

			if (dept!=null&&!"全部".equals(dept)) {
				query.setString("dept",dept);
			}

			if(!StringUtils.isEmpty(licenseNum)){
				query.setString("carNum",licenseNum);
			}

			query.setDate("currentClearTime", time);

			long count = (long) query.uniqueResult();
			tx.commit();
			return (int) count;
		} catch (HibernateException e) {
			e.printStackTrace();
			if (tx != null) {
				tx.rollback();
			}
			return 0;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}

	@Override
	public List<Contract> contractSearchAllAvilable(Date time, String dept,
													String licenseNum, Page page) {
		List<Contract> l = new ArrayList<Contract>();
		Session session = null;
		Transaction tx = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = session.beginTransaction();
			Query query = null;

			String hql="from Contract where state in (0,-1,1,4)  and (abandonedFinalTime is null or (YEAR(abandonedFinalTime)*12+MONTH(abandonedFinalTime)+(case when DAY(abandonedFinalTime)>26 then 1 else 0 end) >= (YEAR(:currentClearTime)*12+MONTH(:currentClearTime)) ))";
			if (dept!=null&&!"全部".equals(dept)) {
				hql+="and branchFirm = :dept ";
			}

			if(!StringUtils.isEmpty(licenseNum)){
				hql+="and carNum like :carNum ";
			}

			query = session.createQuery(hql);

			if (dept!=null&&!"全部".equals(dept)) {
				query.setString("dept",dept);
			}

			if(!StringUtils.isEmpty(licenseNum)){
				query.setString("carNum",licenseNum);
			}

			query.setDate("currentClearTime", time);

			if(page!=null){
				query.setMaxResults(page.getEveryPage());
				query.setFirstResult(page.getBeginIndex());
			}

			l = query.list();

			tx.commit();
			return l;
		} catch (HibernateException e) {
			e.printStackTrace();
			if (tx != null) {
				tx.rollback();
			}
			return l;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}

	public static void main(String[] args) {
		ContractDaoImpl daoImpl = new ContractDaoImpl();
		List<Contract> contractList = daoImpl.contractSearchAllAvilable(new Date(),"全部",null,null);
		System.out.println(contractList);
	}
}
