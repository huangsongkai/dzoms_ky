package com.dz.kaiying.controller.activiti;

import com.dz.kaiying.DTO.activityDTO.FormPropertieDetailDTO;
import com.dz.kaiying.DTO.activityDTO.LocalVariableDetailDTO;
import com.dz.kaiying.DTO.activityDTO.TaskDTO;
import com.dz.kaiying.service.ActivitiService;
import com.dz.kaiying.util.RequestHelper;
import com.dz.kaiying.util.Result;
import org.activiti.engine.FormService;
import org.activiti.engine.HistoryService;
import org.activiti.engine.TaskService;
import org.activiti.engine.form.FormProperty;
import org.activiti.engine.form.TaskFormData;
import org.activiti.engine.history.HistoricTaskInstance;
import org.activiti.engine.task.Task;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by song on 2017/3/27.
 */
@Controller
@RequestMapping(value = "/activity/task")
public class TaskController {

    @Resource
    private ActivitiService activitiService;
    @Resource
    private TaskService taskService;
    @Resource
    private FormService formService;
    @Resource
    private HistoryService historyService;

    private Result result = new Result();

    @RequestMapping(value="/list", method= RequestMethod.GET)
    public String toList() {
        return "activity/task_list";
    }

    @RequestMapping(value="/history", method= RequestMethod.GET)
    public String history() {
        return "activity/task/history";
    }

    @RequestMapping(value="/execute/{taskId}", method= RequestMethod.GET)
    public String toExecute(@PathVariable String taskId, HttpServletRequest request) {
        Task task = taskService.createTaskQuery().taskId(taskId).list().get(0);
        if(task != null && task.getFormKey()!=null){
            request.setAttribute("taskId",task.getId());
            return task.getFormKey();
        }
        List<TaskDTO> taskList = new ArrayList<>();
        TaskDTO taskDTO = new TaskDTO();
        return "activity/task_details";
    }
    @RequestMapping(value="/{id}", method= RequestMethod.GET)
    public Map taskNextStep(@PathVariable String id) {
        return activitiService.viewTask(id);
    }

    @RequestMapping(value="/{id}", method= RequestMethod.POST)
    @ResponseBody
    public Result taskComplete(@PathVariable String id, HttpServletRequest request) {
        Map<String, String> valsMap = RequestHelper.retrieveJsonFromRequest(request);
        activitiService.complete(id, valsMap);
        result.setSuccess("","");
        return result;
    }

    static class TaskRepresentation {

        private String id;
        private String name;

        public TaskRepresentation(String id, String name) {
            this.id = id;
            this.name = name;
        }
        public String getId() {
            return id;
        }
        public void setId(String id) {
            this.id = id;
        }
        public String getName() {
            return name;
        }
        public void setName(String name) {
            this.name = name;
        }

    }
    /**
     * 读取Task的表单
     * @RequestMapping(value = "get-form/task/{processDefinitionkey}")
     * @PathVariable("processDefinitionkey") String processDefinitionkey
     */
    @RequestMapping(value = "/get-form/task/{processInstanceId}")
    @ResponseBody
    public ModelAndView findTaskForm(@PathVariable("processInstanceId") String processInstanceId, HttpServletRequest request) throws Exception {
        return activitiService.findTaskForm(processInstanceId,request);
    }

    @RequestMapping(value="/taskDetails/{taskId}", method= RequestMethod.GET)
    @ResponseBody
    public Result listTaskDetail(@PathVariable String taskId) {
        Task task = taskService.createTaskQuery().taskId(taskId).list().get(0);
        List<TaskDTO> taskList = new ArrayList<>();
       // List<HistoricDetail> historyList = historyService.createHistoricDetailQuery().processInstanceId(task.getProcessInstanceId()).list();
        List<HistoricTaskInstance> historicTaskList = historyService.createHistoricTaskInstanceQuery().processInstanceId(task.getProcessInstanceId()).list();
        TaskFormData fromdata = formService.getTaskFormData(taskId);
        List<FormProperty> formProperties = fromdata.getFormProperties();
        for (HistoricTaskInstance localVariable : historicTaskList) {
            TaskDTO taskDTO = new TaskDTO();
            taskDTO.setId(Integer.parseInt(localVariable.getId()));
            taskDTO.setAssignee(localVariable.getAssignee());
            taskDTO.setName(localVariable.getName());
            taskDTO.setTime(localVariable.getEndTime());
            List<LocalVariableDetailDTO> localVariableDetailDTOList = new ArrayList<>();
            for (Map.Entry<String, Object> entry : localVariable.getTaskLocalVariables().entrySet()) {
                String key = entry.getKey().toString();
                Integer value = Integer.parseInt(entry.getValue().toString());
                System.out.println("key =" + key + " value = " + value);
                LocalVariableDetailDTO localVariableDetailDTO = new LocalVariableDetailDTO();
                localVariableDetailDTO.setName(key);
                localVariableDetailDTO.setValue(value);
                localVariableDetailDTO.setScope(null);
                localVariableDetailDTOList.add(localVariableDetailDTO);
            }
            //判断历史记录是不是只有一个 如果不是删除最后一个返回

            if (localVariableDetailDTOList.size() == 1 || localVariableDetailDTOList.size() == 0){

            }else {
                localVariableDetailDTOList.remove(localVariableDetailDTOList.size());
                taskDTO.setLocalVariables(localVariableDetailDTOList);
            }
            taskList.add(taskDTO);
        }


        List <FormPropertieDetailDTO>  frompList = new ArrayList<>();
        TaskDTO taskDTO = new TaskDTO();
        taskDTO.setName(task.getName());
        taskDTO.setAssignee(task.getAssignee());
        taskDTO.setTime(task.getCreateTime());
        for (FormProperty formP : formProperties) {
            FormPropertieDetailDTO formPropertieDetailDTO  = new FormPropertieDetailDTO();
            formPropertieDetailDTO.setName(formP.getName());
            formPropertieDetailDTO.setType(formP.getType().getName());
            formPropertieDetailDTO.setId(formP.getId());
            formPropertieDetailDTO.setValue(formP.getValue());
            formPropertieDetailDTO.setReadable(true);
            formPropertieDetailDTO.setWritable(true);
            formPropertieDetailDTO.setRequired(true);
            formPropertieDetailDTO.setEnumValues(null);
            frompList.add(formPropertieDetailDTO);
        }
        taskDTO.setFormProperties(frompList);
        taskList.add(taskDTO);
        result.setSuccess("保存成功",taskList);
        return result;
    }




}
