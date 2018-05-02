package com.dz.common.other;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.*;

import net.sf.json.JSONObject;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.dz.common.global.BaseAction;

@Controller
@Scope("prototype")
@ParentPackage("struts-default")
@Namespace("/")
@Results( { @Result(name = "success", location = "/success.jsp"),
		@Result(name = "error", location = "/error.jsp") })
public class FileTcpUpload extends BaseAction{
	/**
	 * 上传到的 位置 含文件名
	 */
	private String path;

	/**
	 * 随机生成的一个seq，用于标识
	 */
	public static Map<String,String> seqMap = new HashMap<String,String>();

	@Action(value = "uploadFileTo")
	public void uploadFileTo() throws IOException{
		String seq = getRandomString(30);
		while(seqMap.containsKey(seq)) seq = getRandomString(30);
		seqMap.put(seq, path);

		System.out.println("bind path to seq: "+seq+" --> "+path);

		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		out.print(seq);
		out.flush();
		out.close();
	}

	@Action(value = "isExist")
	public void isExist() throws IOException{
		File file = new File(System.getProperty("com.dz.root")+path);
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		boolean isexist = file.exists();

		System.out.println("file "+ path +" exist: "+isexist);

		out.print(isexist);
		out.flush();
		out.close();
	}

	public void download() throws IOException{
		File file = new File(System.getProperty("com.dz.root")+path);
		if(file.exists()){
			ServletActionContext.getResponse().setContentType("application/octet-stream");
			ServletActionContext.getResponse().setHeader("Content-Disposition", "attachment;fileName=\""+new String(file.getName().getBytes("UTF-8"), "ISO-8859-1")+"\"");

			OutputStream out = ServletActionContext.getResponse().getOutputStream();
			FileUtils.copyFile(file, out);
			out.flush();
			out.close();
		}else{
			ServletActionContext.getResponse().setContentType("application/json");
			ServletActionContext.getResponse().setCharacterEncoding("utf-8");
			PrintWriter out = ServletActionContext.getResponse().getWriter();
			JSONObject json = new JSONObject();
			json.put("msg", "File not found");
			out.print(json.toString());
			out.flush();
			out.close();
		}
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	private static String getRandomString(int length){
		String str="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
		Random random=new Random();
		StringBuffer sb=new StringBuffer();
		for(int i=0;i<length;i++){
			int number=random.nextInt(62);
			sb.append(str.charAt(number));
		}
		return sb.toString();
	}
}
