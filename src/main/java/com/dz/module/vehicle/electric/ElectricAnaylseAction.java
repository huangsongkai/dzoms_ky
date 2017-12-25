package com.dz.module.vehicle.electric;

import com.dz.common.global.BaseAction;
import com.dz.common.other.ObjectAccess;
import com.dz.common.other.Timer;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.Date;

@Controller
@Scope(value="prototype")
public class ElectricAnaylseAction extends BaseAction {
	@Autowired
	ElectricAnaylseService anaylseService;
	
	private Date beginDate,endDate;
	private int id;
	
	public void makeAnaylse() throws IOException{
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		ServletActionContext.getResponse().setContentType("application/json");
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		
		
		int index = anaylseService.createAnaylse(beginDate, endDate);
		if (index==0) {
			out.print("创建失败！");
			out.flush();
			out.close();
			return;
		}
		
		final int[] arr = new int[1];
		arr[0] = index;
		
		new Thread(new Runnable() {
			@Override
			public void run() {
				anaylseService.geneXls(arr[0]);
			}
		}).start();
				
		out.print("创建成功！");
		out.flush();
		out.close();
	}
	
	
	public void downloadXls() throws IOException{
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		
		ElectricAnaylse anaylse = ObjectAccess.getObject(ElectricAnaylse.class, id);
		if (anaylse==null) {
			ServletActionContext.getResponse().setContentType("application/json");
			PrintWriter out = ServletActionContext.getResponse().getWriter();
			out.print("请先进行数据分析。");
			out.flush();
			out.close();
		}else{
			String filename = anaylse.getFilePath();
			File file = new File(System.getProperty("com.dz.root")+"data/electric",filename);
			if (!file.exists()) {
				anaylseService.geneXls(id);
			}
			
			ServletActionContext.getResponse().sendRedirect("/DZOMS/download?path=data%2felectric%2f"
					+URLEncoder.encode(filename,"UTF-8"));
			
		}
	}
	
	public void synVehicle() throws IOException{
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");

		Timer timer = new Timer();
		timer.synVehicle();
		
		ServletActionContext.getResponse().sendRedirect("/DZOMS/vehicle/electric/syn_search.jsp");
	}
	
	public void synHistory() throws IOException{
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");

		Timer timer = new Timer();
		//timer.synHistory();
		
		ServletActionContext.getResponse().sendRedirect("/DZOMS/vehicle/electric/syn_search.jsp");
	}
	
	
	
	public Date getBeginDate() {
		return beginDate;
	}
	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}


	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}
}
