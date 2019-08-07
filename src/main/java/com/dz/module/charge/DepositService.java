package com.dz.module.charge;

import com.dz.common.factory.HibernateSessionFactory;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.stereotype.Repository;

import java.util.Collections;
import java.util.Date;
import java.util.List;

@Repository
public class DepositService {
    /**
     * 收取押金
     */
    public void add(Deposit deposit) {
        Session session = null;
        Transaction tx = null;
        try {
            session = HibernateSessionFactory.getSession();
            tx = session.beginTransaction();

            System.out.println(deposit.getCarframeNum());
            System.out.println(deposit.getIdNum());
            if (haveRecord(session, deposit.getCarframeNum(), deposit.getIdNum())) {
                throw new RuntimeException("该用户存在未付清的押金¿");
            }

            deposit.setInDate(new Date());
            session.saveOrUpdate(deposit);

            tx.commit();
            System.out.println("押金已存");
        } catch (HibernateException ex) {
            ex.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        } finally {
            if (session != null) {
                session.clear();
                session.close();
            }
        }
    }

    /**
     * 退还押金
     */
    public void withdraw(int depositId, double backMoney, String uName) {
        Session session = null;
        Transaction tx = null;
        try {
            session = HibernateSessionFactory.getSession();
            tx = session.beginTransaction();

            Deposit deposit = (Deposit) session.get(Deposit.class, depositId);

            if (deposit == null) {
                throw new RuntimeException("该用户没交过押金¿");
            }

            deposit.setBackMoney(deposit.getBackMoney() + backMoney);
            deposit.setBackDate(new Date());
            deposit.setuNameBack(uName);

            session.saveOrUpdate(deposit);

            tx.commit();
        } catch (HibernateException ex) {
            ex.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    public List search(String licenseNum, String driverName,String idNum,
                       String depositId,
                       Date inDateBegin, Date inDateEnd,
                       Date backDateBegin, Date backDateEnd, int currentPageNum) {
        Session session = null;
        try {
            session = HibernateSessionFactory.getSession();

            String hql = "select d from Deposit d,Driver dr where d.idNum=dr.idNum ";

            if (licenseNum != null) {
                hql += "and (d.carframeNum is null or d.carframeNum in (select v.carframeNum from Vehicle v where v.licenseNum like :licenseNum) ) ";
            }

            if (idNum != null) {
                hql += "and dr.idNum like :idNum ";
            }

            if (driverName != null) {
                hql += "and dr.name like :name ";
            }

            if (depositId != null) {
                hql += "and d.depositId like :depositId ";
            }
            if (inDateBegin != null && inDateEnd != null) {
                hql += "and d.inDate >= :inDateBegin and d.inDate <= :inDateEnd ";
            }

            if (backDateBegin != null && backDateEnd != null) {
                hql += "and d.backDate is not null and d.backDate >= :backDateBegin and d.backDate <= :backDateEnd ";
            }

            Query query = session.createQuery(hql);

            if (licenseNum != null) {
                query.setString("licenseNum", "%" + licenseNum + "%");
            }
            if (driverName != null) {
                query.setString("name", "%" + driverName + "%");
            }
            if (idNum != null) {
                query.setString("idNum", "%" + idNum + "%");
            }
            if (depositId != null) {
                query.setString("depositId", "%" + depositId + "%");
            }

            if (inDateBegin != null && inDateEnd != null) {
                query.setDate("inDateBegin", inDateBegin);
                query.setDate("inDateEnd", inDateEnd);
            }
            if (backDateBegin != null && backDateEnd != null) {
                query.setDate("backDateBegin", backDateBegin);
                query.setDate("backDateEnd", backDateEnd);
            }

            if (currentPageNum <= 0) currentPageNum = 1;
            query.setMaxResults(30);
            query.setFirstResult(currentPageNum * 30 - 30);

            return query.list();
        } catch (HibernateException ex) {
            ex.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return Collections.emptyList();
    }

    public long searchCount(String licenseNum, String driverName,
                            String depositId,
                            Date inDateBegin, Date inDateEnd,
                            Date backDateBegin, Date backDateEnd) {
        Session session = null;
        try {
            session = HibernateSessionFactory.getSession();

            String hql = "select count(d) from Deposit d,Driver dr " +
                    "where d.idNum=dr.idNum ";

            if (licenseNum != null) {
                hql += "and (d.carframeNum is null or d.carframeNum in (select v.carframeNum from Vehicle v where v.licenseNum like :licenseNum) ) ";
            }

            if (driverName != null) {
                hql += "and dr.name like :name ";
            }

            if (depositId != null) {
                hql += "and d.depositId like :depositId ";
            }
            if (inDateBegin != null && inDateEnd != null) {
                hql += "and d.inDate >= :inDateBegin and d.inDate <= :inDateEnd ";
            }

            if (backDateBegin != null && backDateEnd != null) {
                hql += "and d.backDate >= :backDateBegin and d.backDate <= :backDateEnd ";
            }

            Query query = session.createQuery(hql);

            if (licenseNum != null) {
                query.setString("licenseNum", "%" + licenseNum + "%");
            }
            if (driverName != null) {
                query.setString("name", "%" + driverName + "%");
            }
            if (depositId != null) {
                query.setString("depositId", "%" + depositId + "%");
            }

            if (inDateBegin != null && inDateEnd != null) {
                query.setDate("inDateBegin", inDateBegin);
                query.setDate("inDateEnd", inDateEnd);
            }
            if (backDateBegin != null && backDateEnd != null) {
                query.setDate("backDateBegin", backDateBegin);
                query.setDate("backDateEnd", backDateEnd);
            }

            return (long) query.uniqueResult();
        } catch (HibernateException ex) {
            ex.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return 0;
    }

    /**
     * @param beginDate 还款结束日期begin
     * @param endDate   还款结束日期end
     * @return
     */
    public boolean remove(Date beginDate, Date endDate) {
        Session session = null;
        Transaction tx = null;
        try {
            session = HibernateSessionFactory.getSession();
            tx = session.beginTransaction();

            if (beginDate == null || endDate == null) {
                return false;
            }

            String hql;
            hql = "delete from Deposit d where " +
                    "d.inMoney = d.backMoney " +
                    "and d.backDate >= :beginDate " +
                    "and d.backDate <= :endDate ";

            Query query = session.createQuery(hql);

            query.setDate("beginDate", beginDate);
            query.setDate("endDate", endDate);

            query.executeUpdate();

            tx.commit();
            return true;
        } catch (HibernateException ex) {
            ex.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return false;
    }

    public Deposit getById(int id) {
        Session session = null;
        try {
            session = HibernateSessionFactory.getSession();
            return (Deposit) session.get(Deposit.class, id);
        } catch (HibernateException ex) {
            ex.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return null;
    }

    private boolean haveRecord(Session session, String carframeNum, String idNum) {
        String hql = "select count(*) from Deposit d " +
                "where d.inMoney != d.backMoney " +
                "and d.carframeNum = :carframeNum " +
                "and d.idNum = :idNum";

        Query query = session.createQuery(hql);
        query.setString("carframeNum", carframeNum);
        query.setString("idNum", idNum);
        long count = (long) query.uniqueResult();
        System.out.println("count:" + count);
        return count > 0;
    }
}
