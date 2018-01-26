package com.dz.kaiying.service;

import com.dz.kaiying.DTO.*;
import com.dz.kaiying.QueryRegectDTO;
import com.dz.kaiying.model.*;
import com.dz.kaiying.repository.hiber.HibernateDao;
import com.dz.kaiying.util.Result;
import com.dz.module.user.User;
import com.dz.module.user.UserDao;
import org.activiti.engine.FormService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.TaskService;
import org.apache.commons.beanutils.BeanUtils;
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
@Transactional
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
    @Resource
    ActivitiTest activitiTest;

    private Result result = new Result();


//    //定时任务启动绩效考核  5 0 0 5 * ?   每月5号
//    @Scheduled(cron="5 0 0 5 * ? ") //每个月五号执行
//    public void stratrJobDuty(){
//        List<User> userList = userDao1.getAll();
//        for (User user: userList) {
//            Map<String, String> variableMap = new HashMap<String, String>();
//            ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionKey("duty_check").latestVersion().singleResult();
//            variableMap.put("userName1", user.getUname());
//            ProcessInstance processInstance = formService.submitStartFormData(processDefinition.getId(), variableMap);
//        }
//
//    }

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
        result.setSuccess("保存成功",jobDuties);
        return result;
    }
    public Result delete(int[] ids) {
        for (int id : ids) {
            jobDutyDao.deleteByKey(JobDuty.class, id);
        }

        result.setSuccess("删除成功",null);
        return result;
    }
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
        List<UserJobDuties> userJobDuties = userJobDutiesDao.find(" from UserJobDuties where personId = "+id+" ORDER BY sortId");
        List<UserJobDutyDTO> userJobDutiesDTOList = new ArrayList<>();
        for (UserJobDuties userJobs : userJobDuties ) {
            UserJobDutyDTO userJobDutiesDTO = new UserJobDutyDTO();
            userJobDutiesDTO.setKey(userJobs.getJobDutiesId());
            userJobDutiesDTO.setSortId(userJobs.getSortId());
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
            userJobDuties.setSortId(Integer.parseInt(value));
            userJobDuties.setJobDutiesId(key);
            userJobDutiesDao.save(userJobDuties);
        }
        result.setSuccess("保存成功",null);
        return result;
    }

    // TODO: 2017/5/24  session 获取那块的用户Id
    public Result myEvaluate(HttpServletRequest request, Integer taskId) throws Exception {
        SimpleDateFormat dateFormater = new SimpleDateFormat("yyyy-MM 生成时间 HH:mm");
        String evaluateName = (String) taskService.getVariable(taskId + "", "考核名称");
        String personId = (String) taskService.getVariable(taskId + "", "人员ID");
        HttpSession session = request.getSession();
        List <QueryEvaluateDTO> queryEvaluateDTOList = new ArrayList<>();
        if (session != null){
            User user = (User) session.getAttribute("user");
            Integer userId = user.getUid();
            List<UserJobDuties> userJobDutiesList = userJobDutiesDao.find(" from UserJobDuties where personId = " + userId+" ORDER BY sortId");
            for (UserJobDuties userJobDuties: userJobDutiesList) {
                QueryEvaluateDTO queryEvaluateDTO = new QueryEvaluateDTO();
                if (evaluateName != null && evaluateName != ""){
                    List<EvaluateDetail> evaluateDetailList = evaluateDetailDao.find("from EvaluateDetail  where evaluateName = '"+evaluateName+"' and personId ="+personId+ "and jobDutyId = "+userJobDuties.getJobDutiesId()+" ORDER BY sortId");
                    EvaluateDetail evaluateDetail = evaluateDetailList.get(0);
                    SaveEvaluateDetailDTO mySelfDetailDTO = new SaveEvaluateDetailDTO();
                    mySelfDetailDTO.setScore(evaluateDetail.getSelfScore());
                    mySelfDetailDTO.setComplete(evaluateDetail.getSelfInputs());
                    queryEvaluateDTO.setPersonal(mySelfDetailDTO);

                    SaveEvaluateDetailDTO departmentDetailDTO = new SaveEvaluateDetailDTO();
                    departmentDetailDTO.setComplete(evaluateDetail.getManagerInputs());
                    departmentDetailDTO.setScore(evaluateDetail.getManagerScore());
                    queryEvaluateDTO.setBumen(departmentDetailDTO);

                    SaveEvaluateDetailDTO groupDetailDTO = new SaveEvaluateDetailDTO();
                    groupDetailDTO.setComplete(evaluateDetail.getGroupInputs());
                    groupDetailDTO.setScore(evaluateDetail.getGroupScore());
                    queryEvaluateDTO.setKpgroup(groupDetailDTO);

                    Reason reason = new Reason();
                    reason.setPersonal(evaluateDetailList.get(0).getRegect_self());
                    reason.setBumen(evaluateDetailList.get(0).getRegect_manager());
                    reason.setKpgroup(evaluateDetailList.get(0).getRegect_group());
                    queryEvaluateDTO.setReason(reason);
                }
                List<JobDuty> jobDutyList = jobDutyDao.find(" from JobDuty where id = " + userJobDuties.getJobDutiesId());
                BeanUtils.copyProperties(queryEvaluateDTO, jobDutyList.get(0));  //前边是空值 后边是有值得  进行对象copy
                //queryEvaluateDTO.setChildProValue(userJobDuties.getScore());
                SaveEvaluateDetailDTO saveEvaluateDetailDTO = new SaveEvaluateDetailDTO();
                saveEvaluateDetailDTO.setComplete(jobDutyList.get(0).getComplete());
                queryEvaluateDTO.setPersonal(saveEvaluateDetailDTO);
                queryEvaluateDTO.setEvaluateName(user.getUname()+dateFormater.format(new Date())+"绩效考核");
                queryEvaluateDTOList.add(queryEvaluateDTO);
            }
            result.setSuccess("查询成功", queryEvaluateDTOList);
        }
        return result;
    }


    //把主表的id存在流程中 名称 selfEvaluateId
    public Result saveMyEvaluate(SaveEvaluateDTO saveEvaluateDTO, Integer userId, Integer taskId) throws InvocationTargetException, IllegalAccessException {
            for (Map.Entry<Integer, SaveEvaluateDetailDTO> entry : saveEvaluateDTO.getSelfEvaluate().entrySet()) {
                Integer jobDutyId = entry.getKey();
                SaveEvaluateDetailDTO saveEvaluateDetailDTO = entry.getValue();
                EvaluateDetail evaluateDetail = new EvaluateDetail();
                evaluateDetail.setPersonId(userId);
                evaluateDetail.setSelfDate(new Date());
                evaluateDetail.setEvaluateName(saveEvaluateDTO.getEvaluateName());
                evaluateDetail.setSelfInputs(saveEvaluateDetailDTO.getInputs());
                evaluateDetail.setRemarks(saveEvaluateDetailDTO.getRemarks());
                evaluateDetail.setJobDutyId(jobDutyId);
                evaluateDetail.setSelfTotal(saveEvaluateDTO.getTotal());
                evaluateDetail.setSelfScore(saveEvaluateDetailDTO.getScore());
                List<UserJobDuties> userJobDutiesList = userJobDutiesDao.find(" from UserJobDuties where personId = " + userId+" and jobDutiesId = "+jobDutyId );
                evaluateDetail.setSortId(userJobDutiesList.get(0).getSortId());
                List jobDutyList = jobDutyDao.find("from JobDuty where id =" + jobDutyId);
                JobDuty jobDuty  = (JobDuty) jobDutyList.get(0);
                BeanUtils.copyProperties(evaluateDetail, jobDuty);  //前边是空值 后边是有值得  进行对象copy
                evaluateDetailDao.save(evaluateDetail);
            }

        //工作流
        Map<String, String> valsMap = new HashMap<>();
        valsMap.put("考核名称",saveEvaluateDTO.getEvaluateName());
        valsMap.put("人员ID",userId+"");
        valsMap.put("自评分数",saveEvaluateDTO.getTotal()+"");
        User user = userDao1.getUserByUid(userId);
        String userName = user.getUname();
        String department = user.getDepartment();
        if ("刘波".equals(userName)) {
            valsMap.put("userName2","刘波");//动态办理人
            activitiService.complete(taskId+"", valsMap, saveEvaluateDTO.getEvaluateName());
            result.setSuccess("保存成功",null);
            return result;
        }else if("计财部".equals(department)){
            valsMap.put("userName2","陈东慧");//动态办理人
        }else if("综合办公室".equals(department)){
            valsMap.put("userName2","邹研");//动态办理人
        }else if("信息部".equals(department)){
            valsMap.put("userName2","李志强");//动态办理人
        }else if("运营管理部".equals(department)){
            valsMap.put("userName2","夏滨");//动态办理人
        }
        //userName
        activitiService.complete(taskId+"", valsMap, saveEvaluateDTO.getEvaluateName());
        result.setSuccess("保存成功",null);
        return result;
    }


    //从主表的id存在流程中 名称 selfEvaluateId
    public Result departmentEvaluate(HttpServletRequest request, Integer taskId) throws InvocationTargetException, IllegalAccessException {
        String personId = (String) taskService.getVariable(taskId + "", "人员ID");
        String evaluateName = (String) taskService.getVariable(taskId + "", "考核名称");
        List<EvaluateDetail> evaluateDetailList = evaluateDetailDao.find("from EvaluateDetail  where evaluateName = '"+evaluateName+"' and personId ="+personId+" ORDER BY sortId"); //自评分主表 拼条件
        List<QueryEvaluateDTO> queryEvaluateDTOList = new ArrayList<>();
        for ( EvaluateDetail evaluateDetail: evaluateDetailList ) {
            QueryEvaluateDTO queryEvaluateDTO = new QueryEvaluateDTO();
            List<UserJobDuties> userJobDutiesList = userJobDutiesDao.find(" from UserJobDuties where personId = " + personId+" and jobDutiesId = "+evaluateDetail.getJobDutyId() );
            UserJobDuties userJobDuties = userJobDutiesList.get(0);
            queryEvaluateDTO.setChildProName(evaluateDetail.getChildProName());
            //queryEvaluateDTO.setChildProValue(userJobDuties.getScore());
            queryEvaluateDTO.setJobResponsibility(evaluateDetail.getJobResponsibility());
            queryEvaluateDTO.setJobStandard(evaluateDetail.getJobStandard());
            queryEvaluateDTO.setScoreStandard(evaluateDetail.getScoreStandard());
            queryEvaluateDTO.setId(evaluateDetail.getJobDutyId());
            queryEvaluateDTO.setProName(evaluateDetail.getProName());
            queryEvaluateDTO.setEvaluateName(evaluateDetail.getEvaluateName());
            queryEvaluateDTO.setTaskId(taskId+"");
            queryEvaluateDTO.setRemarks(evaluateDetail.getRemarks());

            Reason reason = new Reason();
            reason.setPersonal(evaluateDetail.getRegect_self());
            reason.setBumen(evaluateDetail.getRegect_manager());
            reason.setKpgroup(evaluateDetail.getRegect_group());
            queryEvaluateDTO.setReason(reason);

            SaveEvaluateDetailDTO mySelfDetailDTO = new SaveEvaluateDetailDTO();
            mySelfDetailDTO.setScore(evaluateDetail.getSelfScore());
            mySelfDetailDTO.setComplete(evaluateDetail.getSelfInputs());
            queryEvaluateDTO.setPersonal(mySelfDetailDTO);

            SaveEvaluateDetailDTO departmentDetailDTO = new SaveEvaluateDetailDTO();
            departmentDetailDTO.setComplete(evaluateDetail.getManagerInputs());
            departmentDetailDTO.setScore(evaluateDetail.getManagerScore());
            queryEvaluateDTO.setBumen(departmentDetailDTO);

            SaveEvaluateDetailDTO groupDetailDTO = new SaveEvaluateDetailDTO();
            groupDetailDTO.setComplete(evaluateDetail.getGroupInputs());
            groupDetailDTO.setScore(evaluateDetail.getGroupScore());
            queryEvaluateDTO.setKpgroup(groupDetailDTO);

            queryEvaluateDTOList.add(queryEvaluateDTO);
        }
        result.setSuccess("查询成功",queryEvaluateDTOList);
        return result;
    }



    public Result savedepartmentEvaluate(SaveEvaluateDTO saveEvaluateDTO, Integer taskId) {
        String personId = (String) taskService.getVariable(taskId + "", "人员ID");
        String evaluateName = (String) taskService.getVariable(taskId + "", "考核名称");

            for (Map.Entry<Integer, SaveEvaluateDetailDTO> entry : saveEvaluateDTO.getDepartmentEvaluate().entrySet()) {
                Integer jobDutyId = entry.getKey();
                SaveEvaluateDetailDTO saveEvaluateDetailDTO = entry.getValue();
                List<EvaluateDetail> evaluateDetailList = evaluateDetailDao.find("from EvaluateDetail  where evaluateName = '"+saveEvaluateDTO.getEvaluateName()+"' and personId ="+personId+" and jobDutyId ="+jobDutyId); //
                for (EvaluateDetail evaluateDetail : evaluateDetailList) {
                    evaluateDetail.setManagerDate(new Date());
                    evaluateDetail.setManagerScore(saveEvaluateDetailDTO.getScore());
                    evaluateDetail.setManagerInputs(saveEvaluateDetailDTO.getInputs());
                    evaluateDetail.setManagerTotal(saveEvaluateDTO.getTotal());
                    evaluateDetail.setRemarks(saveEvaluateDetailDTO.getRemarks());
                    evaluateDetailDao.update(evaluateDetail);
                }
            }

        //工作流
        Map<String, String> valsMap = new HashMap<>();
        valsMap.put("部门评分",saveEvaluateDTO.getTotal()+"");
        User user = userDao1.getUserByUid(Integer.parseInt(personId));
        String userName = user.getUname();
        String department = user.getDepartment();
        valsMap.put("userName3","考核组");//动态办理人
        activitiService.complete(taskId+"", valsMap, evaluateName );
        result.setSuccess("保存成功",null);
        return result;
    }


        public Result managerEvaluate(HttpServletRequest request, Integer taskId) {
        String personId = (String) taskService.getVariable(taskId + "", "人员ID");
        String evaluateName = (String) taskService.getVariable(taskId + "", "考核名称");

        List<EvaluateDetail> evaluateDetailList = evaluateDetailDao.find("from EvaluateDetail  where evaluateName = '"+evaluateName+"' and personId ="+personId+" ORDER BY sortId"); //自评分主表 拼条件
        List<ManagerEvaluateDTO> managerEvaluateDTOList = new ArrayList<ManagerEvaluateDTO>();
        List<QueryEvaluateDTO> queryEvaluateDTOList = new ArrayList<>();
        for ( EvaluateDetail evaluateDetail: evaluateDetailList ) {
            QueryEvaluateDTO queryEvaluateDTO = new QueryEvaluateDTO();
            List<UserJobDuties> userJobDutiesList = userJobDutiesDao.find(" from UserJobDuties where personId = " + personId+" and jobDutiesId = "+evaluateDetail.getJobDutyId() );
            UserJobDuties userJobDuties = userJobDutiesList.get(0);
            ManagerEvaluateDTO managerEvaluateDTO = new ManagerEvaluateDTO();
            queryEvaluateDTO.setChildProName(evaluateDetail.getChildProName());
           // queryEvaluateDTO.setChildProValue(userJobDuties.getScore());
            queryEvaluateDTO.setJobResponsibility(evaluateDetail.getJobResponsibility());
            queryEvaluateDTO.setJobStandard(evaluateDetail.getJobStandard());
            queryEvaluateDTO.setScoreStandard(evaluateDetail.getScoreStandard());
            queryEvaluateDTO.setId(evaluateDetail.getJobDutyId());
            queryEvaluateDTO.setProName(evaluateDetail.getProName());
            queryEvaluateDTO.setEvaluateName(evaluateDetail.getEvaluateName());
            queryEvaluateDTO.setTaskId(taskId+"");
            queryEvaluateDTO.setRemarks(evaluateDetail.getRemarks());
            SaveEvaluateDetailDTO mySelfDetailDTO = new SaveEvaluateDetailDTO();
            mySelfDetailDTO.setScore(evaluateDetail.getSelfScore());
            mySelfDetailDTO.setComplete(evaluateDetail.getSelfInputs());
            queryEvaluateDTO.setPersonal(mySelfDetailDTO);

            SaveEvaluateDetailDTO departmentDetailDTO = new SaveEvaluateDetailDTO();
            departmentDetailDTO.setComplete(evaluateDetail.getManagerInputs());
            departmentDetailDTO.setScore(evaluateDetail.getManagerScore());
            queryEvaluateDTO.setBumen(departmentDetailDTO);

            Reason reason = new Reason();
            reason.setPersonal(evaluateDetail.getRegect_self());
            reason.setBumen(evaluateDetail.getRegect_manager());
            reason.setKpgroup(evaluateDetail.getRegect_group());
            queryEvaluateDTO.setReason(reason);

            SaveEvaluateDetailDTO groupDetailDTO = new SaveEvaluateDetailDTO();
            groupDetailDTO.setComplete(evaluateDetail.getGroupInputs());
            groupDetailDTO.setScore(evaluateDetail.getGroupScore());
            queryEvaluateDTO.setKpgroup(groupDetailDTO);
            queryEvaluateDTOList.add(queryEvaluateDTO);
        }
        result.setSuccess("查询成功",queryEvaluateDTOList);
        return result;
    }



    public Result saveManagerEvaluate(SaveEvaluateDTO saveEvaluateDTO, HttpServletRequest request, Integer taskId) {
        String personId = (String) taskService.getVariable(taskId + "", "人员ID");
        String evaluateName = (String) taskService.getVariable(taskId + "", "考核名称");
        SimpleDateFormat dateFormater = new SimpleDateFormat("yyyy-MM-dd");
            for (Map.Entry<Integer, SaveEvaluateDetailDTO> entry : saveEvaluateDTO.getManagerEvaluate().entrySet()) {
                Integer jobDutyId = entry.getKey();
                SaveEvaluateDetailDTO saveEvaluateDetailDTO = entry.getValue();
                List<EvaluateDetail> evaluateDetailList = evaluateDetailDao.find("from EvaluateDetail  where evaluateName = '"+saveEvaluateDTO.getEvaluateName()+"' and personId ="+personId+" and jobDutyId ="+jobDutyId); //
                for (EvaluateDetail evaluateDetail : evaluateDetailList) {
                    evaluateDetail.setGroupDate(new Date());
                    evaluateDetail.setGroupScore(saveEvaluateDetailDTO.getScore());
                    evaluateDetail.setGroupInputs(saveEvaluateDetailDTO.getInputs());
                    evaluateDetail.setGroupTotal(saveEvaluateDTO.getTotal());
                    evaluateDetail.setRemarks(saveEvaluateDetailDTO.getRemarks());
                    evaluateDetailDao.update(evaluateDetail);
                }
            }
        //工作流
        Map<String, String> valsMap = new HashMap<>();
        valsMap.put("考核小组打分", saveEvaluateDTO.getTotal()+"");
        String userName1 = (String) taskService.getVariable(taskId + "", "userName1");
        valsMap.put("userName4",userName1);//动态办理人
        activitiService.complete(taskId+"", valsMap, evaluateName);
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
        if("admin".equals(userName) || "考核组".equals(userName)){

            sql="select distinct(evaluateName) from EvaluateDetail  where evaluateName is not null ";
        }else{
            sql="select distinct(evaluateName) from EvaluateDetail  where evaluateName is not null and personId ="+personId;
        }

        List<Object> result1 = evaluateDetailDao.find(sql); //自评分主表 拼条件
        Iterator itr = result1.iterator();

        for (int j = 0; j< result1.size(); j++){
            String name= (String) result1.get(j);
            ListHistory1DTO listHistory1DTO = new ListHistory1DTO();
            listHistory1DTO.setName(name);
            List<EvaluateDetail> evaluateDetail= evaluateDetailDao.find("from EvaluateDetail where evaluateName = '"+name+"'");
            listHistory1DTO.setId(evaluateDetail.get(0).getId());
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

        List<EvaluateDetail> evaluateDetailList0 = evaluateDetailDao.find("from EvaluateDetail where id ="+id+" ORDER BY sortId");
        EvaluateDetail evaluateDetail0 = evaluateDetailList0.get(0);
        String evaluateName = evaluateDetail0.getEvaluateName();
        List<EvaluateDetail> evaluateDetailList1 = evaluateDetailDao.find("from EvaluateDetail where  evaluateName = '"+evaluateName+"'" +" ORDER BY sortId");
        List<QueryEvaluateDTO> queryEvaluateDTOList = new ArrayList<>();
        for ( EvaluateDetail evaluateDetail : evaluateDetailList1 ) {
            List<UserJobDuties> userJobDutiesList = userJobDutiesDao.find(" from UserJobDuties where personId = " + evaluateDetail.getPersonId()+" and jobDutiesId = "+evaluateDetail.getJobDutyId() +" ORDER BY sortId");
            UserJobDuties userJobDuties = userJobDutiesList.get(0);
            QueryEvaluateDTO queryEvaluateDTO = new QueryEvaluateDTO();
            queryEvaluateDTO.setChildProName(evaluateDetail.getChildProName());
            //queryEvaluateDTO.setChildProValue(userJobDuties.getScore());
            queryEvaluateDTO.setJobResponsibility(evaluateDetail.getJobResponsibility());
            queryEvaluateDTO.setJobStandard(evaluateDetail.getJobStandard());
            queryEvaluateDTO.setScoreStandard(evaluateDetail.getScoreStandard());
            queryEvaluateDTO.setId(evaluateDetail.getJobDutyId());
            queryEvaluateDTO.setProName(evaluateDetail.getProName());
            queryEvaluateDTO.setEvaluateName(evaluateDetail.getEvaluateName());
            queryEvaluateDTO.setRemarks(evaluateDetail.getRemarks());
            SaveEvaluateDetailDTO mySelfDetailDTO = new SaveEvaluateDetailDTO();
            mySelfDetailDTO.setScore(evaluateDetail.getSelfScore());
            mySelfDetailDTO.setComplete(evaluateDetail.getSelfInputs());
            queryEvaluateDTO.setPersonal(mySelfDetailDTO);

            SaveEvaluateDetailDTO departmentDetailDTO = new SaveEvaluateDetailDTO();
            departmentDetailDTO.setComplete(evaluateDetail.getManagerInputs());
            departmentDetailDTO.setScore(evaluateDetail.getManagerScore());
            queryEvaluateDTO.setBumen(departmentDetailDTO);

            SaveEvaluateDetailDTO groupDetailDTO = new SaveEvaluateDetailDTO();
            groupDetailDTO.setComplete(evaluateDetail.getGroupInputs());
            groupDetailDTO.setScore(evaluateDetail.getGroupScore());
            queryEvaluateDTO.setKpgroup(groupDetailDTO);

            Reason reason = new Reason();
            reason.setPersonal(evaluateDetail.getRegect_self());
            reason.setBumen(evaluateDetail.getRegect_manager());
            reason.setKpgroup(evaluateDetail.getRegect_group());
            queryEvaluateDTO.setReason(reason);


            queryEvaluateDTOList.add(queryEvaluateDTO);
        }
        result.setSuccess("查询成功",queryEvaluateDTOList);
        return result;
    }


  public Result managerEvaluateRegect(QueryRegectDTO regectDTO, String remark) throws Exception {
        String evaluateName = (String) taskService.getVariable(regectDTO.getTaskId() + "", "考核名称");
        List<EvaluateDetail> evaluateDetailList1 = evaluateDetailDao.find("from EvaluateDetail where  evaluateName = '"+evaluateName+"'" );
        if(remark.equals("manager")){
            for (EvaluateDetail evaluateDetail : evaluateDetailList1) {
                evaluateDetail.setRegect_manager(regectDTO.getReason());
                evaluateDetailDao.update(evaluateDetail);
            }
        }else if (remark.equals("group")){
            for (EvaluateDetail evaluateDetail : evaluateDetailList1) {
                evaluateDetail.setRegect_group(regectDTO.getReason());
                evaluateDetailDao.update(evaluateDetail);
            }
        }else{
            for (EvaluateDetail evaluateDetail : evaluateDetailList1) {
                evaluateDetail.setRegect_self(regectDTO.getReason());
                evaluateDetailDao.update(evaluateDetail);
            }
        }
        activitiTest.turnBackNew(regectDTO.getTaskId()+"","驳回成功",null);
        //activitiService.processReject(regectDTO.getTaskId()+"");
        result.setSuccess("驳回成功",null);
        return result;
    }

    public Result listHistory(Integer uid, HttpServletRequest request, Integer year) {
        ListHistoryDTO listHistoryDTO = new ListHistoryDTO();
        List<ListHistory1DTO>listHistory1DTOList = new ArrayList<>();
        HttpSession session = request.getSession();
        User user1 = (User) session.getAttribute("user");
        String userName = user1.getUname();
        String sql ="";
        if("admin".equals(userName) || "考核组".equals(userName)){

            sql="select distinct(evaluateName) from EvaluateDetail  where evaluateName is not null and selfDate BETWEEN '"+year+"-01-01' AND '"+year+"-12-30' ";
        }else{
            sql="select distinct(evaluateName) from EvaluateDetail  where evaluateName is not null and personId ="+uid+"and selfDate BETWEEN '"+year+"-01-01' AND '"+year+"-12-30'";
        }

        List<Object> result1 = evaluateDetailDao.find(sql); //自评分主表 拼条件
        Iterator itr = result1.iterator();

        for (int j = 0; j< result1.size(); j++){
            String name= (String) result1.get(j);
            ListHistory1DTO listHistory1DTO = new ListHistory1DTO();
            listHistory1DTO.setName(name);
            List<EvaluateDetail> evaluateDetail= evaluateDetailDao.find("from EvaluateDetail where evaluateName = '"+name+"'");
            listHistory1DTO.setId(evaluateDetail.get(0).getId());
            listHistory1DTOList.add(listHistory1DTO);
        }

        listHistoryDTO.setDetail(listHistory1DTOList);
        listHistoryDTO.setPersonId(uid);
        User user = userDao1.getUserByUid(uid);
        listHistoryDTO.setPersonName(user.getUname());
        result.setSuccess("查询成功",listHistoryDTO);
        return result;
    }
}