package com.dz.module.vehicle.check;

import com.dz.common.global.TimePass;

import java.util.List;

/**
 * @author doggy
 * Created on 15-10-14.
 */
public interface SelfCheckPlanDao {
    /**
     * Add a new plan
     * @param plan:new Plan
     * @return true if success else false
     */
    boolean addPlan(SelfCheckPlan plan);

    /**
     * Remove a plan
     * @param plan:the plan that you want to remove
     * @return true if success else false
     */
    boolean removePlan(SelfCheckPlan plan);

    /**
     * Update a plan,this plan must have been saved.
     * @param plan:The plan you used to update sql_plan;
     * @return true if success else false
     */
    boolean changePlan(SelfCheckPlan plan);

    /**
     * Select plans that the time contained in the (tp.startTime,tp.endTime)
     * @return The suited plans with List
     */
    List<SelfCheckPlan> searchPlan(TimePass tp);

    /**
     * Select a sql_plan by plan.id.
     * @param plan:This param must contain plan.
     * @return sql_plan if success else null.
     */
    SelfCheckPlan selectPlanById(SelfCheckPlan plan);
}
