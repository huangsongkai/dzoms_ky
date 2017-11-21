package com.dz.kaiying.controller.activiti;


import com.dz.kaiying.service.ActivitiService;
import com.dz.kaiying.util.Result;
import org.activiti.engine.FormService;
import org.activiti.engine.RepositoryService;
import org.activiti.engine.form.StartFormData;
import org.activiti.engine.repository.ProcessDefinition;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by song on 2017/1/7.
 */
@Controller
    @RequestMapping(value = "/activity/process")
public class ProcessController {
    @Resource
    private ActivitiService activitiService;
    @Resource
    private FormService formService;
    @Resource
    private RepositoryService repositoryService;
    @Resource
    private ResultWrapper resultWrapper;

    @RequestMapping(value="/deploy/{fileName}", method= RequestMethod.GET)
    @ResponseBody
    public Result deploy(@PathVariable String fileName) {
      //  activitiService.deploy(fileName);
        return resultWrapper.success("部署成功");
    }

    @RequestMapping(value="/list", method= RequestMethod.GET)
    public String list() {
        return "activity/processes_list";
    }

    @RequestMapping(value="/history", method= RequestMethod.GET)
    public String history() {
        return "activity/process/history";
    }


    @RequestMapping(value="/start/{key}", method= RequestMethod.GET)
    public String start(@PathVariable String key) {
        return "activity/start_form";
    }

    @RequestMapping(value="/startForm/{processKey}", method= RequestMethod.POST)
    @ResponseBody
    public Result startForm(@PathVariable String processKey, HttpServletRequest request) {
        String userId = "Huang";
        request.getSession().getAttribute("userId");
        String processInstanceId = activitiService.startForm(userId, processKey, request.getParameterMap(), request);
        return resultWrapper.success("activity/task_list");
    }
    @RequestMapping(value="/startForm/{processKey}", method= RequestMethod.GET)
    public String startForm1(@PathVariable String processKey, HttpServletRequest request) {
        String userId = "Huang";//        request.getSession().getAttribute("userId");
        String processInstanceId = activitiService.startForm(userId, processKey, request.getParameterMap(), request);
        return "activity/task_list";
    }

    @RequestMapping(value="/getStartFormProperties/{processKey}", method= RequestMethod.POST)
    @ResponseBody
    public Result getStartFormProperties(@PathVariable String processKey) {
        ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionKey(processKey).latestVersion().singleResult();
          processDefinition.getName();
        //获取开始表单
        if(processDefinition == null)
            return resultWrapper.error("null");
        StartFormData startFormData = formService.getStartFormData(processDefinition.getId());
        if(startFormData != null){
            return resultWrapper.success("",startFormData.getFormProperties());
        }
        return resultWrapper.error("null");
    }

}
