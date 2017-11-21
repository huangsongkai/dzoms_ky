package com.dz.kaiying.service;

import com.dz.kaiying.DTO.*;
import com.dz.kaiying.model.*;
import com.dz.kaiying.repository.hiber.HibernateDao;
import com.dz.kaiying.util.Result;
import com.dz.module.user.User;
import com.dz.module.user.UserDao;
import org.activiti.engine.FormService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.TaskService;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.apache.commons.beanutils.BeanUtils;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.lang.reflect.InvocationTargetException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by song.
 */
@Service
public class JobDutiesService extends BaseService{
    @Resource
    HibernateDao<JobDuty, Integer> jobDutyDao;
    @Resource
    HibernateDao<User, Integer> userDao;
    @Resource
    HibernateDao<UserJobDuties, Integer> userJobDutiesDao;
    @Resource
    HibernateDao<SelfEvaluate, Integer> selfEvaluateDao;
    @Resource
    HibernateDao<SelfEvaluateDetail, Integer> selfEvaluateDetailDao;
    @Resource
    HibernateDao<DepartmentEvaluate, Integer> deparmentEvaluateDao;
    @Resource
    HibernateDao<DeparmentEvaluateDetail, Integer> deparmentEvaluateDetailDao;
    @Resource
    HibernateDao<ManagerEvaluate, Integer> managerEvaluateDao;
    @Resource
    HibernateDao<ManagerEvaluateDetail, Integer> managerEvaluateDetailDao;
    @Resource
    HibernateDao<EvaluateDetail, Integer> evaluateDetailDao;

    @Resource
    UserDao userDao1;
    //流程相关
    @Resource
    private ActivitiService activitiService;
    @Resource
    TaskService taskService;
    @Resource
    FormService formService;
    @Resource
    RepositoryService repositoryService;

    private Result result = new Result();


    //定时任务启动绩效考核  5 0 0 5 * ?   每月5号
    @Scheduled(cron="5 0 0 5 * ? ") //每个月五号执行
    public void stratrJobDuty(){
        List<User> userList = userDao1.getAll();
        for (User user: userList) {
            Map<String, String> variableMap = new HashMap<String, String>();
            ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionKey("duty_check").latestVersion().singleResult();
            variableMap.put("userName1", user.getUname());
            ProcessInstance processInstance = formService.submitStartFormData(processDefinition.getId(), variableMap);
        }

    }

    public Result<JobDuty> queryAll() {
        List<JobDuty> JobDutiesList = jobDutyDao.find("from JobDuty");
        result.setSuccess("查询成功",JobDutiesList);
        return result;
    }

    public JobDuty queryById(int id) {
        return jobDutyDao.get(JobDuty.class, id);
    }

    public Result save(JobDuty jobDuties) {
        Integer id = jobDutyDao.save(jobDuties);
        //      jobDuties.setId(id);
        result.setSuccess("保存成功",jobDuties);
        return result;
    }
    @Transactional
    public Result delete(int[] ids) {
        for (int id : ids) {
            jobDutyDao.deleteByKey(JobDuty.class, id);
        }

        result.setSuccess("删除成功",null);
        return result;
    }
    @Transactional
    public Result upadte(JobDuty jobDuties) {
        jobDutyDao.update(jobDuties);
        result.setSuccess("保存成功",jobDuties);
        return result;
    }

    public  List<User> queryUser() {
        List userList = userDao.find(" from User");
        return userList;
    }

    public User queryUserById(int id) {
        return  userDao.get(User.class, id);
    }

    public Result queryUserJob(int id) {
        List<UserJobDuties> userJobDuties = userJobDutiesDao.find(" from UserJobDuties where personId = "+id);
        List<UserJobDutyDTO> userJobDutiesDTOList = new ArrayList<>();

        for (UserJobDuties userJobs :userJobDuties ) {
            UserJobDutyDTO userJobDutiesDTO = new UserJobDutyDTO();
            userJobDutiesDTO.setKey(userJobs.getJobDutiesId());
            userJobDutiesDTO.setScore(userJobs.getScore());
            userJobDutiesDTOList.add(userJobDutiesDTO);
        }
        result.setSuccess("查询成功",userJobDutiesDTOList);
        return result;
    }

    public Result saveUserJob(SaveUserJobDutyDTO saveUserJobDutiesDTO) {
        //每次变更之前先把这个人的才删除掉
        List<UserJobDuties> userJobDutieList = userJobDutiesDao.find("from UserJobDuties where personId = " + saveUserJobDutiesDTO.getPersonId());
        for (UserJobDuties userJob: userJobDutieList) {
            userJobDutiesDao.delete(userJob);
        }

        Map<Integer, String > JobListMap = saveUserJobDutiesDTO.getJobList();
        for (Map.Entry<Integer, String> entry : JobListMap.entrySet()) {
            Integer key = entry.getKey();
            String value = entry.getValue().toString();
            System.out.println("key =" + key + " value = " + value);
            UserJobDuties userJobDuties = new UserJobDuties();
            userJobDuties.setPersonId(saveUserJobDutiesDTO.getPersonId());
            userJobDuties.setScore(Integer.parseInt(value));
            userJobDuties.setJobDutiesId(key);
            userJobDutiesDao.save(userJobDuties);
        }
        result.setSuccess("保存成功",null);
        return result;
    }

    // TODO: 2017/5/24  session 获取那块的用户Id
    public Result myEvaluate(HttpServletRequest request, Integer taskId) throws Exception {
        SimpleDateFormat dateFormater = new SimpleDateFormat("yyyy-MM");
        HttpSession session = request.getSession();
        List <SelfEvaluateDTO> selfEvaluateDTOList = new ArrayList<>();
        if (session != null){
            User user = (User) session.getAttribute("user");
            Integer userId = user.getUid();
            List<UserJobDuties> userJobDutiesList = userJobDutiesDao.find(" from UserJobDuties where personId = " + userId);
            for (UserJobDuties userJobDuties: userJobDutiesList) {
                SelfEvaluateDTO selfEvaluateDTO = new SelfEvaluateDTO();
                List<JobDuty> jobDutyList = jobDutyDao.find(" from JobDuty where id = " + userJobDuties.getJobDutiesId());
                BeanUtils.copyProperties(selfEvaluateDTO, jobDutyList.get(0));  //前边是空值 后边是有值得  进行对象copy
                selfEvaluateDTO.setChildProValue(userJobDuties.getScore());
                selfEvaluateDTO.setEvaluateName(user.getUname()+dateFormater.format(new Date())+"绩效考核");
                selfEvaluateDTOList.add(selfEvaluateDTO);
            }
            result.setSuccess("查询成功", selfEvaluateDTOList);
        }
        return result;
    }
    //把主表的id存在流程中 名称 selfEvaluateId
    public Result saveMyEvaluate(SaveSelfEvaluateDTO selfEvaluateDTO, Integer userId, Integer taskId) throws InvocationTargetException, IllegalAccessException {


//        SelfEvaluate selfEvaluate = new SelfEvaluate();
//        selfEvaluate.setCreateDate(new Date());
//
//        selfEvaluate.setEvaluateName(selfEvaluateDTO.getEvaluateName());
//        selfEvaluate.setTotal(selfEvaluateDTO.getTotal());//总分
//        Integer id = selfEvaluateDao.save(selfEvaluate);

        for (Map.Entry<Integer, SaveSelfEvaluateDetailDTO> entry : selfEvaluateDTO.getSelfEvaluate().entrySet()) {
            Integer key = entry.getKey();
            SaveSelfEvaluateDetailDTO selfEvaluateDetailDTO = entry.getValue();
            String inputs =  "";
            SelfEvaluateDetail selfEvaluateDetail = new SelfEvaluateDetail();
            int index = 1;
            for (String input : selfEvaluateDetailDTO.getInputs()) {
                if (index == selfEvaluateDetailDTO.getInputs().length ){
                    inputs += input;
                }else{
                    inputs +=input+"&";
                }
                index++;
            }
            EvaluateDetail evaluateDetail = new EvaluateDetail();
            evaluateDetail.setPersonId(userId);
            evaluateDetail.setSelfDate(new Date());
            evaluateDetail.setEvaluateName(selfEvaluateDTO.getEvaluateName());
            evaluateDetail.setSelfInputs(inputs);
            evaluateDetail.setJobDutyId(key);
            evaluateDetail.setSelfTotal((double)selfEvaluateDTO.getTotal());
            evaluateDetail.setSelfScore(selfEvaluateDetailDTO.getScore());
            List jobDutyList = jobDutyDao.find("from JobDuty where id =" + key);
            JobDuty jobDuty  = (JobDuty) jobDutyList.get(0);
            BeanUtils.copyProperties(evaluateDetail, jobDuty);  //前边是空值 后边是有值得  进行对象copy
            evaluateDetailDao.save(evaluateDetail);

//            selfEvaluateDetail.setInputs(inputs);
//            selfEvaluateDetail.setScore(selfEvaluateDetailDTO.getScore());
//            selfEvaluateDetail.setSelfEvaluateId(id);
//            selfEvaluateDetail.setJobDutyId(key);
//            selfEvaluateDetailDao.save(selfEvaluateDetail);
        }
        //工作流

        Map<String, String> valsMap = new HashMap<>();
        valsMap.put("考核名称",selfEvaluateDTO.getEvaluateName());
        valsMap.put("人员ID",userId+"");
        valsMap.put("自评分数",selfEvaluateDTO.getTotal()+"");
        User user = userDao1.getUserByUid(userId);
        String userName = user.getUname();
        String department = user.getDepartment();
        if ("汤伟丽".equals(userName) || "孙大勇".equals(userName) || "刘波".equals(userName)) {
            valsMap.put("userName","王星");//动态办理人
            activitiService.complete(taskId+"", valsMap);
            result.setSuccess("保存成功",null);
            return result;
        }else if("计财部".equals(department)){
            valsMap.put("userName","陈东慧");//动态办理人
        }else if("综合办公室".equals(department)){
            valsMap.put("userName","邹研");//动态办理人
        }else if("信息部".equals(department)){
            valsMap.put("userName","李志强");//动态办理人
        }else if("运营管理部".equals(department)){
            valsMap.put("userName","夏滨");//动态办理人
        }
        //userName
        activitiService.complete(taskId+"", valsMap);
        result.setSuccess("保存成功",null);
        return result;
    }


    //从主表的id存在流程中 名称 selfEvaluateId
    public Result departmentEvaluate(HttpServletRequest request, Integer taskId) throws InvocationTargetException, IllegalAccessException {
        String personId = (String) taskService.getVariable(taskId + "", "人员ID");
        String evaluateName = (String) taskService.getVariable(taskId + "", "考核名称");
        List<EvaluateDetail> evaluateDetailList = evaluateDetailDao.find("from EvaluateDetail  where evaluateName = '"+evaluateName+"' and personId ="+personId); //自评分主表 拼条件


        List<DepartmentEvaluateDTO> DepartmentEvaluateDTOList = new ArrayList<DepartmentEvaluateDTO>();
//        List<SelfEvaluate> selfEvaluate = selfEvaluateDao.find("from SelfEvaluate  where evaluateName = '"+evaluateName+"' and personId ="+personId); //自评分主表 拼条件
//        List<SelfEvaluateDetail>  selfEvaluateDetailList = selfEvaluateDetailDao.find("from SelfEvaluateDetail where selfEvaluateId =" + selfEvaluate.get(0).getId());
        for ( EvaluateDetail evaluateDetail: evaluateDetailList ) {
//            List<JobDuty> jobDutyList = jobDutyDao.find(" from JobDuty where id = " + selfEvaluateDetail.getJobDutyId());
            List<UserJobDuties> userJobDutiesList = userJobDutiesDao.find(" from UserJobDuties where personId = " + personId+" and jobDutiesId = "+evaluateDetail.getJobDutyId() );
            UserJobDuties userJobDuties = userJobDutiesList.get(0);
//            JobDuty jobDuty = jobDutyList.get(0);
            DepartmentEvaluateDTO departmentEvaluateDTO = new DepartmentEvaluateDTO();
            departmentEvaluateDTO.setChildProName(evaluateDetail.getChildProName());
            departmentEvaluateDTO.setChildProValue(userJobDuties.getScore());
            departmentEvaluateDTO.setComplete(evaluateDetail.getComplete());
            departmentEvaluateDTO.setInputs(evaluateDetail.getSelfInputs().split("&"));
            departmentEvaluateDTO.setJobResponsibility(evaluateDetail.getJobResponsibility());
            departmentEvaluateDTO.setJobStandard(evaluateDetail.getJobStandard());
            departmentEvaluateDTO.setScoreStandard(evaluateDetail.getScoreStandard());
            departmentEvaluateDTO.setId(evaluateDetail.getJobDutyId());
            departmentEvaluateDTO.setProName(evaluateDetail.getProName());
            departmentEvaluateDTO.setZiping( evaluateDetail.getSelfScore());
            departmentEvaluateDTO.setEvaluateName(evaluateDetail.getEvaluateName());
            DepartmentEvaluateDTOList.add(departmentEvaluateDTO);
        }
        result.setSuccess("查询成功",DepartmentEvaluateDTOList);
        return result;
    }



    public Result savedepartmentEvaluate(SaveDepartmentEvaluateDTO saveDepartmentEvaluateDTO, Integer taskId) {
        String personId = (String) taskService.getVariable(taskId + "", "人员ID");


        DepartmentEvaluate deparmentEvaluate = new DepartmentEvaluate();
        deparmentEvaluate.setCreateDate(new Date());
        deparmentEvaluate.setPersonId(personId);
        deparmentEvaluate.setEvaluateName(saveDepartmentEvaluateDTO.getEvaluateName());
        deparmentEvaluate.setTotal(saveDepartmentEvaluateDTO.getTotal());//总分
        Integer id = deparmentEvaluateDao.save(deparmentEvaluate);
        if (saveDepartmentEvaluateDTO != null){
            for (Map.Entry<Integer, Integer> entry : saveDepartmentEvaluateDTO.getDepartmentEvaluate().entrySet()) {
                Integer key = entry.getKey();
                Integer value = entry.getValue();
                List<EvaluateDetail> evaluateDetailList = evaluateDetailDao.find("from EvaluateDetail  where evaluateName = '"+saveDepartmentEvaluateDTO.getEvaluateName()+"' and personId ="+personId+" and jobDutyId ="+key); //
                EvaluateDetail evaluateDetail = evaluateDetailList.get(0);
                evaluateDetail.setManagerDate(new Date());
                evaluateDetail.setManagerScore(value);
                evaluateDetail.setManagerTotal(Double.parseDouble(saveDepartmentEvaluateDTO.getTotal()+""));
                evaluateDetailDao.update(evaluateDetail);
//                DeparmentEvaluateDetail deparmentEvaluateDetail = new DeparmentEvaluateDetail();
//                deparmentEvaluateDetail.setScore(value);
//                deparmentEvaluateDetail.setDeparmentEvaluateId(id);
//                deparmentEvaluateDetail.setJobDutyId(key);
//                deparmentEvaluateDetailDao.save(deparmentEvaluateDetail);
            }
        }
        Map<String, String> valsMap = new HashMap<>();
        valsMap.put("部门评分",saveDepartmentEvaluateDTO.getTotal()+"");
        User user = userDao1.getUserByUid(Integer.parseInt(personId));
        String userName = user.getUname();
        String department = user.getDepartment();
        valsMap.put("userName","考核组");//动态办理人

        activitiService.complete(taskId+"", valsMap);
        result.setSuccess("保存成功",null);
        return result;
    }

    public Result managerEvaluate(HttpServletRequest request, Integer taskId) {
        String personId = (String) taskService.getVariable(taskId + "", "人员ID");
        String evaluateName = (String) taskService.getVariable(taskId + "", "考核名称");


        List<EvaluateDetail> evaluateDetailList = evaluateDetailDao.find("from EvaluateDetail  where evaluateName = '"+evaluateName+"' and personId ="+personId); //自评分主表 拼条件
        List<ManagerEvaluateDTO> managerEvaluateDTOList = new ArrayList<ManagerEvaluateDTO>();
//        List<DepartmentEvaluate> deparmentEvaluate = deparmentEvaluateDao.find("from DepartmentEvaluate where evaluateName = '"+evaluateName+"' and personId ="+personId); //自评分主表 拼条件 evaluateName
//        List<DeparmentEvaluateDetail>  deparmentEvaluateDetailList = deparmentEvaluateDetailDao.find("from DeparmentEvaluateDetail where deparmentEvaluateId =" + deparmentEvaluate.get(0).getId());
        for ( EvaluateDetail evaluateDetail: evaluateDetailList ) {
//            List<JobDuty> jobDutyList = jobDutyDao.find(" from JobDuty where id = " + deparmentEvaluateDetail.getJobDutyId());
            List<UserJobDuties> userJobDutiesList = userJobDutiesDao.find(" from UserJobDuties where personId = " + personId+" and jobDutiesId = "+evaluateDetail.getJobDutyId() );
            UserJobDuties userJobDuties = userJobDutiesList.get(0);
//            JobDuty jobDuty = jobDutyList.get(0);
//            List<SelfEvaluate> selfEvaluate = selfEvaluateDao.find("from SelfEvaluate where evaluateName = '"+evaluateName+"' and personId ="+personId); //自评分主表 拼条件
//            List<SelfEvaluateDetail>  selfEvaluateDetailList = selfEvaluateDetailDao.find("from SelfEvaluateDetail where selfEvaluateId =" + selfEvaluate.get(0).getId() +"and jobDutyId ="+deparmentEvaluateDetail.getJobDutyId());
            ManagerEvaluateDTO managerEvaluateDTO = new ManagerEvaluateDTO();
            managerEvaluateDTO.setChildProName(evaluateDetail.getChildProName());
            managerEvaluateDTO.setChildProValue(userJobDuties.getScore());
            managerEvaluateDTO.setComplete(evaluateDetail.getComplete());
            managerEvaluateDTO.setInputs(evaluateDetail.getSelfInputs().split("&"));
            managerEvaluateDTO.setJobResponsibility(evaluateDetail.getJobResponsibility());
            managerEvaluateDTO.setJobStandard(evaluateDetail.getJobStandard());
            managerEvaluateDTO.setScoreStandard(evaluateDetail.getScoreStandard());
            managerEvaluateDTO.setId(evaluateDetail.getJobDutyId());
            managerEvaluateDTO.setProName(evaluateDetail.getProName());
            managerEvaluateDTO.setZiping(evaluateDetail.getSelfScore());
            managerEvaluateDTO.setBumen(evaluateDetail.getManagerScore());
            managerEvaluateDTO.setEvaluateName(evaluateDetail.getEvaluateName());
            managerEvaluateDTOList.add(managerEvaluateDTO);
        }
        result.setSuccess("查询成功",managerEvaluateDTOList);
        return result;
    }



    public Result saveManagerEvaluate(SaveManagerEvaluateDTO saveManagerEvaluateDTO, HttpServletRequest request, Integer taskId) {
        String personId = (String) taskService.getVariable(taskId + "", "人员ID");
        String evaluateName = (String) taskService.getVariable(taskId + "", "考核名称");



        SimpleDateFormat dateFormater = new SimpleDateFormat("yyyy-MM-dd");
        ManagerEvaluate managerEvaluate = new ManagerEvaluate();
        managerEvaluate.setCreateDate(new Date());
        managerEvaluate.setPersonId(personId);
        managerEvaluate.setEvaluateName(saveManagerEvaluateDTO.getEvaluateName());
        managerEvaluate.setTotal(saveManagerEvaluateDTO.getTotal());//总分
        Integer id = managerEvaluateDao.save(managerEvaluate);
        if (saveManagerEvaluateDTO != null){
            for (Map.Entry<Integer, String> entry : saveManagerEvaluateDTO.getManagerEvaluate().entrySet()) {
                Integer key = entry.getKey();
                String value = entry.getValue();
                List<EvaluateDetail> evaluateDetailList = evaluateDetailDao.find("from EvaluateDetail  where evaluateName = '"+saveManagerEvaluateDTO.getEvaluateName()+"' and personId ="+personId ); //
                for (EvaluateDetail evaluateDetail: evaluateDetailList) {
                    evaluateDetail.setGroupTotal(Double.parseDouble(saveManagerEvaluateDTO.getTotal()+""));
                    evaluateDetail.setGroupScore(key);
                    evaluateDetail.setRemark(value);
                    evaluateDetailDao.update(evaluateDetail);
                }

               // EvaluateDetail evaluateDetail = evaluateDetailList.get(0);


//                ManagerEvaluateDetail managerEvaluateDetail = new ManagerEvaluateDetail();
//                managerEvaluateDetail.setScore(value);
//                managerEvaluateDetail.setManagerEvaluateId(id);
//                managerEvaluateDetail.setJobDutyId(key);
//                managerEvaluateDetailDao.save(managerEvaluateDetail);
            }
        }
        Map<String, String> valsMap = new HashMap<>();
        valsMap.put("考核小组打分",saveManagerEvaluateDTO.getTotal()+"");
        activitiService.complete(taskId+"", valsMap);
        result.setSuccess("保存成功",null);
        return result;
    }

    public Result listHistory(Integer personId, HttpServletRequest request) {
        ListHistoryDTO listHistoryDTO = new ListHistoryDTO();
        List<ListHistory1DTO>listHistory1DTOList = new ArrayList<>();
        HttpSession session = request.getSession();
        User user1 = (User) session.getAttribute("user");
        String userName = user1.getUname();
        String sql ="";
        if("admin".equals(userName)){

            sql="select distinct(evaluateName),e from EvaluateDetail e where groupScore is not null";
        }else{
            sql="select distinct(evaluateName),e from EvaluateDetail e where groupScore is not null and personId ="+personId;
        }

        List<EvaluateDetail> evaluateDetailList = evaluateDetailDao.find(sql); //自评分主表 拼条件
        for ( EvaluateDetail evaluateDetail: evaluateDetailList) {
            ListHistory1DTO listHistory1DTO = new ListHistory1DTO();
            listHistory1DTO.setName(evaluateDetail.getEvaluateName());
            listHistory1DTO.setId(evaluateDetail.getId());
            listHistory1DTOList.add(listHistory1DTO);
        }
        listHistoryDTO.setDetail(listHistory1DTOList);
        listHistoryDTO.setPersonId(personId);
        User user = userDao1.getUserByUid(personId);
        listHistoryDTO.setPersonName(user.getUname());
        result.setSuccess("查询成功",listHistoryDTO);
        return result;
    }

    public Result listHistoryDetail(Integer id) {
        List<ManagerEvaluate> managerEvaluate = managerEvaluateDao.find("from ManagerEvaluate where id ="+id); //自评分主表 拼条件
        List<ManagerEvaluateDetail> managerEvaluateDaoList = managerEvaluateDao.find("from ManagerEvaluateDetail where managerEvaluateId ="+id);



        List<EvaluateDetail> evaluateDetailList0 = evaluateDetailDao.find("from EvaluateDetail where id ="+id);
        EvaluateDetail evaluateDetail0 = evaluateDetailList0.get(0);
        String evaluateName = evaluateDetail0.getEvaluateName();
        List<EvaluateDetail> evaluateDetailList1 = evaluateDetailDao.find("from EvaluateDetail where evaluateName = "+evaluateName );

        List<HistoryDetailDTO> historyDetailDTOList = new ArrayList<HistoryDetailDTO>();
        for ( EvaluateDetail evaluateDetail : evaluateDetailList1 ) {
//            List<JobDuty> jobDutyList = jobDutyDao.find(" from JobDuty where id = " + managerEvaluateDetail.getJobDutyId());
            List<UserJobDuties> userJobDutiesList = userJobDutiesDao.find(" from UserJobDuties where personId = " + evaluateDetail.getPersonId()+" and jobDutiesId = "+evaluateDetail.getJobDutyId() );
            UserJobDuties userJobDuties = userJobDutiesList.get(0);
//            JobDuty jobDuty = jobDutyList.get(0);
//            List<SelfEvaluate> selfEvaluate = selfEvaluateDao.find("from SelfEvaluate where evaluateName = '"+managerEvaluate.get(0).getEvaluateName()+"' and personId ="+managerEvaluate.get(0).getPersonId() ); //自评分主表 拼条件
//            List<SelfEvaluateDetail>  selfEvaluateDetailList = selfEvaluateDetailDao.find("from SelfEvaluateDetail where selfEvaluateId =" + selfEvaluate.get(0).getId() +"and jobDutyId ="+managerEvaluateDetail.getJobDutyId());
//            List<DepartmentEvaluate> deparmentEvaluate = deparmentEvaluateDao.find("from DepartmentEvaluate where evaluateName = '"+managerEvaluate.get(0).getEvaluateName()+"' and personId ="+managerEvaluate.get(0).getPersonId()); //自评分主表 拼条件 evaluateName
//            List<DeparmentEvaluateDetail>  deparmentEvaluateDetailList = deparmentEvaluateDetailDao.find("from DeparmentEvaluateDetail where deparmentEvaluateId =" + deparmentEvaluate.get(0).getId()+ " and jobDutyId ="+managerEvaluateDetail.getJobDutyId() );

            HistoryDetailDTO historyDetailDTO = new HistoryDetailDTO();
            historyDetailDTO.setChildProName(evaluateDetail.getChildProName());
            historyDetailDTO.setChildProValue(userJobDuties.getScore());
            historyDetailDTO.setComplete(evaluateDetail.getComplete());
            historyDetailDTO.setInputs(evaluateDetail.getSelfInputs().split("&"));
            historyDetailDTO.setJobResponsibility(evaluateDetail.getJobResponsibility());
            historyDetailDTO.setJobStandard(evaluateDetail.getJobStandard());
            historyDetailDTO.setScoreStandard(evaluateDetail.getScoreStandard());
            historyDetailDTO.setId(evaluateDetail.getJobDutyId());
            historyDetailDTO.setProName(evaluateDetail.getProName());
            historyDetailDTO.setZiping(evaluateDetail.getSelfScore());
            historyDetailDTO.setBumen(evaluateDetail.getManagerScore());
            historyDetailDTO.setKpgroup(evaluateDetail.getGroupScore());
            historyDetailDTO.setEvaluateName(evaluateDetail.getEvaluateName());
            historyDetailDTOList.add(historyDetailDTO);
        }
        result.setSuccess("查询成功",historyDetailDTOList);
        return result;
    }

}