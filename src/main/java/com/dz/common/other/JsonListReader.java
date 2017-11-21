package com.dz.common.other;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.io.File;
import java.io.FileNotFoundException;
import java.net.MalformedURLException;
import java.util.Map;
import java.util.Scanner;
import java.util.TreeMap;

import org.springframework.util.ResourceUtils;

public class JsonListReader {
	
	@SuppressWarnings("deprecation")
	public static Object getList(String path,String listname) throws MalformedURLException {
		File file = null;
		try {
			String webRoot = System.getProperty("com.dz.root");
			file = ResourceUtils.getFile(webRoot+"/"+path);
			System.out.println(file.getAbsoluteFile());
		} catch (FileNotFoundException e1) {
			// TODO 自动生成的 catch 块
			e1.printStackTrace();
		}

		if(!file.exists()){
			System.err.println("找不到"+file.getAbsolutePath());
			return null;
		}
		try{
			Scanner sc = new Scanner(file,"utf8");
			StringBuffer sb = new StringBuffer();
			while(sc.hasNextLine()){
				sb.append(sc.nextLine());
			}
			String jsonContext = sb.toString();
			sc.close();
			JSONObject json = JSONObject.fromObject(jsonContext);
			try{
				JSONObject lsmap =  json.getJSONObject(listname);
				Map<String,Object> map = new TreeMap<String,Object>();
				for(Object o:lsmap.keySet()){
				map.put(o.toString(), lsmap.get(o));
				}
				return map;
			}catch(Exception e){
				JSONArray jarray = json.getJSONArray(listname);
				return JSONArray.toList(jarray, String.class);
			}
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}
	}

}
