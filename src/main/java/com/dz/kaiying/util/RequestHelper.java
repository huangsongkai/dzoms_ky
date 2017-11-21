package com.dz.kaiying.util;

import org.json.JSONObject;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 * Created by song on 2017/7/2.
 */
public class RequestHelper {
    public static Map<String, String> retrieveJsonFromRequest(HttpServletRequest request){
        String jsonStr = "";
        try {
            BufferedReader br = new BufferedReader(new InputStreamReader( (ServletInputStream) request.getInputStream(), "utf-8"));
            StringBuffer sb = new StringBuffer("");
            String temp;
            while ((temp = br.readLine()) != null) {
                sb.append(temp);
            }
            br.close();
            jsonStr = sb.toString();
            System.out.print(jsonStr);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return retrieveJsonFromRequest(jsonStr);

    }

    private static Map<String, String> retrieveJsonFromRequest(String jsonStr){
//        JSONObject jsonMap = JSONObject.getNames(jsonStr);
        HashMap<String, String> data = new HashMap<String, String>();
        JSONObject jsonObject = new JSONObject(jsonStr);
      //  jsonObject.get("age");
        Iterator<String> keys = jsonObject.keys();
        while (keys.hasNext()){
            String key = keys.next();
            data.put(key,jsonObject.get(key).toString());
        }
        return data;
    }
    public static void main(String args[]){
        System.out.println(retrieveJsonFromRequest("{\"age\":23,\"id\":123,\"name\":\"tt_2009\"," +
                "\"province\":\"上海\",\"sex\":\"男\"}"));
    }
}