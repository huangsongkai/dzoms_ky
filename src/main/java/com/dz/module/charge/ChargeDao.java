package com.dz.module.charge;

import java.util.Date;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;

/**
 * @author doggy
 *         Created on 15-11-12.
 */
public interface ChargeDao {
    boolean addBatchPlan(BatchPlan batchPlan);
    boolean deleteBatchPlan(BatchPlan batchPlan);
    boolean addChargePlan(ChargePlan chargePlan);
    boolean deleteChargePlan(ChargePlan chargePlan);
    /**
     * 获取当月该合同所有计划，date 的日期部分将被忽略
     * @param contractId
     * @param date
     * @return
     */
    List<ChargePlan> getAllRecords(int contractId, Date date);
    List<ChargePlan> getUnclears(int contractId, Date date);
    List<ChargePlan> getACarRecords(int contractId);
    List<ChargePlan> getAll(Date time, String feeType);
    ChargePlan getChargePlanById(int id);
    BatchPlan getBatchPlanById(int id);
    boolean cleared(ChargePlan plan);
    List<BatchPlan> searchBatchPlan(int contractId);

    /**
     * 把计划在合同之间进行迁移
     * @param srcId 源合同号id
     * @param srcTime 将>=该年月的未清算合同进行迁移
     * @param destId 目标合同id
     * @param destTime 迁移到的年月
     * @return
     */
    boolean planTransfer(int srcId, Date srcTime, int destId, Date destTime);

    /**
     * 设置从beginDate开始的月份之后的chargePlan为已清账,beginDate为承包日期.
     * @param srcId 合同id
     * @param beginDate 承包日期
     * @return
     */
    boolean setCleared(int srcId, Date beginDate);

    /**
     * 把time的合同重新计算.
     * @param cid
     * @param time
     */
    void addAndDiv(int cid, Date time);
	void addAndDiv(int cid, Date time, Session session)
			throws HibernateException;
	void setCleared(int srcId, Date beginDate, Session session)
			throws HibernateException;
}
