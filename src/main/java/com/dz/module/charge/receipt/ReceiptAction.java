package com.dz.module.charge.receipt;

import com.dz.common.seqence.SeqAction;
import com.dz.common.seqence.SeqService;
import com.dz.module.charge.receipt.util.CountPass;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Predicate;
import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * @author doggy
 *         Created on 15-12-28.
 */
@Controller("receiptaction")
@Scope(value = "prototype")
public class ReceiptAction extends ActionSupport  implements ServletRequestAware{
    /**
	 * 
	 */
	protected HttpServletRequest request;
	protected HttpSession session;

	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
		this.session = request.getSession();
	}
	
	private static final long serialVersionUID = -6467549084942429056L;
	private static String STRING_RESULT = "string_result";
    private String ajax_message;
    private ReceiptRecord rr;
    private String reason;
    private Date startTime;
    private Date endTime;
    private String jspPage;
    private String message;
    private int fapiaohao;
    private String carId;
    private int year;
    
    @Autowired
    private ReceiptService service;
    private int startNum;
    private int endNum;
    @Autowired
    private SeqService seqService;
    private String proveNum;
    public String addRecord(){
    	if(rr!=null){
    		rr.setRecordTime(new Date());
    	}
        if(service.addRecord(rr)){
            addActionMessage("添加成功！！！");
            request.setAttribute("msgStr", "添加成功！！！");
            ajax_message="success";
        }
        else{
            addActionMessage("添加失败！！！");
        	request.setAttribute("msgStr", "添加失败！！！");
        	ajax_message="fail";
        }
        if("进货".equals(rr.getStyle())){
        	seqService.increment();
            //jspPage = "in.jsp";
        	ajax_message="添加成功！";
            return STRING_RESULT;
        }else{
            seqService.increment();
            jspPage = "out.jsp";
            return SUCCESS;
        }
        
    }
    
    public void addRecordByLocal() throws IOException{
    	request = ServletActionContext.getRequest();
		session = request.getSession();
		
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		
		if(rr!=null){
    		rr.setRecordTime(new Date());
    	}
		
        if(service.addRecord(rr)){
            out.print("success");
        }
        else{
            out.print("fail");
        }
        out.flush();
        out.close();
    }

    public String getNextAvaliable(){
        ajax_message = ""+service.getNextAvaliable(proveNum);
        return STRING_RESULT;
    }

    public String searchRecordsByProveNum(){
        List<ReceiptRecord> rrs = service.searchRecordsByProveNum(rr.getProveNum());
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
        Map<String,Object> request = (Map<String, Object>)context.get("request");
        request.put("records",rrs);
        jspPage = "in_show.jsp";
        return SUCCESS;
    }
    public String deleteRecord(){
        service.deleteRecord(rr.getId(),rr.getStartNum(),rr.getEndNum());
        List<ReceiptRecord> rrs = service.searchRecordsByProveNum(rr.getProveNum());
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
        Map<String,Object> request = (Map<String, Object>)context.get("request");
        request.put("records",rrs);
        jspPage = "in_show.jsp";
        return SUCCESS;
    }
    public String inRemove(){
        if(service.inRemove(rr.getId(), rr.getStartNum(), rr.getEndNum(),reason)){
            ajax_message = "success";
        }else{
            ajax_message = "fail";
        }
        return STRING_RESULT;
    }
    public String outRemove(){
        if(service.outRemove(rr.getId(), rr.getStartNum(), rr.getEndNum(),reason)){
            ajax_message = "success";
        }else{
            ajax_message = "fail";
        }
        return STRING_RESULT;
    }

    public String getProveNum() {
        return proveNum;
    }

    public void setProveNum(String proveNum) {
        this.proveNum = proveNum;
    }

    public String searchIns(){
        List<ReceiptRecord> rrs = service.searchRecords(startTime,endTime);
        List<ReceiptRecord> rrout = new ArrayList<ReceiptRecord>();
        Iterator<ReceiptRecord> itors = rrs.iterator();
        Map<Integer,List<CountPass>> map = new HashMap<>();
        Map<Integer,StorageItem> simap = new TreeMap<>();
        while(itors.hasNext()){
            ReceiptRecord rr = itors.next();
            if(!rr.getStyle().equals("进货")){
            	rrout.add(rr);
                itors.remove();
            }
            else{
                if(map.get(rr.getId()) == null){
                    map.put(rr.getId(),new ArrayList<CountPass>());
                }
                List<CountPass> cps = map.get(rr.getId());
                CountPass cp = new CountPass(rr.getStartNum(),rr.getEndNum());
                cps.add(cp);
            }
        }
        
//        System.out.println("ReceiptAction.searchIns(),"+rrout);
        
        Iterator<ReceiptRecord> itors2 = rrout.iterator();
        while(itors2.hasNext()){
            ReceiptRecord rr = itors2.next();
            if(rr.getStyle().equals("进货"))
                itors2.remove();
            else{
//            	System.out.println("ReceiptAction.searchIns(),"+rr.getId());
                List<CountPass> cps = new ArrayList<CountPass>();
                
                for(ReceiptRecord rin:rrs){
                	if(rin.getStartNum()<=rr.getStartNum()&&rin.getEndNum()>=rr.getEndNum()){
                		cps = map.get(rin.getId());
//                		System.out.println("ReceiptAction.searchIns(),"+rin.getId());
                		break;
                	}
                }
                
                Iterator<CountPass> it = cps.iterator();
                
                while(it.hasNext()){
                	CountPass cp = it.next();
                	if(cp.getStart()<=rr.getStartNum()&&cp.getEnd()>=rr.getEndNum()){
                		if(cp.getStart()==rr.getStartNum()&&cp.getEnd()==rr.getEndNum()){
                			it.remove();
                		}else if(cp.getStart()==rr.getStartNum()){
                			cp.setStart(rr.getEndNum()+1);
                			break;
                		}else if(cp.getEnd()==rr.getEndNum()){
                			cp.setEnd(rr.getStartNum()-1);
                			break;
                		}else{
                			CountPass left = new CountPass(cp.getStart(), rr.getStartNum()-1);
                			CountPass right = new CountPass(rr.getEndNum()+1,cp.getEnd());
                			it.remove();
                			cps.add(left);
                			cps.add(right);
                			break;
                		}
                	}
                }
            }
        }
        
        
        for(ReceiptRecord rr:rrs){
            if(simap.get(rr.getId()) == null){
                StorageItem si = new StorageItem();
                si.setRecorder(rr.getRecorder());
                si.setProveNum(rr.getProveNum());
                si.setRecordTime(rr.getRecordTime());
                si.setCountPasses(map.get(rr.getId()));
                simap.put(rr.getId(),si);
            }
        }
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
        Map<String,Object> request = (Map<String, Object>)context.get("request");
        request.put("map",simap);
        jspPage = "storage_result.jsp";
        return SUCCESS;
    }
    public String searchRemoves(){
        List<RemoveRecord> rrs = service.searchRemoves(startTime, endTime);
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
        Map<String,Object> request = (Map<String, Object>)context.get("request");
        request.put("records",rrs);
        jspPage = "remove_result.jsp";
        return SUCCESS;
    }
    public String searchRecords(){
        List<ReceiptRecord> rrs = service.searchRecords(startTime,endTime);
        CollectionUtils.filter(rrs, new Predicate() {
            @Override
            public boolean evaluate(Object o) {
                ReceiptRecord rx = (ReceiptRecord)o;
                if("黑A".equals(carId) || StringUtils.isEmpty(carId) || carId.equals(rx.getCarId())){
                    if(fapiaohao == 0){
                        return true;
                    }else{
                        int startNum = rx.getStartNum();
                        int endNum = rx.getEndNum();
                        if(startNum <= fapiaohao && fapiaohao<= endNum){
                            return true;
                        }
                    }
                }
                return false;
            }
        });
        Collections.sort(rrs,
        /*rrs.sort(*/new Comparator<ReceiptRecord>() {
            @Override
            public int compare(ReceiptRecord o1, ReceiptRecord o2) {
                if (o1.getRecordTime() == null || o2.getRecordTime() == null)
                    return -1;
                if (o1.getRecordTime().getTime() > o2.getRecordTime().getTime())
                    return -1;
                else if (o1.getRecordTime().getTime() == o2.getRecordTime().getTime())
                    return 0;
                else
                    return 1;
            }
        });
        
        ActionContext context = ActionContext.getContext();
        @SuppressWarnings("unchecked")
		Map<String,Object> request = (Map<String, Object>)context.get("request");
        request.put("records",rrs);
        jspPage = "search_result.jsp";
        return SUCCESS;
    }
    public String validateIn(){
        if(service.validateIn(startNum,endNum)){
            ajax_message = "success";
        }else{
            ajax_message = "fail";
        }
        return STRING_RESULT;
    }
    public String validateOut(){
    	if(year==0)
    		year=new Date().getYear()+1900;
        if(service.validateSoled(startNum, endNum,year)){
            ajax_message = "success";
        }else{
            ajax_message = "fail";
        }
        return STRING_RESULT;
    }
    public String getStorage(){
        ajax_message = ""+service.getStorage();
        return STRING_RESULT;
    }


    public ReceiptRecord getRr() {
        return rr;
    }

    public void setRr(ReceiptRecord rr) {
        this.rr = rr;
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

    public String getJspPage() {
        return jspPage;
    }

    public void setJspPage(String jspPage) {
        this.jspPage = jspPage;
    }

    public String getAjax_message() {
        return ajax_message;
    }

    public void setAjax_message(String ajax_message) {
        this.ajax_message = ajax_message;
    }

    public int getStartNum() {
        return startNum;
    }

    public void setStartNum(int startNum) {
        this.startNum = startNum;
    }

    public int getEndNum() {
        return endNum;
    }

    public void setEndNum(int endNum) {
        this.endNum = endNum;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getCarId() {
        return carId;
    }

    public void setCarId(String carId) {
        this.carId = carId;
    }

    public int getFapiaohao() {
        return fapiaohao;
    }

    public void setFapiaohao(int fapiaohao) {
        this.fapiaohao = fapiaohao;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}
}
