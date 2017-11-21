package com.dz.module.vehicle;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.global.Page;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.javatuples.Triplet;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;

@Repository(value = "vehicleDao")
public class VehicleDaoImpl implements VehicleDao {

	@Override
	public boolean addVehicle(Vehicle vehicle) throws HibernateException {
		// TODO Auto-generated method stub
		boolean flag = false;
		Session session = null;
		Transaction tx = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = (Transaction) session.beginTransaction();

			session.saveOrUpdate(vehicle);
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
	public boolean vehicleUpdate(Vehicle vehicle) throws HibernateException {
		// TODO Auto-generated method stub
		boolean flag = false;
		Session session = null;
		Transaction tx = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = (Transaction) session.beginTransaction();

			session.update(vehicle);
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
	public boolean delevehicle(Vehicle vehicle) throws HibernateException {
		// TODO Auto-generated method stub
		return false;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Vehicle> vehicleSearch(Page page, Vehicle vehicle,
			Triplet<String, String, Object>... conditions)
			throws HibernateException {
		// TODO Auto-generated method stub
		List<Vehicle> l = new ArrayList<Vehicle>();
		Session session = null;
		try {
			session = HibernateSessionFactory.getSession();

			String sql = "from Vehicle where state!=-1 ";
			if (vehicle != null) {

				if (!StringUtils.isEmpty(vehicle.getCarframeNum())) {
					sql += "and carframeNum like :carframeNum ";
				}

				if (!StringUtils.isEmpty(vehicle.getEngineNum())) {
					sql += "and engineNum like :engineNum ";
				}

				if (!StringUtils.isEmpty(vehicle.getCarMode())) {
					sql += "and carMode like :carMode ";
				}

				if (!StringUtils.isEmpty(vehicle.getCertifyNum())) {
					sql += "and certifyNum like :certifyNum ";
				}

				if (!StringUtils.isEmpty(vehicle.getDept())) {
					sql += "and dept like :dept ";
				}

				if (!StringUtils.isEmpty(vehicle.getDriverId())) {
					sql += "and driverId like :driverId ";
				}

				if (!StringUtils.isEmpty(vehicle.getLicenseNum())) {
					sql += "and licenseNum like :licenseNum ";
				}

				if (vehicle.getState() != null) {
					sql += "and state=:state ";
				}
			}

			for (Triplet<String, String, Object> condition : conditions) {
				if (condition != null) {
					sql += String.format("and %s %s :%s ",
							condition.getValue0(), condition.getValue1(),
							condition.getValue0());
				}
			}
			
			sql += " order by licenseNum ";

			Query query = session.createQuery(sql);
			query.setMaxResults(page.getEveryPage());
			query.setFirstResult(page.getBeginIndex());

			if (vehicle != null) {
				if (!StringUtils.isEmpty(vehicle.getCarframeNum())) {
					query.setString("carframeNum",
							"%" + vehicle.getCarframeNum() + "%");
				}

				if (!StringUtils.isEmpty(vehicle.getEngineNum())) {
					query.setString("engineNum", "%" + vehicle.getEngineNum()
							+ "%");
				}

				if (!StringUtils.isEmpty(vehicle.getCarMode())) {
					query.setString("carMode", "%" + vehicle.getCarMode() + "%");
				}

				if (!StringUtils.isEmpty(vehicle.getCertifyNum())) {
					query.setString("certifyNum", "%" + vehicle.getCertifyNum()
							+ "%");
				}

				if (!StringUtils.isEmpty(vehicle.getDept())) {
					query.setString("dept", "%" + vehicle.getDept() + "%");
				}

				if (!StringUtils.isEmpty(vehicle.getDriverId())) {
					query.setString("driverId", "%" + vehicle.getDriverId()
							+ "%");
				}

				if (!StringUtils.isEmpty(vehicle.getLicenseNum())) {
					query.setString("licenseNum", "%" + vehicle.getLicenseNum()
							+ "%");
				}

				if (vehicle.getState() != null) {
					query.setInteger("state", vehicle.getState());
				}
			}

			for (Triplet<String, String, Object> condition : conditions) {
				if (condition != null) {
					query.setParameter(condition.getValue0(),
							condition.getValue2());
				}
			}

			l = query.list();
			query = null;
		} catch (HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return l;
	}

	@Override
	public int vehicleSearchCount(Vehicle vehicle,
			Triplet<String, String, Object>... conditions)
			throws HibernateException {
		// TODO Auto-generated method stub
		Session session = null;
		try {
			session = HibernateSessionFactory.getSession();

			String sql = "select count(*) from Vehicle where state!=-1 ";

			if (vehicle != null) {
				if (!StringUtils.isEmpty(vehicle.getCarframeNum())) {
					sql += "and carframeNum like :carframeNum ";
				}

				if (!StringUtils.isEmpty(vehicle.getEngineNum())) {
					sql += "and engineNum like :engineNum ";
				}

				if (!StringUtils.isEmpty(vehicle.getCarMode())) {
					sql += "and carMode like :carMode ";
				}

				if (!StringUtils.isEmpty(vehicle.getCertifyNum())) {
					sql += "and certifyNum like :certifyNum ";
				}

				if (!StringUtils.isEmpty(vehicle.getDept())) {
					sql += "and dept like :dept ";
				}

				if (!StringUtils.isEmpty(vehicle.getDriverId())) {
					sql += "and driverId like :driverId ";
				}

				if (!StringUtils.isEmpty(vehicle.getLicenseNum())) {
					sql += "and licenseNum like :licenseNum ";
				}

				if (vehicle.getState() != null) {
					sql += "and state=:state ";
				}
			}

			for (Triplet<String, String, Object> condition : conditions) {
				if (condition != null) {
					sql += String.format("and %s %s :%s ",
							condition.getValue0(), condition.getValue1(),
							condition.getValue0());
				}
			}

			Query query = session.createQuery(sql);

			if (vehicle != null) {
				if (!StringUtils.isEmpty(vehicle.getCarframeNum())) {
					query.setString("carframeNum",
							"%" + vehicle.getCarframeNum() + "%");
				}

				if (!StringUtils.isEmpty(vehicle.getEngineNum())) {
					query.setString("engineNum", "%" + vehicle.getEngineNum()
							+ "%");
				}

				if (!StringUtils.isEmpty(vehicle.getCarMode())) {
					query.setString("carMode", "%" + vehicle.getCarMode() + "%");
				}

				if (!StringUtils.isEmpty(vehicle.getCertifyNum())) {
					query.setString("certifyNum", "%" + vehicle.getCertifyNum()
							+ "%");
				}

				if (!StringUtils.isEmpty(vehicle.getDept())) {
					query.setString("dept", "%" + vehicle.getDept() + "%");
				}

				if (!StringUtils.isEmpty(vehicle.getDriverId())) {
					query.setString("driverId", "%" + vehicle.getDriverId()
							+ "%");
				}

				if (!StringUtils.isEmpty(vehicle.getLicenseNum())) {
					query.setString("licenseNum", "%" + vehicle.getLicenseNum()
							+ "%");
				}

				if (vehicle.getState() != null) {
					query.setInteger("state", vehicle.getState());
				}

			}

			for (Triplet<String, String, Object> condition : conditions) {
				if (condition != null) {
					query.setParameter(condition.getValue0(),
							condition.getValue2());
				}
			}
			return Integer.parseInt(query.uniqueResult().toString());

		} catch (HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}

	@Override
	public Vehicle selectByLicense(Vehicle vehicle) {
		Session session = null;
		Transaction tx = null;
		Vehicle sql_vehicle = null;
		try {
			session = HibernateSessionFactory.getSession();
			tx = (Transaction) session.beginTransaction();
			String sql = "from Vehicle where licenseNum = :license_num";
			Query query = session.createQuery(sql);
			query.setString("license_num", vehicle.getLicenseNum());
			sql_vehicle = (Vehicle) query.uniqueResult();
			tx.commit();
		} catch (HibernateException e) {
			if (tx != null) {
				tx.rollback();
			}
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return sql_vehicle;
	}

	@Override
	public Vehicle selectByFrameId(String id) {
		Session session = null;
		Vehicle sql_vehicle = null;
		try {
			session = HibernateSessionFactory.getSession();
			sql_vehicle = (Vehicle) session.get(Vehicle.class, id);
		} catch (HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return sql_vehicle;
	}

	@SuppressWarnings("unchecked")
	public List<Vehicle> selectAll() {
		Session session = null;
		List<Vehicle> list = new ArrayList<Vehicle>();
		try {
			session = HibernateSessionFactory.getSession();
			Query query = session.createQuery("from Vehicle where state >=0 ");
			list = query.list();
		} catch (HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
		return list;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Vehicle> selectAll(Vehicle vehicle) {
		Session session = null;
		try {
			session = HibernateSessionFactory.getSession();

			String sql = "from Vehicle where state!=-1 and carframeNum like '%"
					+ (vehicle.getCarframeNum() == null ? "" : vehicle
							.getCarframeNum())
					+ "%' and engineNum like '%"
					+ (vehicle.getEngineNum() == null ? "" : vehicle
							.getEngineNum())
					+ "%' and carMode like '%"
					+ (vehicle.getCarMode() == null ? "" : vehicle.getCarMode())
					+ "%' and certifyNum like '%"
					+ (vehicle.getCertifyNum() == null ? "" : vehicle
							.getCertifyNum())
					+ "%' "
					+ "and dept like '%"
					+ (vehicle.getDept() == null ? "" : vehicle.getDept())
					+ "%' "
					+ (vehicle.getDriverId() == null ? ""
							: "%' and driverId like '%" + vehicle.getDriverId())
					+ "%' "
					+ "and licenseNum like '%"
					+ (vehicle.getLicenseNum() == null ? "" : vehicle
							.getLicenseNum()) + "%' ";

			if (vehicle.getState() != null) {
				sql += "and state=:state ";
			}

			Query query = session.createQuery(sql);

			if (vehicle.getState() != null) {
				query.setInteger("state", vehicle.getState());
			}

			return query.list();
		} catch (HibernateException e) {
			throw e;
		} finally {
			HibernateSessionFactory.closeSession();
		}
	}
}
