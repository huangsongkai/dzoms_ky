package com.dz.module.vehicle;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.Page;
import com.dz.common.other.PageUtil;
import com.dz.module.driver.Driver;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
@Repository(value = "insuranceDao")
public class InsuranceDaoImpl implements InsuranceDao {

	@Override
	public void addInsurance(Insurance insurance, boolean override) throws HibernateException {
		Session session = null;
		Transaction tx = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = (Transaction) session.beginTransaction();
			insurance.setInsuranceNum(StringUtils.upperCase(insurance.getInsuranceNum()));

			Query query = session.createQuery("from Insurance where insuranceNum=:num ");
			query.setString("num", insurance.getInsuranceNum());
			Insurance old = (Insurance) query.uniqueResult();
			if (old != null){
				if (override) {
					insurance.setId(old.getId());
				} else {
					return;
				}
			}

			session.saveOrUpdate(insurance);
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}

	@Override
	public void addInsurance(Insurance insurance) throws HibernateException {
		addInsurance(insurance, true);
	}

	@Override
	public void updateInsurance(Insurance insurance)
			throws HibernateException {
		Session session = null;
		Transaction tx = null;
		try {	
			session = HibernateSessionFactory.getSession();
			tx = (Transaction) session.beginTransaction();
			insurance.setInsuranceNum(StringUtils.upperCase(insurance.getInsuranceNum()));
			session.update(insurance);
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {			
			HibernateSessionFactory.closeSession();
		}
	}

	@Override
	public void deleteInsurance(Insurance insurance)
			throws HibernateException {
		Session session = null;
		Transaction tx = null;
		try {	
			session = HibernateSessionFactory.getSession();
			tx = (Transaction) session.beginTransaction();
			
			session.delete(insurance);
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {			
			HibernateSessionFactory.closeSession();
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Insurance> selectAll() {
		Session session = null;
		try {
			session = HibernateSessionFactory.getSession();
			Query query = session.createQuery("from Insurance where state>0 ");
			return query.list();
			
		} catch (HibernateException e) {
			throw e;
		}finally {
			HibernateSessionFactory.closeSession();
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Insurance> selectByVehicle(Vehicle vehicle) {
		Session session = null;
		try {
			session = HibernateSessionFactory.getSession();
			Query query = session.createQuery("from Insurance where state>0 and carframeNum=:carframeNum");
			query.setString("carframeNum", vehicle.getCarframeNum());
			return query.list();
			
		} catch (HibernateException e) {
			throw e;
		}finally {
			HibernateSessionFactory.closeSession();
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Insurance> selectByDriver(Driver driver) {
		Session session = null;
		try {
			session = HibernateSessionFactory.getSession();
			Query query = session.createQuery("from Insurance where state>0 and driverId=:driverId");
			query.setString("driverId", driver.getIdNum());
			return query.list();
			
		} catch (HibernateException e) {
			throw e;
		}finally {
			HibernateSessionFactory.closeSession();
		}
	}

	@Override
	public int selectByConditionCount(Insurance insurance, Vehicle vehicle, Date inputFrom, Date inputEnd, Date startFrom, Date startEnd) {
		Session session = null;
		try {
			session = HibernateSessionFactory.getSession();
			String sql="select count(*) from Insurance where state=1 ";
			
			
			if(!StringUtils.isEmpty(insurance.getCarframeNum())){
				sql+="and carframeNum like :carframeNum ";
			}
			
			if(!StringUtils.isEmpty(insurance.getInsuranceNum())){
				sql+="and insuranceNum like :insuranceNum ";
			}
			
			if(!StringUtils.isEmpty(insurance.getInsuranceClass())){
				sql+="and insuranceClass like :insuranceClass ";
			}
			
			if(vehicle!=null){
				String innerSql = "";
				if(!StringUtils.isEmpty(vehicle.getLicenseNum())){
					innerSql+="and licenseNum  like :licenseNum ";
				}

				if (!StringUtils.isBlank(vehicle.getDept()) && !StringUtils.equalsIgnoreCase("全部",vehicle.getDept())){
					innerSql+="and dept=:dept ";
				}

				if (!StringUtils.isBlank(innerSql)){
					sql+="and carframeNum in (select carframeNum from Vehicle where 1=1 "+innerSql+" ) ";
				}
			}

			if (inputFrom != null && inputFrom.after(new Date(100,1,1))) {
				sql+= "and registTime >= :inputFrom ";
			}
			if (inputEnd != null && inputEnd.after(new Date(100,1,1))) {
				sql+= "and registTime < :inputEnd ";
			}
			if (startFrom != null && startFrom.after(new Date(100,1,1))) {
				sql+= "and beginDate >= :startFrom ";
			}
			if (startEnd != null && startEnd.after(new Date(100,1,1))) {
				sql+= "and beginDate < :startEnd ";
			}
			
			Query query = session.createQuery(sql);
			
			if(!StringUtils.isEmpty(insurance.getCarframeNum())){
				query.setString("carframeNum", "%"+insurance.getCarframeNum()+"%");
			}
			
			if(!StringUtils.isEmpty(insurance.getInsuranceNum())){
				query.setString("insuranceNum", "%"+insurance.getInsuranceNum()+"%");
			}
			
			if(!StringUtils.isEmpty(insurance.getInsuranceClass())){
				query.setString("insuranceClass", "%"+insurance.getInsuranceClass()+"%");
			}
			
			if(vehicle!=null){
				if(!StringUtils.isEmpty(vehicle.getLicenseNum())){
					query.setString("licenseNum", "%"+vehicle.getLicenseNum()+"%");
				}
				if (!StringUtils.isBlank(vehicle.getDept()) && !StringUtils.equalsIgnoreCase("全部",vehicle.getDept())){
					query.setString("dept", vehicle.getDept());
				}
			}

			if (inputFrom != null && inputFrom.after(new Date(100,1,1))) {
				query.setDate("inputFrom",inputFrom);
			}
			if (inputEnd != null && inputEnd.after(new Date(100,1,1))) {
				query.setDate("inputEnd",inputEnd);
			}
			if (startFrom != null && startFrom.after(new Date(100,1,1))) {
				query.setDate("startFrom",startFrom);
			}
			if (startEnd != null && startEnd.after(new Date(100,1,1))) {
				query.setDate("startEnd",startEnd);
			}
			return Integer.parseInt(query.uniqueResult().toString());
		} catch (HibernateException e) {
			throw e;
		}finally {
			HibernateSessionFactory.closeSession();
		}
	}

	@SuppressWarnings("unchecked")

	public List<Insurance> selectByCondition2(Page page, Insurance insurance, Vehicle vehicle, Date inputFrom, Date inputEnd, Date startFrom, Date startEnd) {
		Session session = null;
		try {
			session = HibernateSessionFactory.getSession();
			String sql_01="select new com.dz.module.vehicle.InsuranceWithBaseMoney\n" +
					"(ins.id,ins.insuranceClass,ins.carframeNum,ins.insuranceNum,ins.insuranceCompany,\n" +
					"ins.insuranceMoney,ins.beginDate,ins.endDate,ins.signDate,ins.driverId,ins.register,\n" +
					"ins.registTime,ins.phone,ins.address,ins.state, 0.0 ) \n" +
					"from Insurance ins where ins.state=1 and not exists \n" +
					"(select 1 from InsuranceDivide2 div\n" +
					"where ins.id=div.id.insuranceId) ";

            String sql_02="select new com.dz.module.vehicle.InsuranceWithBaseMoney\n" +
					"(ins.id as id,ins.insuranceClass,ins.carframeNum as carframeNum,ins.insuranceNum,ins.insuranceCompany,ins.insuranceMoney,\n" +
					"ins.beginDate,ins.endDate,ins.signDate,ins.driverId,ins.register,ins.registTime,ins.phone,ins.address,ins.state, \n" +
					"sum(div.money) as baseMoney ) from Insurance ins,InsuranceDivide2 div \n" +
					"where ins.state=1 and ins.id=div.id.insuranceId ";

            String sql = " ";

            if(!StringUtils.isEmpty(insurance.getCarframeNum())){
				sql+="and ins.carframeNum like :carframeNum ";
			}
			
			if(!StringUtils.isEmpty(insurance.getInsuranceNum())){
				sql+="and ins.insuranceNum like :insuranceNum ";
			}
			
			if(!StringUtils.isEmpty(insurance.getInsuranceClass())){
				sql+="and ins.insuranceClass like :insuranceClass ";
			}

			if(vehicle!=null){
				String innerSql = "";

				if(!StringUtils.isEmpty(vehicle.getLicenseNum())){
					innerSql+="and licenseNum  like :licenseNum ";
				}

				if (!StringUtils.isBlank(vehicle.getDept()) && !StringUtils.equalsIgnoreCase("全部",vehicle.getDept())){
					innerSql+="and dept=:dept ";
				}

				if (!StringUtils.isBlank(innerSql)){
					sql+="and ins.carframeNum in (select carframeNum from Vehicle where 1=1 "+innerSql+" ) ";
				}
			}

			if (inputFrom != null && inputFrom.after(new Date(100,1,1))) {
				sql+= "and ins.registTime >= :inputFrom ";
			}
			if (inputEnd != null && inputEnd.after(new Date(100,1,1))) {
				sql+= "and ins.registTime < :inputEnd ";
			}
			if (startFrom != null && startFrom.after(new Date(100,1,1))) {
				sql+= "and ins.beginDate >= :startFrom ";
			}
			if (startEnd != null && startEnd.after(new Date(100,1,1))) {
				sql+= "and ins.beginDate < :startEnd ";
			}

//			String finalSql = "" +sql_01 + sql + " union ("+sql_02 + sql +" group by ins.id) ";
//			String finalSql = ""+sql_02 + sql +" group by ins.id ";
			String finalSql = ""+sql_02 + sql +" group by ins.id  union " +sql_01 + sql;
			Query query = session.createQuery(finalSql);
			
			if(!StringUtils.isEmpty(insurance.getCarframeNum())){
				query.setString("carframeNum","%"+ insurance.getCarframeNum()+"%");
			}
			
			if(!StringUtils.isEmpty(insurance.getInsuranceNum())){
				query.setString("insuranceNum","%"+ insurance.getInsuranceNum()+"%");
			}
			
			if(!StringUtils.isEmpty(insurance.getInsuranceClass())){
				query.setString("insuranceClass", "%"+insurance.getInsuranceClass()+"%");
			}

			if(vehicle!=null){
				if(!StringUtils.isEmpty(vehicle.getLicenseNum())){
					query.setString("licenseNum", "%"+vehicle.getLicenseNum()+"%");
				}
				if (!StringUtils.isBlank(vehicle.getDept()) && !StringUtils.equalsIgnoreCase("全部",vehicle.getDept())){
					query.setString("dept", vehicle.getDept());
				}
			}

			if (inputFrom != null && inputFrom.after(new Date(100,1,1))) {
				query.setDate("inputFrom",inputFrom);
			}
			if (inputEnd != null && inputEnd.after(new Date(100,1,1))) {
				query.setDate("inputEnd",inputEnd);
			}
			if (startFrom != null && startFrom.after(new Date(100,1,1))) {
				query.setDate("startFrom",startFrom);
			}
			if (startEnd != null && startEnd.after(new Date(100,1,1))) {
				query.setDate("startEnd",startEnd);
			}
			
			query.setFirstResult(page.getBeginIndex());
			query.setMaxResults(page.getEveryPage());
			return query.list();
		} catch (HibernateException e) {
			throw e;
		}finally {
			HibernateSessionFactory.closeSession();
		}
	}

	@Override
	public List selectByCondition(Page page, Insurance insurance, Vehicle vehicle, Date inputFrom, Date inputEnd, Date startFrom, Date startEnd) {
		Session session = null;
		try {
			session = HibernateSessionFactory.getSession();
			String sql="from Insurance ins where ins.state=1 ";

			if(!StringUtils.isEmpty(insurance.getCarframeNum())){
				sql+="and ins.carframeNum like :carframeNum ";
			}

			if(!StringUtils.isEmpty(insurance.getInsuranceNum())){
				sql+="and ins.insuranceNum like :insuranceNum ";
			}

			if(!StringUtils.isEmpty(insurance.getInsuranceClass())){
				sql+="and ins.insuranceClass like :insuranceClass ";
			}

			if(vehicle!=null){
				String innerSql = "";

				if(!StringUtils.isEmpty(vehicle.getLicenseNum())){
					innerSql+="and licenseNum  like :licenseNum ";
				}

				if (!StringUtils.isBlank(vehicle.getDept()) && !StringUtils.equalsIgnoreCase("全部",vehicle.getDept())){
					innerSql+="and dept=:dept ";
				}

				if (!StringUtils.isBlank(innerSql)){
					sql+="and ins.carframeNum in (select carframeNum from Vehicle where 1=1 "+innerSql+" ) ";
				}
			}

			if (inputFrom != null && inputFrom.after(new Date(100,1,1))) {
				sql+= "and ins.registTime >= :inputFrom ";
			}
			if (inputEnd != null && inputEnd.after(new Date(100,1,1))) {
				sql+= "and ins.registTime < :inputEnd ";
			}
			if (startFrom != null && startFrom.after(new Date(100,1,1))) {
				sql+= "and ins.beginDate >= :startFrom ";
			}
			if (startEnd != null && startEnd.after(new Date(100,1,1))) {
				sql+= "and ins.beginDate < :startEnd ";
			}

			Query query = session.createQuery(sql);

			if(!StringUtils.isEmpty(insurance.getCarframeNum())){
				query.setString("carframeNum","%"+ insurance.getCarframeNum()+"%");
			}

			if(!StringUtils.isEmpty(insurance.getInsuranceNum())){
				query.setString("insuranceNum","%"+ insurance.getInsuranceNum()+"%");
			}

			if(!StringUtils.isEmpty(insurance.getInsuranceClass())){
				query.setString("insuranceClass", "%"+insurance.getInsuranceClass()+"%");
			}

			if(vehicle!=null){
				if(!StringUtils.isEmpty(vehicle.getLicenseNum())){
					query.setString("licenseNum", "%"+vehicle.getLicenseNum()+"%");
				}
				if (!StringUtils.isBlank(vehicle.getDept()) && !StringUtils.equalsIgnoreCase("全部",vehicle.getDept())){
					query.setString("dept", vehicle.getDept());
				}
			}

			if (inputFrom != null && inputFrom.after(new Date(100,1,1))) {
				query.setDate("inputFrom",inputFrom);
			}
			if (inputEnd != null && inputEnd.after(new Date(100,1,1))) {
				query.setDate("inputEnd",inputEnd);
			}
			if (startFrom != null && startFrom.after(new Date(100,1,1))) {
				query.setDate("startFrom",startFrom);
			}
			if (startEnd != null && startEnd.after(new Date(100,1,1))) {
				query.setDate("startEnd",startEnd);
			}

			query.setFirstResult(page.getBeginIndex());
			query.setMaxResults(page.getEveryPage());

			List list = query.list();
			Query q1 = session.createQuery(
					"select sum(div.money) from Insurance ins,InsuranceDivide2  div " +
							"where ins.id=div.id.insuranceId and ins.id=:id ");
			for (int i = 0; i < list.size(); i++) {
				Insurance ins = (Insurance) list.get(i);
				if (ins.getInsuranceClass().contains("商")){
					q1.setInteger("id",ins.getId());
					Double mm = (Double) q1.uniqueResult();
					InsuranceWithBaseMoney iw = new InsuranceWithBaseMoney(ins,mm);
					list.set(i,iw);
				}
			}
			return list;
		} catch (HibernateException e) {
			throw e;
		}finally {
			HibernateSessionFactory.closeSession();
		}
	}


	public static void main(String[] args) {
		ClassPathXmlApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
		HibernateSessionFactory.rebuildSessionFactory(applicationContext);
		InsuranceDaoImpl dao = (InsuranceDaoImpl) applicationContext.getBean(InsuranceDao.class);
		Page page = PageUtil.createPage(30,100,1);
		Vehicle vehicle = new Vehicle();

		Insurance insurance = new Insurance();
		insurance.setInsuranceClass("商");
		insurance.setCarframeNum("LFV2A5BS2E4072103");
		List<Insurance> list = dao.selectByCondition2(page,insurance,vehicle,null,null,null,null);
		for (Insurance insurance1 : list) {
			System.out.println(insurance1);
		}
		System.exit(0);
	}
}
