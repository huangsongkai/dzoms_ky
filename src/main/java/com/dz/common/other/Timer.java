package com.dz.common.other;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.module.vehicle.Vehicle;
import com.opensymphony.xwork2.ActionContext;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;
import org.apache.commons.io.FileUtils;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.io.*;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.List;
import java.util.Map;
import java.util.Properties;

@Component
public class Timer {
	@Scheduled(cron="0 0 0 * * ?")
	public void cleanTempFiles(){
		Map<String, Object> appliaction = ActionContext.getContext().getApplication();
		Map<String,String> map = (Map<String,String>)appliaction.get("TempFileMap");
		
		System.out.println("Clean the temp file......");
		
		File file = new File(System.getProperty("com.dz.root")+"tmp");
		
		for(File tmpFile:file.listFiles()){
			String filename = file.getName();
			map.remove(filename);
			file.delete();
		}
	}
	
	private static ServerSocket server;
	
	/**
	 * 用于启动Tcp 文件上传组件
	 */
	@Scheduled(cron="0 0/10 * * * ?")
	public void startTcpServer(){
		if(server==null)
		try {
			System.out.println("TCP服务开启。。。。。。");
			server = new ServerSocket(32767);
			new Thread(new Runnable() {
				@Override
				public void run() {
					while(true)
					try {
						Socket s=server.accept();
						while(true){
							if(s!=null){
								System.out.println(s+"连接");    //在控制台打印客户连接信息
								break;
							}
						}
						BufferedInputStream bis = new BufferedInputStream(s.getInputStream());
						byte[] seqbuff = new byte[60];
						bis.read(seqbuff);
						String seq = new String(seqbuff,"UTF-16LE");
						System.out.println("seq:"+seq);
						String path = FileTcpUpload.seqMap.get(seq);
						System.out.println("filepath: "+path);
						File file = new File(System.getProperty("com.dz.root")+path);
						if(!file.getParentFile().exists()){
							boolean success = file.getParentFile().mkdirs();
							System.out.println("mkdir success:"+success);
						}
							
						if(!file.exists()){
							boolean success = file.createNewFile();
							System.out.println("create file success:"+success);
						}
						
						BufferedOutputStream os = new BufferedOutputStream(FileUtils.openOutputStream(file));
						
						byte[] filebuff = new byte[4096];
						int i;
						while((i=bis.read(filebuff))>0){
							os.write(filebuff, 0, i);
						}
						
						os.flush();
						os.close();
						
						bis.close();
						
						FileTcpUpload.seqMap.remove(seq);
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}).start();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Scheduled(cron="0 0 0 0/3 * ?")
	public void synVehicle(){
		JSONArray jarr = new JSONArray();
		Session session = HibernateSessionFactory.getSession();
		Query query = session.createQuery("from Vehicle where state=1");
		List<Vehicle> vehicles = query.list();
		for (Vehicle vehicle : vehicles) {
			JSONObject json = new JSONObject();
			json.put("carframeNum", vehicle.getCarframeNum());
			json.put("dept", vehicle.getDept());
			json.put("licenseNum", vehicle.getLicenseNum());
			jarr.add(json);
		}
		
		Properties elecConf = new Properties();
		try {
			elecConf.load(Timer.class.getResourceAsStream("Electric.properties"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String ip = elecConf.getProperty("ip");
		String port = elecConf.getProperty("port");
		
		if (ip==null) {
			ip="125.211.198.176";
		}
		if (port==null) {
			port="8080";
		}
		
		String url = "http://"+ip+":"+port+"/DzElectric/synVehicle";
		
		//TODO　Post to remote electric vehicle list
		HttpClient httpClient = new HttpClient();
		PostMethod postMethod = new PostMethod(url);
		
		postMethod.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET,"utf-8");
		
		postMethod.addParameter("jsonStr", jarr.toString());
		
		try {
			int result = httpClient.executeMethod(postMethod);
			if(result==200){
	        	InputStream input2 = postMethod.getResponseBodyAsStream();
		        
	        	StringBuffer sb = new StringBuffer();
		        int l;
		        byte[] tmp = new byte[65536];
		       // System.out.println();
		        while ((l = input2.read(tmp)) > 0) {
		        	sb.append(new String(tmp,0,l,"utf-8"));
		        }
		        String ss = sb.toString();
		        
		        JSONObject jobj = JSONObject.fromObject(ss);
		        
		        if ("success".equals(jobj.getString("status"))) {
		        	System.out.println("违章系统，车辆信息同步成功！共同步"+jobj.getInt("number")+"条数据、");
					return;
				}else{
					System.err.println("违章系统，车辆信息同步失败！原因是："+jobj.getString("reason"));
					return;
				}
		        
			}
		} catch (HttpException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e){
		}
	}

	public void synHistory() {
	}
}
