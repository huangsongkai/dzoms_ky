package com.dz.module.driver.accident;

import com.dz.common.convertor.BooleanUtil;
import com.dz.common.global.TimePass;
import com.dz.common.other.FileUploadUtil;
import com.opensymphony.xwork2.ActionContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Map;

@Controller
@Scope(value = "prototype")
public class AccidentAction{
	private static final String SUCCESS = "success";
    @Autowired
	private AccidentService accidentService;
    private AccidentCheck acheck;
	private Accident accident;
    //˾��id
	private String driverId;
    //�⸶��Ա
	private Pay pay;
    //��������
    private TimePass tp;
    //�¹ʴ���״̬��ѯ
	private int selectStyle;
    //�㼯��Ա��ʧ��������ʧ��
    private Loss loss;
	//保险部分
	private AccidentInsurance accidentinsurance;
	private String com_thief;
	private String com_car;
	private String com_people;
	private String com_other;
	private String tra_doc;
	private String tra_car;
	private String tra_people;
	private String tra_other;
	private String[] fids;

	private String ajax_message;
    private Object jsonObject;
	
	public String accidentAddOrUpdate(){
		//success if success,then data_error
		ajax_message =  accidentService.accidentAddOrUpdate(accident);
		if(SUCCESS.equals(ajax_message)){
			@SuppressWarnings("unchecked")
			Map<String,Object> request = (Map<String,Object>)ActionContext.getContext().get("request");
			request.put("accident",accident);
			return "loss_page";
		}else{
			return SUCCESS;
		}
	}

	public String accidentUpdate(){
		ajax_message =  accidentService.accidentAddOrUpdate(accident);
		return SUCCESS;
	}

	//success if success,then data_error
	public String accidentChecked(){
		ajax_message = accidentService.accidentChecked(accident,acheck);
		return SUCCESS;
	}
	//success if success,then data_error
	public String accidentUnChecked(){
		ajax_message = accidentService.accidentUnChecked(accident,acheck);
		return SUCCESS;
	}
	//only success
	public String accidentPaied(){
		ajax_message = accidentService.accidentPay(accident, pay);
		return SUCCESS;
	}
	//
	public String accidentCheckRecords(){
		jsonObject = accidentService.selectAllCheckRecord(accident);
		return "showCheckRecord";
	}
	
	public String accidentSelects(){
		@SuppressWarnings("unchecked")
		Map<String,Object> req = (Map<String, Object>) ActionContext.getContext().get("request");
		req.put("accident_list", accidentService.accidentSelects(driverId, selectStyle, tp));
		return "selectAccidentsResult";
	}

	public String accidentInsuranceGet(){
		jsonObject = accidentService.getAccidentInsurance(accident.getAccId());
		return "showCheckRecord";
	}

	public String accidentSelectById(){
		Accident ac = accidentService.accidentSelectById(accident);
		ac.setDriverId(ac.getDriverId()+" ");
		jsonObject = ac;
		return "selectById";
	}
    public String accidentUpdateLoss(){
		accidentinsurance.setCom_car(BooleanUtil.isOn(com_car));
		accidentinsurance.setCom_people(BooleanUtil.isOn(com_people));
		accidentinsurance.setCom_thief(BooleanUtil.isOn(com_thief));
		accidentinsurance.setCom_other(BooleanUtil.isOn(com_other));
		accidentinsurance.setTra_car(BooleanUtil.isOn(tra_car));
		accidentinsurance.setTra_doc(BooleanUtil.isOn(tra_doc));
		accidentinsurance.setTra_other(BooleanUtil.isOn(tra_other));
		accidentinsurance.setTra_people(BooleanUtil.isOn(tra_people));
		ajax_message = accidentService.accidentUpdateLoss(accident,loss);
		accidentinsurance.setFilePaths(new ArrayList<String>());
		accidentinsurance.setAccId(accident.getAccId());
		System.out.println(System.getProperty("com.dz.root") + "lala/accident/" + accident.getAccId());
		if(fids == null) fids = new String[0];
		for(String fid:fids){
			try {
				if (fid != null) {
					ActionContext actionContext = ActionContext.getContext();
					Map<String, Object> fmaps = actionContext.getApplication();
					Map<String, String> fmap = (Map) fmaps.get("TempFileMap");
					String fileName = (String) (fmap).get(fid);
					String absolutePath = "/lala/accident/" + accident.getAccId() + "/" + fileName;
					if(fileName != null){
						File dir = new File(System.getProperty("com.dz.root") + "lala/accident/" + accident.getAccId());
						if (!dir.exists())
							dir.mkdirs();
						File f = new File(dir, fileName);
						if (FileUploadUtil.store(fid, f)) {
							accidentinsurance.getFilePaths().add(absolutePath);
						}
					}else {
						absolutePath = "/lala/accident/" + accident.getAccId() + "/" + fid;
						accidentinsurance.getFilePaths().add(absolutePath);
					}
				}
			}catch (RuntimeException re){
				re.printStackTrace();
			}
		}
		accidentService.addInsuranceDetail(accidentinsurance);
        return SUCCESS;
    }

    public Loss getLoss() {
        return loss;
    }

    public void setLoss(Loss loss) {
        this.loss = loss;
    }

    public TimePass getTp() {
        return tp;
    }

    public void setTp(TimePass tp) {
        this.tp = tp;
    }

    public Pay getPay() {
		return pay;
	}

	public void setPay(Pay pay) {
		this.pay = pay;
	}

	public AccidentCheck getAcheck() {
		return acheck;
	}

	public void setAcheck(AccidentCheck acheck) {
		this.acheck = acheck;
	}

	public Accident getAccident() {
		return accident;
	}
	public void setAccident(Accident accident) {
		this.accident = accident;
	}
	public AccidentService getAccidentService() {
		return accidentService;
	}

	public void setAccidentService(AccidentService accidentService) {
		this.accidentService = accidentService;
	}

	public String getDriverId() {
		return driverId;
	}

	public void setDriverId(String driverId) {
		this.driverId = driverId;
	}

	public Object getJsonObject() {
		return jsonObject;
	}
	public void setJsonObject(Object jsonObject) {
		this.jsonObject = jsonObject;
	}
	public int getSelectStyle() {
		return selectStyle;
	}

	public void setSelectStyle(int selectStyle) {
		this.selectStyle = selectStyle;
	}

	public String getAjax_message() {
		return ajax_message;
	}

	public void setAjax_message(String ajax_message) {
		this.ajax_message = ajax_message;
	}

	public static String getSUCCESS() {
		return SUCCESS;
	}

	public AccidentInsurance getAccidentinsurance() {
		return accidentinsurance;
	}

	public void setAccidentinsurance(AccidentInsurance accidentInsurance) {
		this.accidentinsurance = accidentInsurance;
	}

	public String getCom_thief() {
		return com_thief;
	}

	public void setCom_thief(String com_thief) {
		this.com_thief = com_thief;
	}

	public String getCom_car() {
		return com_car;
	}

	public void setCom_car(String com_car) {
		this.com_car = com_car;
	}

	public String getCom_people() {
		return com_people;
	}

	public void setCom_people(String com_people) {
		this.com_people = com_people;
	}

	public String getCom_other() {
		return com_other;
	}

	public void setCom_other(String com_other) {
		this.com_other = com_other;
	}

	public String getTra_doc() {
		return tra_doc;
	}

	public void setTra_doc(String tra_doc) {
		this.tra_doc = tra_doc;
	}

	public String getTra_car() {
		return tra_car;
	}

	public void setTra_car(String tra_car) {
		this.tra_car = tra_car;
	}

	public String getTra_people() {
		return tra_people;
	}

	public void setTra_people(String tra_people) {
		this.tra_people = tra_people;
	}

	public String getTra_other() {
		return tra_other;
	}

	public void setTra_other(String tra_other) {
		this.tra_other = tra_other;
	}

	public String[] getFids() {
		return fids;
	}

	public void setFids(String[] fids) {
		this.fids = fids;
	}
}
