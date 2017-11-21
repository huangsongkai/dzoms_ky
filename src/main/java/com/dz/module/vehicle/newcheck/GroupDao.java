package com.dz.module.vehicle.newcheck;

import java.util.Date;
import java.util.List;

/**
 * @author doggy
 *         Created on 15-12-7.
 */
public interface GroupDao {
    boolean addOne(Plan plan, Group group);
    boolean deleteById(int id);
    Group getGroupById(int id);
    List<Group> searchGroupByTimeAndUser(int userId, Date time);
    Group getGroupWithRecord(int id);
}
