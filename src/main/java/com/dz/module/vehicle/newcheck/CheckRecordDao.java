package com.dz.module.vehicle.newcheck;

import java.util.Date;
import java.util.List;

/**
 * @author doggy
 *         Created on 15-12-7.
 */
public interface CheckRecordDao {
    boolean addOne(Group group, CheckRecord checkRecord);
    boolean deleteOneById(int id);
    boolean rePass(int id, String reason);
    List<CheckRecord> selectRecordsByTimePass(Date startTime, Date endTime);
}
