package com.dz.kaiying.controller.activiti;

import org.activiti.engine.*;
import org.activiti.engine.history.HistoricProcessInstance;
import org.activiti.engine.history.HistoricProcessInstanceQuery;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.repository.ProcessDefinitionQuery;
import org.activiti.engine.runtime.ProcessInstance;
import org.activiti.engine.task.Task;
import org.activiti.engine.task.TaskQuery;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.util.*;
import java.util.Map.Entry;
/**
 * 流程管理控制器
 *
 * @author hejingyuan
 */
@Controller
@RequestMapping(value = "/workflow/auto")
public class WorkFlowController {

    protected Logger logger = LoggerFactory.getLogger(getClass());
    @Autowired
    protected RepositoryService repositoryService;
    @Autowired
    protected RuntimeService runtimeService;
    @Autowired
    protected TaskService taskService;
    @Autowired
    protected FormService formService;
    @Autowired
    protected IdentityService identityService;
    @Autowired
    protected HistoryService historyService;

    /**
     * 外置form流程列表
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/process-list")
    public ModelAndView processDefinitionList(Model model, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/process/formkey-process-list");

	    /*
	     * 只读取表单：leave-formkey
	     */
        ProcessDefinitionQuery query = repositoryService.createProcessDefinitionQuery().active().orderByDeploymentId().desc();
        List<ProcessDefinition> list = query.list();

        Map<String, Object> map = new HashMap<String, Object>();
        mav.addObject("page", list);
        return mav;
    }

    /**
     * 读取资源，通过部署ID
     *
     * @param processDefinitionId 流程定义
     * @param resourceType        资源类型(xml|image)
     * @throws Exception
     */
    @RequestMapping(value = "/resource/read")
    public void loadByDeployment(@RequestParam("processDefinitionId") String processDefinitionId, @RequestParam("resourceType") String resourceType,
                                 HttpServletResponse response) throws Exception {
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionId(processDefinitionId).singleResult();
        String resourceName = "";
        if (resourceType.equals("image")) {
            resourceName = processDefinition.getDiagramResourceName();
        } else if (resourceType.equals("xml")) {
            resourceName = processDefinition.getResourceName();
        }
        InputStream resourceAsStream = repositoryService.getResourceAsStream(processDefinition.getDeploymentId(), resourceName);
        byte[] b = new byte[1024];
        int len = -1;
        while ((len = resourceAsStream.read(b, 0, 1024)) != -1) {
            response.getOutputStream().write(b, 0, len);
        }
    }


    /*
	 * 启动流程 启动流程，只考虑首次登录。 首次登录：启动工作流，并且更新/{processDefinitionId} @RequestMapping(value = "get-form/start/{processDefinitionId}")
	 */
    @RequestMapping(value = "/start/{processDefinitionId}")
    public String start(@PathVariable("processDefinitionId") String processDefinitionId,HttpServletRequest request) throws Exception {

        try {
            // 定义map用于往工作流数据库中传值。
            Map<String, String> formProperties = new HashMap<String, String>();
            //启动流程-何静媛-2015年5月24日--processDefinitionId,
            ProcessInstance processInstance = formService
                    .submitStartFormData(processDefinitionId,
                            formProperties);
            // 返回到显示用户信息的controller
            logger.debug("start a processinstance: {}", processInstance);
            return "redirect:/workflow/auto/get-form/task/"+ processInstance.getId();

        } catch (Exception e) {
            throw e;
        } finally {
            identityService.setAuthenticatedUserId(null);
        }


    }

    /**
     * 读取Task的表单
     * @RequestMapping(value = "get-form/task/{processDefinitionkey}")
     * @PathVariable("processDefinitionkey") String processDefinitionkey
     */
    @RequestMapping(value = "/get-form/task/{processInstanceId}")
    @ResponseBody
    public ModelAndView findTaskForm(
            @PathVariable("processInstanceId") String processInstanceId,
            HttpServletRequest request) throws Exception {
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
    public String completeTask(@PathVariable("taskId") String taskId,@PathVariable("processInstanceId") String processInstanceId, RedirectAttributes redirectAttributes, HttpServletRequest request) {

        Map<String, String> formProperties = new HashMap<String, String>();

        // 从request中读取参数然后转换
        Map<String, String[]> parameterMap = request.getParameterMap();
        Set<Entry<String, String[]>> entrySet = parameterMap.entrySet();
        for (Entry<String, String[]> entry : entrySet) {
            String key = entry.getKey();

      /*
       * 参数结构：fq_reason，用_分割 fp的意思是form paremeter 最后一个是属性名称
       */
            if (StringUtils.defaultString(key).startsWith("fp_")) {
                String[] paramSplit = key.split("_");
                formProperties.put(paramSplit[1], entry.getValue()[0]);
            }
        }

        logger.debug("start form parameters: {}", formProperties);

        try {
            formService.submitTaskFormData(taskId, formProperties);
        } finally {
            identityService.setAuthenticatedUserId(null);
        }

        redirectAttributes.addFlashAttribute("message", "任务完成：taskId=" + taskId);
        return "redirect:/workflow/auto/get-form/task/"+processInstanceId;

    }




    /**
     * 任务列表
     *
     * @param
     */
    @RequestMapping(value = "list/task")
    public ModelAndView taskList() {

        // 根据当前人的ID查询
        TaskQuery taskQuery = taskService.createTaskQuery().taskAssignee("admin");
        List<Task> tasks = taskQuery.list();
        int i=0;

        List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
        // 根据流程的业务ID查询实体并关联
        for (Task task : tasks) {
            String processInstanceId = task.getProcessInstanceId();
            ProcessInstance processInstance = runtimeService.createProcessInstanceQuery().processInstanceId(processInstanceId).active().singleResult();
            String businessKey = processInstance.getBusinessKey();
            if (businessKey == null) {
                continue;
            }

            Map<String, Object> map = new HashMap<String, Object>();
            map.put("task", task);
            map.put("processDefinition", getProcessDefinition(processInstance.getProcessDefinitionId()));
            map.put("processInstance", processInstance);//存入“流程实例”
            mapList.add(map);

            i=i+1;
        }

        return new ModelAndView("/leave/taskList","results",mapList);

    }

    /**
     * 查询流程定义对象
     *
     * @param processDefinitionId 流程定义ID
     * @return
     */
    public  ProcessDefinition getProcessDefinition(String processDefinitionId) {
        ProcessDefinition processDefinition = repositoryService.getProcessDefinition(processDefinitionId);
        return processDefinition;
    }


    /**
     * 已结束的流程实例
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "process-instance/finished/list")
    public ModelAndView finished(Model model, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("/workflow/finished-list");

        HistoricProcessInstanceQuery query = historyService.createHistoricProcessInstanceQuery().processDefinitionKey("leave-formkey").orderByProcessInstanceEndTime().desc().finished();
        List<HistoricProcessInstance> list = query.list();

        mav.addObject("page", list);
        return mav;
    }
}
