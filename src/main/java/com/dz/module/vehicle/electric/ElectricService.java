package com.dz.module.vehicle.electric;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.httpclient.HttpException;
import org.apache.commons.lang3.StringUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.dz.common.other.ObjectAccess;
import com.dz.module.vehicle.Vehicle;

@Service
public class ElectricService {
	 public static String URL ="http://v.juhe.cn/wz/";
	 public static String appKey="f83eb8965ffca1680bb0e16628748442";
	 //public static String appKey="2b243f84276ceb37757248eb80587bef";//测试用
	 
	public static void main(String[] args) {
		ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
		ElectricService electricService = applicationContext.getBean(ElectricService.class);
		
		try {
			System.out.println(electricService.getTimeLeast());
		} catch (HttpException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
	}
	
	public boolean fetch(Vehicle vehicle,int fecthId) throws IOException{
		URL postUrl = new URL(URL + "query?");
		String content =  String.format("key=%s&city=%s&hphm=%s&hpzl=02&classno=%s", appKey,"HLJ_HAERBIN",URLEncoder.encode(vehicle.getLicenseNum(),"UTF-8"), vehicle.getCarframeNum());			
		String resultStr  = post(postUrl, content);
		
        System.out.println(resultStr);
        
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        	
        	JSONObject object = JSONObject.fromObject(resultStr);
            if(object.getInt("error_code")==0){
                System.out.println(object.get("result"));
                JSONObject jsonResult = object.getJSONObject("result");
                JSONArray jsonList = jsonResult.getJSONArray("lists");
                
                for(int i=0;i<jsonList.size();i++){
                	JSONObject jres = jsonList.getJSONObject(i);
                	ElectricHistory history = new ElectricHistory();
                	history.setFecthId(fecthId);
                	history.setCarframeNum(vehicle.getCarframeNum());
                	history.setLicenseNum(vehicle.getLicenseNum());
                	history.setCode(jres.getString("code"));
                	history.setArea(jres.getString("area"));
                	try {
						history.setDate(df.parse(jres.getString("date")));
					} catch (ParseException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
                	history.setAct(jres.getString("act"));
                	history.setFen(jres.getString("fen"));
                	history.setMoney(jres.getString("money"));
                	history.setHandled(jres.getString("handled"));
                	
                	System.out.println(history.toString());
                	addHistory(history);
                }
                
            }else{
                System.out.println(object.get("error_code")+":"+object.get("reason"));
            }
        
		return true;
	}
	
	public void addHistory(ElectricHistory history){
		Date date = history.getDate();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(date!=null||history.getCarframeNum()!=null||history.getCode()!=null){
			long count = ObjectAccess.execute(
					"select count(*) from ElectricHistory "
					+ "where date='"+df.format(date)+"'"
					+ " and carframeNum='"+history.getCarframeNum()+"' "
					+ " and code='"+history.getCode()+"'"
					+ " and act='"+history.getAct()+"'");
			if(count==0){
				ObjectAccess.saveOrUpdate(history);
			}
		}
	}

	public int getTimeLeast() throws HttpException, IOException{
		URL postUrl = new URL(URL + "status?");
		String content = String.format("key=%s", appKey);
		String resultStr = post(postUrl, content);
		 System.out.println(resultStr);
     	
     	JSONObject object = JSONObject.fromObject(resultStr);
         if(object.getInt("error_code")==0){
            System.out.println(object.get("result"));
            JSONObject jsonResult = object.getJSONObject("result");
            int times = jsonResult.getInt("surplus");
            return times;
         }else{
             System.out.println(object.get("error_code")+":"+object.get("reason"));
         }
		return -1;
	}
	
	private static String post(URL postUrl, String content) {
		String line = null;
		try {
			HttpURLConnection connection = (HttpURLConnection) postUrl.openConnection();
			connection.setDoOutput(true);
			connection.setDoInput(true);
			connection.setRequestMethod("POST");
			connection.setUseCaches(false);
			connection.setInstanceFollowRedirects(true);
			connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			connection.connect();
			DataOutputStream out = new DataOutputStream(connection.getOutputStream());
			out.writeBytes(content);
			out.flush();
			out.close();
			BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"));

			while ((line = reader.readLine()) != null) {
				return line;
			}
			reader.close();
			connection.disconnect();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return line;
	}
}
