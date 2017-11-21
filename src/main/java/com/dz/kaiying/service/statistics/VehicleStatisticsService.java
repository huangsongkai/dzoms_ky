package com.dz.kaiying.service.statistics;

import com.dz.kaiying.repository.hiber.HibernateDao;
import com.dz.module.vehicle.Vehicle;
import com.dz.module.vehicle.VehicleApproval;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by song on 2017/7/7.
 */
@Service
public class VehicleStatisticsService extends StatisticsService{
    @Resource
    HibernateDao<Vehicle, Integer> vehicleHiberDao;
    @Resource
    HibernateDao<VehicleApproval, Integer> vehicleApprovalHiberDao;
    public int[] getStatusDistribution() {
        int[] driverCount = new int[5];
//        车辆状态 0-待开业新车 1-运营中 2-已报废 3-待开业二手车 -1-待审核的新车
        driverCount[0] = vehicleHiberDao.find("from Vehicle where state=0").size();
        driverCount[1] = vehicleHiberDao.find("from Vehicle where state=1").size();
        driverCount[2] = vehicleHiberDao.find("from Vehicle where state=2").size();
        driverCount[3] = vehicleHiberDao.find("from Vehicle where state=3").size();
        driverCount[4] = vehicleHiberDao.find("from Vehicle where state=-1").size();
        return driverCount;
    }
    public MonthsCountDto wholeYear(){
        String[] sqls = {
                "from Vehicle where in_date > $firstDay and in_date < $lastDay",
                "from VehicleApproval where branch_manager_approval_date >= $firstDay and branch_manager_approval_date < $lastDay",
                "from VehicleApproval where branch_manager_approval_date >= $firstDay and branch_manager_approval_date < $lastDay",
                "from Contract where contract_end_date >= $firstDay and contract_end_date<$lastDay",
                "from VehicleApproval where termination_date >= $firstDay and termination_date < $lastDay"
        };
        return wholeYearBar(sqls, vehicleApprovalHiberDao);
    }
}
