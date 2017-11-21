package com.dz.module.vehicle.newcheck;

import java.util.Date;
import java.util.List;

/**
 * @author doggy
 *         Created on 15-12-7.
 */
public interface PlanDao {
    boolean addOne(Plan plan);
    List<Plan> getPlans(Date time);
    Plan getPlanById(int id);
}
