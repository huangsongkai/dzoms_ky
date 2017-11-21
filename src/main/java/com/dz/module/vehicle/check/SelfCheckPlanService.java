package com.dz.module.vehicle.check;

import com.dz.common.global.TimePass;
import com.dz.module.contract.Contract;
import com.dz.module.contract.ContractDao;
import com.dz.module.driver.Driver;
import com.dz.module.driver.DriverDao;
import com.dz.module.vehicle.Vehicle;
import com.dz.module.vehicle.VehicleDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * @author doggy
 *         Created on 15-10-14.
 */
@Service
public class SelfCheckPlanService {
    @Autowired
    private SelfCheckPlanDao planDao;
    @Autowired
    private R_SelfCheckPlan_CarDao relationDao;
    @Autowired
    private ContractDao contractDao;
    @Autowired
    private VehicleDao vehicleDao;
    @Autowired
    private DriverDao driverDao;


    /**
     * Add a new plan and add the relations to the plan.
     * @param plan:New Plan.
     * @param ids:The list of car that you want to add it to relation.
     * @return true if success else false.
     */
    public boolean addOne(SelfCheckPlan plan,List<String> ids){
        return planDao.addPlan(plan) && relationDao.addList(plan,ids);
    }

    /**
     * Update a plan and update the relations to the plan.
     * @param plan:The plan you want to update.
     * @param ids:The carIds that you want to update.
     * @return true if success else false.
     */
    public boolean updateOne(SelfCheckPlan plan,List<String> ids){
        return planDao.changePlan(plan) && relationDao.updateByPlan(plan,ids);
    }

    /**
     * Remove a plan and relation to cars.
     * @param plan:The plan you want to remove.
     * @return true if success else false.
     */
    public boolean removeOne(SelfCheckPlan plan){
        return planDao.removePlan(plan) && relationDao.removeByPlan(plan);
    }

    /**
     * Select plans that contains in (tp.startTime,tp.endTime).
     * @param tp:The timepass you want to select.
     * @return Plans's list.
     */
    public List<SelfCheckPlan> searchPlan(TimePass tp){
        return planDao.searchPlan(tp);
    }

    /**
     * Get contracts that connect to plan.
     * @param plan:plan.id mustn't be null.
     * @return Contract's list.
     */
    public List<PageShow> getPageShowByPlan(SelfCheckPlan plan){
        List<PageShow> list = new ArrayList<PageShow>();
        List<R_SelfCheckPlan_Car> rscs = relationDao.selectByPlan(plan);
        for(R_SelfCheckPlan_Car rsc:rscs){
            String id = rsc.getCarId();
            Contract c = contractDao.selectByCarId(id);
            if(c != null){
                PageShow ps = new PageShow();
                ps.setCarId(c.getCarframeNum());
                ps.setRenterId(c.getIdNum());
                ps.setContractId(c.getBusinessForm());
                ps.setRentStyle(c.getBusinessForm());
                //get renter_name
                Driver tmp = new Driver();
                tmp.setIdNum(c.getCarframeNum());
                Driver driver = driverDao.selectById(tmp.getIdNum());
                if(driver != null){
                    ps.setRenter(driver.getName());
                }
                //get vehicle_license_num
                Vehicle v = vehicleDao.selectByFrameId(c.getCarframeNum());
                ps.setLicense_num(v.getLicenseNum());
                list.add(ps);
            }
        }
        return list;
    }

    /**
     * Select all the car that dispass the check in the plan.
     * @return list of result.
     */
    public List<PageShow> selectDisPass(SelfCheckPlan plan){
        List<PageShow> list = new ArrayList<PageShow>();
        List<R_SelfCheckPlan_Car> rscs = relationDao.selectDisPass(plan);
        for(R_SelfCheckPlan_Car rsc:rscs){
            String id = rsc.getCarId();
            Contract c = contractDao.selectByCarId(id);
            if(c != null){
                PageShow ps = new PageShow();
                ps.setCarId(c.getCarframeNum());
                ps.setRenterId(c.getIdNum());
                ps.setContractId(c.getContractId());
                ps.setRentStyle(c.getBusinessForm());
                ps.setUnPassReason(rsc.getReason());
                //get renter_name
                Driver tmp = new Driver();
                tmp.setIdNum(c.getCarframeNum());
                Driver driver = driverDao.selectById(tmp.getIdNum());
                if(driver != null){
                    ps.setRenter(driver.getName());
                }
                //get vehicle_license_num
                Vehicle v = vehicleDao.selectByFrameId(c.getCarframeNum());
                ps.setLicense_num(v.getLicenseNum());
                list.add(ps);
            }
        }
        return list;
    }

    /**
     * dispass a relation with carId and reason.
     * @return true if success else false.
     */
    public boolean disPass(SelfCheckPlan plan, String carId, String reason){
        return relationDao.disPass(plan,carId,reason);
    }
    public boolean pass(SelfCheckPlan plan,String carFrameId){
        return relationDao.pass(plan,carFrameId);
    }

    /**
     * @param plan:Plan.id shouldn't be null.
     * @return The sql_plan.
     */
    public SelfCheckPlan selectPlanById(SelfCheckPlan plan){
        return planDao.selectPlanById(plan);
    }


    public SelfCheckPlanDao getPlanDao() {
        return planDao;
    }

    public void setPlanDao(SelfCheckPlanDao planDao) {
        this.planDao = planDao;
    }

    public R_SelfCheckPlan_CarDao getRelationDao() {
        return relationDao;
    }

    public void setRelationDao(R_SelfCheckPlan_CarDao relationDao) {
        this.relationDao = relationDao;
    }

    public ContractDao getContractDao() {
        return contractDao;
    }

    public void setContractDao(ContractDao contractDao) {
        this.contractDao = contractDao;
    }

    public VehicleDao getVehicleDao() {
        return vehicleDao;
    }

    public void setVehicleDao(VehicleDao vehicleDao) {
        this.vehicleDao = vehicleDao;
    }

    public DriverDao getDriverDao() {
        return driverDao;
    }

    public void setDriverDao(DriverDao driverDao) {
        this.driverDao = driverDao;
    }
}
