package com.dz.kaiying.service;

import com.dz.module.user.User;
import org.activiti.engine.*;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.impl.RepositoryServiceImpl;
import org.activiti.engine.impl.persistence.entity.ProcessDefinitionEntity;
import org.activiti.engine.impl.pvm.PvmActivity;
import org.activiti.engine.impl.pvm.PvmTransition;
import org.activiti.engine.impl.pvm.process.ActivityImpl;
import org.activiti.engine.impl.pvm.process.ProcessDefinitionImpl;
import org.activiti.engine.impl.pvm.process.TransitionImpl;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.activiti.rest.common.api.DataResponse;
import org.activiti.rest.service.api.runtime.task.TaskBaseResource;
import org.activiti.rest.service.api.runtime.task.TaskQueryRequest;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class ActivitiService  extends TaskBaseResource{
    @Resource
    IdentityService identityService;

    @Resource
    RuntimeService runtimeService;

//    @Resource
//    TaskService taskService;

    @Resource
    RepositoryService repositoryService;

//    @Resource
//    HistoryService historyService;

    @Resource
    FormService formService;

    @Transactional
    public  void deploy(String processFileName){
        //部署相关的流程配置
        repositoryService.createDeployment()
//                .addClasspathResource("processes/vocation.bpmn")
                .addClasspathResource("processes/"+processFileName+".bpmn")
                .deploy();
    }

	@Transactional
    public List<Task> getTasks(String assignee) {
        return taskService.createTaskQuery().taskAssignee(assignee).list();
    }

    @Transactional
    public Task getTaskById(String id) {
        runtimeService.createProcessInstanceQuery().deploymentId(id).active();
        return null;
    }
    @Transactional
    public void startProcessByKey(String key) {
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionKey(key).latestVersion().singleResult();
        startProcessByRuntime(processDefinition.getId());
    }

    @Transactional
    private void startProcessByRuntime(String id) {
        HashMap variables = new HashMap();
        variables.put("category", "small");
        variables.put("qq", 960950120);
        taskService.setVariables(id, variables);

        runtimeService.setVariable(id, "name", "黄嵩凯");//在runtime的时候插入一个全局变量
        runtimeService.startProcessInstanceById("id");
    }

    public String startForm(String userId, String key, Map map, HttpServletRequest request) {
        identityService.setAuthenticatedUserId(userId);
        Map<String, String> variableMap = new HashMap<String, String>();
        for(Iterator iter = map.entrySet().iterator(); iter.hasNext();){
            Map.Entry element = (Map.Entry)iter.next();
            String strKey = (String)element.getKey();
            String[] strObj = (String[])element.getValue();
            System.out.println();
            variableMap.put(strKey, strObj[0]);
        }

        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionKey(key).latestVersion().singleResult();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String userName = user.getUname();
        //获取开始表单
        variableMap.put("userName1", userName);
        ProcessInstance processInstance = formService.submitStartFormData(processDefinition.getId(), variableMap);

        //runtimeService.setVariable(processDefinition.getId(), "userName", userName);//在runtime的时候插入一个全局变量
        return processInstance.getId();
    }

    public void completeVariablesLocal(String id, Map parameterMap) {
        try {
            if (parameterMap.size() != 0){
                taskService.setVariablesLocal(id, parameterMap);
            }

            //taskService.setVariable(id, "isApproved", "true");
            //taskService.setVariableLocal(id, "taskid", id);
            //是指多个candidate的时候,该用户接受了请求,其他用户就不可见了
//        taskService.claim(id, "swl");
            taskService.complete(id);

        }catch(ActivitiObjectNotFoundException exception){
            exception.printStackTrace();
        }
    }

    public void complete(String id, Map parameterMap, String name) {
        try {
            if (parameterMap.size() != 0){
                taskService.setVariables(id, parameterMap);
                taskService.setVariablesLocal(id, parameterMap);
            }
            taskService.complete(id);
        }catch(ActivitiObjectNotFoundException exception){
            exception.printStackTrace();
        }
    }

    public Map viewTask(String id) {
        //starter
        Map map = taskService.getVariables(id);
        System.out.println();
//        taskService.
        return map;
    }

    /**
     * 读取Task的表单
     * @RequestMapping(value = "get-form/task/{processDefinitionkey}")
     * @PathVariable("processDefinitionkey") String processDefinitionkey
     */
    public ModelAndView findTaskForm( String processInstanceId, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView("leave/apply");
        // 获取当前登陆人信息。
		/* User user = UserUtil.getUserFromSession(request.getSession()); */

        TaskQuery taskQuery = taskService.createTaskQuery()
                .processInstanceId(processInstanceId).orderByProcessInstanceId().desc();

        List<Task> tasks = taskQuery.list();
        if (tasks.size()==0) {
            ModelAndView mav2 = new ModelAndView("leave/finish");
            return mav2;
        }
        Task task = tasks.get(0);
        Object renderedTaskForm = formService.getRenderedTaskForm(task.getId());
        System.out.println(renderedTaskForm.toString());
        mav.addObject("renderedTaskForm", renderedTaskForm.toString());//整个页面，参数已经赋值（整个页面是什么时候赋上值的？）
        mav.addObject("taskId", task.getId());
        mav.addObject("processInstanceId", processInstanceId);
        return mav;
    }

    /**
     * 办理任务，提交task的并保存form
     */
    @RequestMapping(value = "task/complete/{taskId}/{processInstanceId}")
    @SuppressWarnings("unchecked")
    public String completeTask(@PathVariable("taskId") String taskId, @PathVariable("processInstanceId") String processInstanceId, RedirectAttributes redirectAttributes, HttpServletRequest request) {

        Map<String, String> formProperties = new HashMap<String, String>();

        // 从request中读取参数然后转换
        Map<String, String[]> parameterMap = request.getParameterMap();
        Set<Map.Entry<String, String[]>> entrySet = parameterMap.entrySet();
        for (Map.Entry<String, String[]> entry : entrySet) {
            String key = entry.getKey();

      /*\
       * 参数结构：fq_reason，用_分割 fp的意思是form paremeter 最后一个是属性名称
       */
            if (StringUtils.defaultString(key).startsWith("fp_")) {
                String[] paramSplit = key.split("_");
                formProperties.put(paramSplit[1], entry.getValue()[0]);
            }
        }

       // logger.debug("start form parameters: {}", formProperties);

        try {
            formService.submitTaskFormData(taskId, formProperties);
        } finally {
            identityService.setAuthenticatedUserId(null);
        }

        redirectAttributes.addFlashAttribute("message", "任务完成：taskId=" + taskId);
        return "redirect:/workflow/auto/get-form/task/"+processInstanceId;






    }

    /**
     * @author：SongJia
     *
     *
     */
    public void processReject(String taskId){
        try {
            Map<String, Object> variables;
            // 取得当前任务
            HistoricTaskInstance currTask = historyService
                    .createHistoricTaskInstanceQuery().taskId(taskId)
                    .singleResult();
            // 取得流程实例
            ProcessInstance instance = runtimeService
                    .createProcessInstanceQuery()
                    .processInstanceId(currTask.getProcessInstanceId())
                    .singleResult();
            if (instance == null) {
                //流程已经结束
            }
            variables = instance.getProcessVariables();
            // 取得流程定义
            ProcessDefinitionEntity definition = (ProcessDefinitionEntity) ((RepositoryServiceImpl) repositoryService)
                    .getDeployedProcessDefinition(currTask
                            .getProcessDefinitionId());
            if (definition == null) {
                //流程定义未找到
            }
            // 取得上一步活动
            ActivityImpl currActivity = ((ProcessDefinitionImpl) definition)
                    .findActivity(currTask.getTaskDefinitionKey());
            List<PvmTransition> nextTransitionList = currActivity
                    .getIncomingTransitions();
            // 清除当前活动的出口
            List<PvmTransition> oriPvmTransitionList = new ArrayList<PvmTransition>();
            List<PvmTransition> pvmTransitionList = currActivity
                    .getOutgoingTransitions();
            for (PvmTransition pvmTransition : pvmTransitionList) {
                oriPvmTransitionList.add(pvmTransition);
            }
            pvmTransitionList.clear();

            // 建立新出口
            List<TransitionImpl> newTransitions = new ArrayList<TransitionImpl>();
            for (PvmTransition nextTransition : nextTransitionList) {
                PvmActivity nextActivity = nextTransition.getSource();
                ActivityImpl nextActivityImpl = ((ProcessDefinitionImpl) definition)
                        .findActivity(nextActivity.getId());
                TransitionImpl newTransition = currActivity
                        .createOutgoingTransition();
                newTransition.setDestination(nextActivityImpl);
                newTransitions.add(newTransition);
            }
            // 完成任务
            List<Task> tasks = taskService.createTaskQuery()
                    .processInstanceId(instance.getId())
                    .taskDefinitionKey(currTask.getTaskDefinitionKey()).list();
            for (Task task : tasks) {
                taskService.complete(task.getId(), variables);
                historyService.deleteHistoricTaskInstance(task.getId());
            }
            // 恢复方向
            for (TransitionImpl transitionImpl : newTransitions) {
                currActivity.getOutgoingTransitions().remove(transitionImpl);
            }
            for (PvmTransition pvmTransition : oriPvmTransitionList) {
                pvmTransitionList.add(pvmTransition);
            }

        } catch (Exception e) {

        }
    }
    @Transactional
    public DataResponse getTasks( Map<String, String> requestParams, HttpServletRequest httpRequest) {
        DateFormat format = new SimpleDateFormat("yyyy年MM月dd日 HH时mm分");
        TaskQueryRequest request = new TaskQueryRequest();
        if (requestParams.containsKey("assignee")) {
            request.setAssignee(requestParams.get("assignee"));
        }
        DataResponse biba = getTasksFromQueryRequest(request, requestParams);
        biba.getData();
        System.out.println(biba.getData());
        List<Task> taskList = taskService.createTaskQuery().taskCandidateOrAssigned(requestParams.get("assignee")).list();
        System.out.println(taskList.size());
        List<TaskDto> taskDtoList = new ArrayList<TaskDto>();
        for(Task task : taskList){
            TaskDto taskDto = new TaskDto();
            taskDto.setName(task.getName());
            taskDto.setStarter(historyService.createHistoricProcessInstanceQuery().processInstanceId(task.getProcessInstanceId()).singleResult().getStartUserId());
            taskDto.setAssignee(task.getAssignee());
            taskDto.setCreateTime(format.format(task.getCreateTime()));
            taskDto.setProcessDefinitionId(task.getProcessDefinitionId());
            taskDto.setId(task.getId());
            taskDtoList.add(taskDto);
        }
        biba.setData(taskDtoList);
        return biba;
    }
    public class TaskDto{
        String name;
        String starter;
        String assignee;
        String createTime;
        String id;
        String processDefinitionId;

        public String getAssignee() {
            return assignee;
        }

        public void setAssignee(String assignee) {
            this.assignee = assignee;
        }

        public String getCreateTime() {
            return createTime;
        }

        public void setCreateTime(String createTime) {
            this.createTime = createTime;
        }

        public String getId() {
            return id;
        }

        public void setId(String id) {
            this.id = id;
        }

        public String getProcessDefinitionId() {
            return processDefinitionId;
        }

        public void setProcessDefinitionId(String processDefinitionId) {
            this.processDefinitionId = processDefinitionId;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getStarter() {
            return starter;
        }

        public void setStarter(String starter) {
            this.starter = starter;
        }
    }

}