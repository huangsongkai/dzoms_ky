package com.dz.module.vehicle.check;

import java.util.List;

/**
 * @author doggy
 *         Created on 15-10-14.
 */
public interface R_SelfCheckPlan_CarDao {
    /**
     * select all the relations by plan
     * @param plan:The plan that you want to select.
     * @return All the relation that plan included.
     */
    List<R_SelfCheckPlan_Car> selectByPlan(SelfCheckPlan plan);

    /**
     * select all the unpass relation by plan
     * @param plan:The plan that you want to select.
     * @return All the relation that unpass the check;
     */
    List<R_SelfCheckPlan_Car> selectDisPass(SelfCheckPlan plan);

    /**
     * Add a list of carId to plan
     * @param ids:The list
     * @return true if success else false
     */
    boolean addList(SelfCheckPlan plan, List<String> ids);

    /**
     * Remove all the realtions to the plan
     * @return true if success else false
     */
    boolean removeByPlan(SelfCheckPlan plan);

    /**
     * Update the plan by the new carIds.
     * @param ids:new id list to update the plan.
     * @return true if success else false
     */
    boolean updateByPlan(SelfCheckPlan plan, List<String> ids);

    /**
     * Set a car unpass a check in a plan with reason.
     * @param plan
     * @param carId:The car which unpass the check
     * @param reason:Why the car unpass the check
     * @return true if success else falsee
     */
    boolean disPass(SelfCheckPlan plan, String carId, String reason);
    boolean pass(SelfCheckPlan plan, String carFrameId);
}
