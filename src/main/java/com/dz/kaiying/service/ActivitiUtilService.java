package com.dz.kaiying.service;

import com.dz.kaiying.controller.activiti.ResultWrapper;
import com.dz.kaiying.util.RequestHelper;
import com.dz.kaiying.util.Result;
import org.activiti.engine.*;
import org.activiti.engine.form.StartFormData;
import org.activiti.engine.repository.ProcessDefinition;
import org.activiti.engine.runtime.ProcessInstance;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 * Created by huang on 2017/5/7.
 */
@Service
public class ActivitiUtilService {
    @Resource
    IdentityService identityService;

    @Resource
    RuntimeService runtimeService;

    @Resource
    TaskService taskService;

    @Resource
    RepositoryService repositoryService;

    @Resource
    FormService formService;
    @Resource
    private ResultWrapper resultWrapper;
    @Resource
    private ActivitiService activitiService;

    private Result result = new Result();


    //-------------------工作流相关service导入-----------------------------


    /**
     * @启动一个流程并返回表单
     * @param key
     * @param variables
     */
    @Transactional
    public Result startProcessByRuntime(String key, Map variables) {

            // ProcessDefinition processDefinition = repositoryService.createProcessDefinitionQuery().processDefinitionKey(key).latestVersion().singleResult();
            //        variables.put("category", "small");
            //        variables.put("qq", 960950120);
            //        runtimeService.setVariable(id, "name", "黄嵩凯");//在runtime的时候插入一个全局变量
            ProcessInstance processInstance = null;
            if (variables.size() != 0){
                 processInstance = runtimeService.startProcessInstanceByKey(key, variables);
            }else{
                 processInstance = runtimeService.startProcessInstanceByKey(key);
            }
            //获取开始表单
            if(processInstance == null)
                return resultWrapper.error("没有表单字段");
            StartFormData startFormData = formService.getStartFormData(processInstance.getProcessDefinitionId());
            if(startFormData != null){
                return resultWrapper.success("流程:"+key+"启动成功",startFormData.getFormProperties());
            }
            return resultWrapper.error("没有表单字段");
           // ProcessInstance start = runtimeService.startProcessInstanceById(processDefinition.getId());//通过id启动
    }

    /**
     *
     * @param id  传入流程id
     * @param variables 想传入什么变量 可以为空map
     * @param claimUserName 指定用户处理 可以为null
     */

    public Result complete(String id, Map variables, String claimUserName) {
        try {
            if (variables.size() != 0) {
                taskService.setVariables(id, variables);
            }
            //是指多个candidate的时候,该用户接受了请求,其他用户就不可见了
            if (StringUtils.isNotEmpty(claimUserName)){
                taskService.claim(id, claimUserName);
            }
            taskService.complete(id);
        }catch(ActivitiObjectNotFoundException exception){
            exception.printStackTrace();
            return resultWrapper.error("无法结束Task 请检查id");
        }
        return resultWrapper.success("Task成功结束", id);
    }

    /**
     *
     * @param id
     * @return
     */
    public Map viewTask(String id) {
        //starter
        Map map = taskService.getVariables(id);
        System.out.println();
//        taskService.
        return map;
    }



    /**
     * 根据id 获取表单
     * @param userId
     * @param key
     * @param map
     * @return
     */

    public String startForm(String userId, String key, Map map) {
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
        //获取开始表单
        ProcessInstance processInstance = formService.submitStartFormData(processDefinition.getId(), variableMap);
        return processInstance.getId();
    }

    public Result taskComplete(@PathVariable String id, HttpServletRequest request) {
        Map<String, String> valsMap = RequestHelper.retrieveJsonFromRequest(request);
        activitiService.complete(id, valsMap);
        result.setSuccess("","");
        return result;
    }

}
