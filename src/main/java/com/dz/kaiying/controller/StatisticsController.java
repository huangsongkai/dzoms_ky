package com.dz.kaiying.controller;

import com.dz.kaiying.DTO.statistics.ValuePairDTO;
import com.dz.kaiying.service.statistics.*;
import com.dz.kaiying.util.Result;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by song on 2017/7/7.
 */
@Controller
@RequestMapping(value = "/statistics")
public class StatisticsController extends BaseController{
    @Resource
    private DriverStatisticsService driverStaService;
    @Resource
    private VehicleStatisticsService vehicleStaService;
    @Resource
    private ContractStatisticsService contractStatisticsService;
    @Resource
    private MeetingStatisticsService meetingStatisticsService;
    @Resource
    private ElectricHistoryStatisticsService accidentStatisticsService;
    @Resource
    private FinanceStatisticsService financeStatisticsService;


    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index(HttpServletRequest request) throws Exception {
        return "statistics/index";
    }

    @RequestMapping(value = "/driver/locationDistribution", method = RequestMethod.GET)
    @ResponseBody
    public Result driverLocationDistribution(HttpServletRequest request) throws Exception {
        Map<String, Integer> locMap = driverStaService.getLocationDistribution();
        List<ValuePairDTO> distList = new ArrayList<ValuePairDTO>();
        for(String key : locMap.keySet()){
            distList.add(new ValuePairDTO<String, Integer>(key, locMap.get(key)));
        }
        return success("", distList);
    }

    @RequestMapping(value = "/driver/ageDistribution", method = RequestMethod.GET)
    @ResponseBody
    public Result driverAgeDistribution(HttpServletRequest request) throws Exception {
        Map<Integer, Integer> locMap = driverStaService.getAgeDistribution();
        List<int[]> distList = new ArrayList<>();
        for(int key : locMap.keySet()){
            distList.add(new int[]{key, locMap.get(key)});
        }
        return success("", distList);
    }

    @RequestMapping(value = "/driver/statusDistribution", method = RequestMethod.GET)
    @ResponseBody
    public Result driverStatusDistribution(HttpServletRequest request) throws Exception {
        int[] counts = driverStaService.getStatusDistribution();
        List<ValuePairDTO> distList = new ArrayList<ValuePairDTO>();
        distList.add(new ValuePairDTO<String, Integer>("在职", counts[0]));
        distList.add(new ValuePairDTO<String, Integer>("离职", counts[1]));
        distList.add(new ValuePairDTO<String, Integer>("本年新入职", counts[2]));
        distList.add(new ValuePairDTO<String, Integer>("往年入职", counts[0]-counts[2]));
        return success("", distList);
    }
    @RequestMapping(value = "/driver/countByBranch", method = RequestMethod.GET)
    @ResponseBody
    public Result countByBranch(HttpServletRequest request) throws Exception {
        return success("", driverStaService.countByBranch());
    }

    @RequestMapping(value = "/driver/monthsNewEmployee", method = RequestMethod.GET)
    @ResponseBody
    public Result monthsNewEmployee(HttpServletRequest request) throws Exception {
        return success("", driverStaService.getDriverDistributionByMonth());
    }

    @RequestMapping(value = "/vehicle/statusDistribution", method = RequestMethod.GET)
    @ResponseBody
    public Result vehicleStatusDistribution(HttpServletRequest request) throws Exception {
        //        车辆状态 0-待开业新车 1-运营中 2-已报废 3-待开业二手车 -1-待审核的新车
        int[] counts = vehicleStaService.getStatusDistribution();
        String[] states = {"待开业新车","运营中","已报废","待开业二手车","待审核的新车"};
        List<ValuePairDTO> distList = new ArrayList<ValuePairDTO>();
        for(int i = 0; i<states.length; i++){
             distList.add(new ValuePairDTO<String, Integer>(states[i], counts[i]));
        }
        return success("", distList);
    }

    @RequestMapping(value = "/contract/wholeYear", method = RequestMethod.GET)
    @ResponseBody
    public Result contractLast3Month(HttpServletRequest request) throws Exception {
        return success("", contractStatisticsService.getStatusDistribution());
    }

    @RequestMapping(value = "/contract/branch", method = RequestMethod.GET)
    @ResponseBody
    public Result contractBranch(HttpServletRequest request) throws Exception {
        return success("", contractStatisticsService.getStatusDistributionByBranch());
    }
    @RequestMapping(value = "/vehicle/wholeYear", method = RequestMethod.GET)
    @ResponseBody
    public Result newAndTerminatedCarWholeYear(HttpServletRequest request) throws Exception {
        return success("", vehicleStaService.wholeYear());
    }

    @RequestMapping(value = "/meeting/wholeYear", method = RequestMethod.GET)
    @ResponseBody
    public Result meetingYear(HttpServletRequest request) throws Exception {
        return success("", meetingStatisticsService.getStatusDistribution());
    }
    @RequestMapping(value = "/electric/wholeYear", method = RequestMethod.GET)
    @ResponseBody
    public Result accidentYear(HttpServletRequest request) throws Exception {
        return success("", accidentStatisticsService.getStatusDistribution());
    }

    @RequestMapping(value = "/finance/wholeYear", method = RequestMethod.GET)
    @ResponseBody
    public Result financeYear(HttpServletRequest request) throws Exception {
        return success("", financeStatisticsService.getStatusDistribution());
    }

    @RequestMapping(value = "/finance/months", method = RequestMethod.GET)
    @ResponseBody
    public Result financeMonth(HttpServletRequest request) throws Exception {
        return success("", financeStatisticsService.getChargeMoney());
    }

    @RequestMapping(value = "/lead", method = RequestMethod.GET)
    public String index(){
        return "/lead";
    }



}
