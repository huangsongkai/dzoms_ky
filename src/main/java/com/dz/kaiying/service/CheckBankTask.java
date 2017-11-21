package com.dz.kaiying.service;

import org.activiti.engine.delegate.DelegateTask;
import org.activiti.engine.delegate.TaskListener;
import org.springframework.stereotype.Component;

import java.util.logging.Logger;

@Component("CheckBankTask")
public class CheckBankTask implements TaskListener {

    private final Logger log = Logger.getLogger(CheckBankTask.class.getName());

//    @Resource
//    ActivitiUtilService activitiUtilService;
//    @Resource
//    RuntimeService runtimeService;
//    @Resource
//    TaskService taskService;
//    @Resource
//    FormService formService;
//    @Resource
//    HistoryService historyService;
    @SuppressWarnings("unchecked")
    public void notify(DelegateTask delegateTask) {
        String processInstanceId = delegateTask.getProcessInstanceId();


//       // taskService.get
//      //  taskService.getVariableLocal("","")
//        //delegateTask.getTaskDefinitionKey()
//        StartFormData startFormData = formService.getStartFormData(delegateTask.getProcessDefinitionId()); //拿到第一节点的fromkey
//       StartFormData startFormData1 = formService.getStartFormData(delegateTask.getTaskDefinitionKey()); //
//        formService.getTaskFormData(delegateTask.getId()).getFormProperties();
//        delegateTask.getProcessDefinitionId();
//        formService.getTaskFormData("");
//       startFormData1.toString();
//       startFormData1.getFormProperties().get(0).getValue();//       Map<String, Object> map = runtimeService.getVariables(delegateTask.getProcessInstanceId());

//        TaskFormData fromdata = formService.getTaskFormData(delegateTask.getId());
//        fromdata.getTask().getTaskLocalVariables();
//        //activitiUtilService.
//        log.info("i am CheckBankTask.");
//        System.out.println("in : " + delegateTask.getVariables());
//        System.out.println("第一个表单填写的值"+startFormData.toString());
////        ((HashMap<String, Object>)delegateTask.getVariables().get("in")).put("next", "CheckBankTask");
////        ((HashMap<String, Object>)delegateTask.getVariables().get("out")).put("reponse", "subprocess:CheckBankTask->CheckMerchantTask");
    }
}