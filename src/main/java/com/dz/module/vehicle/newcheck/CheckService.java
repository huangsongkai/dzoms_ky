package com.dz.module.vehicle.newcheck;

import com.dz.common.global.BaseAction;
import com.dz.common.global.FileHelper;
import com.dz.common.other.FileUploadUtil;
import com.dz.common.other.ObjectAccess;
import com.dz.module.driver.Driver;
import com.dz.module.driver.DriverDao;
import com.dz.module.user.User;
import com.dz.module.user.UserDao;
import com.dz.module.vehicle.Vehicle;
import com.opensymphony.xwork2.ActionContext;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Predicate;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.util.*;

/**
 * @author doggy
 *         Created on 15-12-7.
 */
@Service
public class CheckService{
    @Autowired
    private CheckRecordDao checkRecordDaoImp;
    @Autowired
    private GroupDao groupDaoImp;
    @Autowired
    private PlanDao planDaoImp;
    @Autowired
    private UserDao userDaoImp;
    @Autowired
    private UnPassDetailDao unPassDetailDao;
    @Autowired
    private DriverDao driverDao;

    public boolean rePass(int checkRecordId,String reason){
        return checkRecordDaoImp.rePass(checkRecordId, reason);
    }

    public List<CheckRecord> selecctCheckRecordsByTimePass(Date startTime, Date endTime){
        if(startTime == null){
            DateTime dt = new DateTime();
            startTime = dt.minusYears(100).toDate();
        }
        if(endTime == null){
            DateTime dt = new DateTime();
            endTime = dt.plusYears(100).toDate();
        }
        List<CheckRecord> crs = checkRecordDaoImp.selectRecordsByTimePass(startTime, endTime);
        for(CheckRecord each:crs){
            if(each.getDriver() != null){
                Driver d = (Driver)ObjectAccess.getObject("com.dz.module.driver.Driver",each.getDriver());
                each.setRenter(d == null?"":d.getName());
            }
        }
        return crs;
    }

    public Map<String, List<TJMessage>> tonji(Date startTime, Date endTime){
        if(startTime == null){
            DateTime dt = new DateTime();
            startTime = dt.minusYears(100).toDate();
        }
        if(endTime == null){
            DateTime dt = new DateTime();
            endTime = dt.plusYears(100).toDate();
        }
        Map<String, List<TJMessage>> maps = new HashMap<>();
        maps.put("checked",new ArrayList<TJMessage>());
        maps.put("unchecked", new ArrayList<TJMessage>());
        List<Vehicle> allVehicle = ObjectAccess.query(Vehicle.class,"");
        List<CheckRecord> checkRecords = checkRecordDaoImp.selectRecordsByTimePass(startTime,endTime);
        List<String> vehicleIds = new ArrayList<String>();
        for(CheckRecord each:checkRecords){
            vehicleIds.add(each.getCarFrameNum());
        }
        for(Vehicle each: allVehicle){
            if(each.getDriverId() != null){
                String carFrameNum = each.getCarframeNum();
                List<TJMessage> tjms = null;
                if(vehicleIds.contains(carFrameNum)) {
                    tjms = maps.get("checked");
                    System.out.println("checked");
                }else
                    tjms = maps.get("unchecked");
                TJMessage tjm = new TJMessage();
                tjm.setLicenseNUm(each.getLicenseNum());
                Driver driver = (Driver)ObjectAccess.getObject("com.dz.module.driver.Driver", each.getDriverId());
                tjm.setRenter(driver != null?driver.getName():"");
                tjm.setDept(each.getDept());
                tjm.setTelephone(driver != null?driver.getPhoneNum1():"");
                tjms.add(tjm);
            }
        }
        return maps;
    }

    public boolean addCheckRecord(Group group,CheckRecord checkRecord){
        return checkRecordDaoImp.addOne(group,checkRecord);
    }
    public boolean addPlan(Plan plan){
        return planDaoImp.addOne(plan);
    }
    public boolean addGroup(Plan plan,Group group){
        return groupDaoImp.addOne(plan,group);
    }
    public Plan getPlanById(int id){
        return planDaoImp.getPlanById(id);
    }
    public Group getGroupById(int id){
        return groupDaoImp.getGroupById(id);
    }
    public boolean deleteGroupBy(int id){
        return groupDaoImp.deleteById(id);
    }
    public List<User> getUserByGroupId(int groupId){
        Group group = getGroupById(groupId);
        final Set<Integer> userIds = group.getCheckerIds();
        List<User> users = userDaoImp.getAll();
        CollectionUtils.filter(users, new Predicate() {
            @Override
            public boolean evaluate(Object o) {
                if(o == null) return false;
                User u = (User)o;
                if(userIds.contains(u.getUid())){
                    return true;
                }
                return false;
            }
        });
        return users;
    }
    public boolean addRecord(Group group,CheckRecord checkRecord){
        return checkRecordDaoImp.addOne(group,checkRecord);
    }
    public List<Group> searchGroupByTimeAndUser(int userId,Date time){
        return groupDaoImp.searchGroupByTimeAndUser(userId,time);
    }
    public Group getGroupWithRecord(int groupId){
        return groupDaoImp.getGroupWithRecord(groupId);
    }
    public boolean deleteRecord(int id){
        return checkRecordDaoImp.deleteOneById(id);
    }
    public List<Plan> searchPlansByTime(Date 时间){
        return planDaoImp.getPlans(时间);
    }
    public List<User> getAllUser(){
        return userDaoImp.getAll();
    }

    public boolean addUnPassDetail(CheckRecord checkRecord,UnPassDetail unPassDetail,String seq){
        try{
            if(seq != null){
                System.out.println(seq);
                ActionContext actionContext = ActionContext.getContext();
                Map<String,Object> fmaps = actionContext.getApplication();
                Map<String,String> fmap = (Map)fmaps.get("TempFileMap");
                String fileName = (String)(fmap).get(seq);
                String absolutePath = "/lala/pictures/unpass/"+checkRecord.getId()+"/"+fileName;
                File dir = new File(System.getProperty("com.dz.root")+"lala/pictures/unpass/"+checkRecord.getId());
                if(!dir.exists())
                    dir.mkdirs();
                File f = new File(dir,fileName);
                if(FileUploadUtil.store(seq,f)){
                    unPassDetail.setUnPassPicture(absolutePath);
                }
            }
            unPassDetail.setCheckRecord(checkRecord);
        }catch (Exception e){
            e.printStackTrace();
        }
        return unPassDetailDao.addOne(unPassDetail);
    }
}

