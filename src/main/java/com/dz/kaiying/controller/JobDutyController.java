package com.dz.kaiying.controller;

import com.dz.kaiying.DTO.*;
import com.dz.kaiying.model.JobDuty;
import com.dz.kaiying.service.ActivitiUtilService;
import com.dz.kaiying.service.JobDutiesService;
import com.dz.kaiying.util.Result;
import com.dz.module.user.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by huang on 2017/4/17.
 */
@Controller
@RequestMapping(value = "/duty")
public class JobDutyController {
    @Resource
    JobDutiesService jobDutiesService;
    @Resource
    ActivitiUtilService activitiUtilService;

        /**
         * （总）工作职责
         * @return
         */
        @RequestMapping(value = "", method = RequestMethod.GET)
        @ResponseBody
        public Result<JobDuty> Query(){
            return jobDutiesService.queryAll();
        }

        @RequestMapping(value = "/{dutyId}", method = RequestMethod.GET)
        @ResponseBody
        public JobDuty QueryById(@PathVariable  Integer dutyId){
            JobDuty jobDutiesList = jobDutiesService.queryById(dutyId);
            return jobDutiesList;
        }

        @RequestMapping(value = "", method = RequestMethod.POST)
        @ResponseBody
        public Result save(@RequestBody JobDuty jobDuty){
            return jobDutiesService.save(jobDuty);
        }

        @RequestMapping(value = "", method = RequestMethod.PUT)
        @ResponseBody
        public Result upadte(@RequestBody JobDuty jobDuties){
            return jobDutiesService.upadte(jobDuties);
        }

        @RequestMapping(value = "", method = RequestMethod.DELETE)
        @ResponseBody
        public Result saveOrUpadte(@RequestBody int[] ids){
            return jobDutiesService.delete(ids);
        }


        /**
         * 用户信息
         * @return
         */
        @RequestMapping(value = "/user", method = RequestMethod.GET)
        @ResponseBody
        public List<User> queryUser(){
            return jobDutiesService.queryUser();
        }


        @RequestMapping(value = "/user/{id}", method = RequestMethod.GET)
        @ResponseBody
        public User queryUserById(@PathVariable int id){
            System.out.println("查询User");
            return jobDutiesService.queryUserById(id);
        }
        /**
         * 用户的工作职责
         * @return
         */
        @RequestMapping(value = "/userJob/{id}", method = RequestMethod.GET)
        @ResponseBody

        public Result queryUserJob(@PathVariable int id){
            return jobDutiesService.queryUserJob(id);
        }

        @RequestMapping(value = "/userJob", method = RequestMethod.POST)
        @ResponseBody
        public Result saveUserUserJob(@RequestBody SaveUserJobDutyDTO saveUserJobDutiesDTO){
            return jobDutiesService.saveUserJob(saveUserJobDutiesDTO);
        }
        /**
         * 绩效考核自评
         * @param request
         * @return
         * @throws Exception
         */
        @RequestMapping(value = "/selfEvaluate/{taskId}", method = RequestMethod.GET)
        @ResponseBody
        public Result myEvaluate(@PathVariable Integer taskId, HttpServletRequest request) throws Exception {
            return jobDutiesService.myEvaluate(request, taskId);
        }

        @RequestMapping(value = "/selfEvaluate/{taskId}", method = RequestMethod.POST)
        @ResponseBody
        public Result saveMyEvaluate(@PathVariable Integer taskId, @RequestBody SaveSelfEvaluateDTO selfEvaluateDTO, HttpServletRequest request) throws Exception {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            return jobDutiesService.saveMyEvaluate(selfEvaluateDTO, user.getUid(), taskId);
        }

        /**
         * 绩效考核 部门考评
         */

        @RequestMapping(value = "/departmentEvaluate/{taskId}", method = RequestMethod.GET)
        @ResponseBody
        public Result departmentEvaluate(@PathVariable Integer taskId,  HttpServletRequest request ) throws Exception {
            return jobDutiesService.departmentEvaluate(request, taskId);
        }
        @RequestMapping(value = "/departmentEvaluate/{taskId}", method = RequestMethod.POST)
        @ResponseBody
        public Result savedepartmentEvaluate(@PathVariable Integer taskId,  @RequestBody SaveDepartmentEvaluateDTO saveDepartmentEvaluateDTO, HttpServletRequest request ) throws Exception {
            return jobDutiesService.savedepartmentEvaluate(saveDepartmentEvaluateDTO, taskId);
        }
        /**
         * 绩效考核 经理考评
         */

        @RequestMapping(value = "/managerEvaluate/{taskId}", method = RequestMethod.GET)
        @ResponseBody
        public Result managerEvaluate(@PathVariable Integer taskId,  HttpServletRequest request ) throws Exception {
            return jobDutiesService.managerEvaluate(request, taskId);
        }
        @RequestMapping(value = "/managerEvaluate/{taskId}", method = RequestMethod.POST)
        @ResponseBody
        public Result saveManagerEvaluate(@PathVariable Integer taskId, @RequestBody SaveManagerEvaluateDTO saveManagerEvaluateDTO, HttpServletRequest request) throws Exception {
            return jobDutiesService.saveManagerEvaluate(saveManagerEvaluateDTO, request, taskId);
        }
        /**
         * 考评历史信息
         * historyxinxi
         */
        @RequestMapping(value = "/history", method = RequestMethod.GET)
        @ResponseBody
        public Result history(HttpServletRequest request){
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            return jobDutiesService.listHistory(user.getUid() ,request);
        }

        /**
         * 考评历史纤细信息
         * @param request
         * @return
         */
        @RequestMapping(value = "/historyDetail/{id}", method = RequestMethod.GET)
        @ResponseBody
        public Result historyDetail(@PathVariable Integer id, HttpServletRequest request ){
            return jobDutiesService.listHistoryDetail(id);
        }

    /**
     * 部门考评 驳回
     * @return
     */
    @RequestMapping(value = "/managerRegect", method = RequestMethod.POST)
    @ResponseBody
    public Result managerEvaluateRegect(@RequestBody RegectDTO regectDTO, HttpServletRequest request){
        return jobDutiesService.managerEvaluateRegect(regectDTO,"manager");
    }

    /**
     * 考核组考评 驳回
     * @return
     */
    @RequestMapping(value = "/groupRegect", method = RequestMethod.POST)
    @ResponseBody
    public Result groupEvaluateRegect(@RequestBody RegectDTO regectDTO,  HttpServletRequest request){
        return jobDutiesService.managerEvaluateRegect(regectDTO,"group");
    }


        /**
         * 跳转职责增删查改页面
         */
        @RequestMapping(value = "/listduty", method = RequestMethod.GET)
        public String listduty () throws Exception {
            return "duty/duty_manager";
        }
        /**
         * 跳转用户职责分配页面
         */
        @RequestMapping(value = "/listuserduty", method = RequestMethod.GET)
        public String listuserduty () throws Exception {
            return "duty/user_duty";
        }
        /**
         * 跳转用户自评页面
         */
        @RequestMapping(value = "/listselfEvaluate", method = RequestMethod.GET)
        public String listselfEvaluate () throws Exception {
            return "duty/self_evaluate";
        }
        /**
         * 跳转部门经理考核页面
         */
        @RequestMapping(value = "/listmanagerEvaluate", method = RequestMethod.GET)
        public String listmanagerEvaluate () throws Exception {
            return "duty/duty_manager";            
        }
        /**
         * 跳转考评小组打分
         */
        @RequestMapping(value = "/listgroupEvaluate", method = RequestMethod.GET)
        public String listgroupEvaluate () throws Exception {
            return "duty/department_evaluate";
        }

        /**
         * 跳转历史纤细信息
         */
        @RequestMapping(value = "/jumpHistory", method = RequestMethod.GET)
        public String jumpHistory (HttpServletRequest request) throws Exception {
            String id = request.getParameter("id");
            request.setAttribute("id",id);
            return "duty/history_evaluate_detail";
        }

        /**
         * 跳转历史纤细信息
         */
        @RequestMapping(value = "/TZListHistory", method = RequestMethod.GET)
        public String TZListHistory (HttpServletRequest request) throws Exception {
            return "duty/history_evaluate_index";
        }
    /**
     * 跳转流程历史信息
     */
    @RequestMapping(value = "/TZProcessHistory", method = RequestMethod.GET)
    public String TZListProcessHistory (HttpServletRequest request) throws Exception {
        return "activity/process/historyTaskDetails";
    }

}
