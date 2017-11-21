package com.dz.module.vehicle.newcheck;

import com.dz.module.user.User;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Transformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import java.io.File;
import java.util.*;

/**
 * @author doggy
 *         Created on 15-12-7.
 */
@Controller
@Scope(value = "prototype")
public class CheckAction extends ActionSupport{
    /**
	 * 
	 */
	private static final long serialVersionUID = -8945712569805108876L;
	private static final String JSON_RESULT = "json_result";
    @Autowired
    private CheckService service;
    private Plan plan;
    private Group group;
    private CheckRecord checkRecord;
    private int planId;
    private int groupId;
    private int recordId;
    private Object jsonObject;
    private Date time;
    private Date startTime;
    private Date endTime;
    private String reason;
    private String isPassed;

    private String jspPage;

    /**
     * 要上传的图片
     */
    private String image;
    private UnPassDetail unPassDetail;
    private String json;

    /**
     * 添加计划
     * @return
     */
    public String addPlan(){
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
		Map<String,Object> request = (Map<String, Object>)context.get("request");
        service.addPlan(plan);
        request.put("isSaved","dealed");
        request.put("planId",plan.getId());
//        jspPage = "addPlan.jsp";
        jsonObject = plan.getId();
        return JSON_RESULT;
    }

    /**
     * 添加小组信息
     * @return
     */
    public String addGroup(){
        if(service.addGroup(plan,group))
            jspPage = "success.jsp";
        else
            jspPage = "fail.jsp";
        return SUCCESS;
    }

    /**
     * 选择有权限查看的组
     * @return
     */
    public String searchGroupByTimeAndUser(){
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
		Map<String,Object> session = (Map<String, Object>)context.get("session");
        @SuppressWarnings("unchecked")
		Map<String,Object> request = (Map<String, Object>)context.get("request");
        User user = (User)session.get("user");
        List<Group> groups = service.searchGroupByTimeAndUser(user.getUid(),time);
        request.put("groups",groups);
        jspPage = "visiable_group.jsp";
        return SUCCESS;
    }

    /**
     * 详细计划
     * @return
     */
    public String planDetail(){
        jspPage = "plan_detail.jsp";
        plan = service.getPlanById(planId);
        System.out.println(plan.getGroups().size());
        return SUCCESS;
    }

    /**
     * 获得计划信息
     * @return
     */
    public String getGroups_search(){
        jspPage = "groups_search.jsp";
        plan = service.getPlanById(planId);
        return SUCCESS;
    }

    /**
     * 删除小组
     * @return
     */
    public String deleteGroup(){
        service.deleteGroupBy(groupId);
        plan = service.getPlanById(planId);
        jspPage = "plan_detail.jsp";
        return SUCCESS;
    }

    /**
     * 通过小组的id获得小组成员列表
     * @return
     */
    public String getUserNamesByGroupId(){
        List<User> users = service.getUserByGroupId(groupId);
        @SuppressWarnings("unchecked")
        List<String> names = (List<String>)CollectionUtils.collect(users, new Transformer() {
            @Override
            public Object transform(Object o) {
                User u = (User)o;
                return u.getUname();
            }
        });
        jsonObject = names;
        return JSON_RESULT;
    }

    /**
     * 获得带检查记录的小组
     * @return
     */
    public String getGroupWithRecord(){
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
		Map<String,Object> request = (Map<String, Object>)context.get("request");
        request.put("group",service.getGroupWithRecord(groupId));
        jspPage = "addRecord.jsp";
        return SUCCESS;
    }

    /**
     * 同上，但是跳转到不同的页面
     * @return
     */
    public String getGroupWithRecord_1(){
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
		Map<String,Object> request = (Map<String, Object>)context.get("request");
        request.put("group",service.getGroupWithRecord(groupId));
        jspPage = "records_show.jsp";
        return SUCCESS;
    }

    /**
     * 添加一台检查车辆
     * @return
     */
    public String addRecord(){
        if("on".equals(isPassed)){
            checkRecord.setIsPassed(true);
        }
        service.addRecord(group,checkRecord);
//        groupId = group.getId();
//        ActionContext context = ActionContext.getContext();
//        @SuppressWarnings("unchecked")
//		Map<String,Object> request = (Map<String, Object>)context.get("request");
//        request.put("group",service.getGroupWithRecord(group.getId()));
//        jspPage = "addRecord.jsp";
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
		Map<String,Object> request = (Map<String, Object>)context.get("request");
        request.put("checkRecordId",checkRecord.getId());
        jspPage = "add_unpass_detail.jsp";

        return SUCCESS;
    }

    /**
     * 删除记录
     * @return
     */
    public String deleteRecord(){
        service.deleteRecord(recordId);
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
		Map<String,Object> request = (Map<String, Object>)context.get("request");
        request.put("group",service.getGroupWithRecord(groupId));
        jspPage = "addRecord.jsp";
        return SUCCESS;
    }

    public UnPassDetail getUnPassDetail() {
        return unPassDetail;
    }

    public void setUnPassDetail(UnPassDetail unPassDetail) {
        this.unPassDetail = unPassDetail;
    }

    public String searchPlansByTime(){
        List<Plan> plans = service.searchPlansByTime(time);
        ActionContext context = ActionContext.getContext();

        @SuppressWarnings("unchecked")
		Map<String,Object> request = (Map<String, Object>)context.get("request");
        request.put("plans",plans);
        jspPage = "search_checkplan.jsp";
        return SUCCESS;
    }
    public String getAllUsers(){
        List<User> users = service.getAllUser();
        jsonObject = users;
        return JSON_RESULT;
    }

    /**
     * 添加不通过原因
     * @return
     */
    public String addUnPassDetail(){
        JSONArray jsonArray = JSONArray.fromObject(json);
        Object[] objs = jsonArray.toArray();
        for(Object obj:objs){
            JSONObject jobj = JSONObject.fromObject(obj);
            String title = jobj.get("title").toString();
            String seq = jobj.get("photo").toString();
            UnPassDetail up = new UnPassDetail();
            up.setUnPassReason(title);
            service.addUnPassDetail(checkRecord,up,seq);
        }
        jspPage = "refresh.jsp";
        return SUCCESS;
    }

    public String tonji(){
        Map<String,List<TJMessage>> maps = service.tonji(startTime, endTime);
        ActionContext context = ActionContext.getContext();
        Map<String,Object> request = (Map<String, Object>)context.get("request");
        request.put("maps",maps);
        jspPage = "tonji.jsp";
        return SUCCESS;
    }
    public String rePass(){
        boolean res = service.rePass(checkRecord.getId(), reason);
        System.out.println(res);
        jsonObject = "FUCK";
        return JSON_RESULT;
    }
    public String selecctCheckRecordsByTimePass(){
        List<CheckRecord> records = service.selecctCheckRecordsByTimePass(startTime, endTime);
        ActionContext context = ActionContext.getContext();
        Map<String,Object> request = (Map<String, Object>)context.get("request");
        request.put("records",records);
        jspPage = "repass_result.jsp";
        return SUCCESS;
    }

    public String getIsPassed() {
        return isPassed;
    }

    public void setIsPassed(String isPassed) {
        this.isPassed = isPassed;
    }

    public String getJson() {
        return json;
    }

    public void setJson(String json) {
        this.json = json;
    }

    public String getJspPage() {
        return jspPage;
    }

    public void setJspPage(String jspPage) {
        this.jspPage = jspPage;
    }

    public Plan getPlan() {
        return plan;
    }

    public void setPlan(Plan plan) {
        this.plan = plan;
    }

    public Group getGroup() {
        return group;
    }

    public void setGroup(Group group) {
        this.group = group;
    }

    public CheckRecord getCheckRecord() {
        return checkRecord;
    }

    public void setCheckRecord(CheckRecord checkRecord) {
        this.checkRecord = checkRecord;
    }

    public int getPlanId() {
        return planId;
    }

    public void setPlanId(int planId) {
        this.planId = planId;
    }

    public int getGroupId() {
        return groupId;
    }

    public void setGroupId(int groupId) {
        this.groupId = groupId;
    }

    public Object getJsonObject() {
        return jsonObject;
    }

    public void setJsonObject(Object jsonObject) {
        this.jsonObject = jsonObject;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public int getRecordId() {
        return recordId;
    }

    public void setRecordId(int recordId) {
        this.recordId = recordId;
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public static String getJsonResult() {
        return JSON_RESULT;
    }

    public CheckService getService() {
        return service;
    }

    public void setService(CheckService service) {
        this.service = service;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }
}
