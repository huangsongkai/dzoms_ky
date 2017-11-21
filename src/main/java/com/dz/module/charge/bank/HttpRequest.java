package com.dz.module.charge.bank;

import com.dz.module.user.User;
import com.opensymphony.xwork2.ActionContext;
import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.config.PropertiesFactoryBean;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 *
 * HTTP通讯范例: 直接支付
 *
 */
public class HttpRequest {
	/**
	 * 生成请求报文
	 *
	 * @return
	 */
	private static String getRequestStr() {
		// 构造支付的请求报文
		XmlPacket xmlPkt = new XmlPacket("Payment", "USRA01");
		Map mpPodInfo = new Properties();
		mpPodInfo.put("BUSCOD", "N02031");
		xmlPkt.putProperty("SDKPAYRQX", mpPodInfo);
		Map mpPayInfo = new Properties();
		mpPayInfo.put("YURREF", "201009270001");
		mpPayInfo.put("DBTACC", "571905400910411");
		mpPayInfo.put("DBTBBK", "57");
		mpPayInfo.put("DBTBNK", "招商银行杭州分行营业部");
		mpPayInfo.put("DBTNAM", "NEXT TEST");
		mpPayInfo.put("DBTREL", "0000007715");
		mpPayInfo.put("TRSAMT", "1.01");
		mpPayInfo.put("CCYNBR", "10");
		mpPayInfo.put("STLCHN", "N");
		mpPayInfo.put("NUSAGE", "费用报销款");
		mpPayInfo.put("CRTACC", "571905400810812");
		mpPayInfo.put("CRTNAM", "测试收款户");
		mpPayInfo.put("CRTBNK", "招商银行");
		mpPayInfo.put("CTYCOD", "ZJHZ");
		mpPayInfo.put("CRTSQN", "摘要信息:[1.01]");
		xmlPkt.putProperty("SDKPAYDTX", mpPayInfo);
		return xmlPkt.toXmlString();
	}

	/**
	 * 连接前置机，发送请求报文，获得返回报文
	 *
	 * @param data
	 * @return
	 * @throws MalformedURLException
	 */
	public static String sendRequest(String data) {
		ApplicationContext app = WebApplicationContextUtils.getWebApplicationContext(ServletActionContext.getServletContext());
		Properties properties = (Properties) app.getBean("configProperties");
//		String serverIp = "localhost";
//		String port = "28080";

		User user = (User) ActionContext.getContext().getSession().get("user") ;
		String uname = user.getUname();

		String serverIp = properties.getProperty(uname+".serverIp");
		String port = properties.getProperty(uname+".port");

		if (StringUtils.isBlank(serverIp)){
			serverIp = properties.getProperty("serverIp");
		}

		if (StringUtils.isBlank(port)){
			port = properties.getProperty("serverPort");
		}

		StringBuffer result = new StringBuffer("");
		try {
			URL url;
			url = new URL(String.format("http://%s:%s",serverIp,port));

			HttpURLConnection conn;
			conn = (HttpURLConnection) url.openConnection();

			conn.setRequestMethod("POST");
			conn.setDoInput(true);
			conn.setDoOutput(true);
			OutputStream os;
			os = conn.getOutputStream();
			os.write(data.toString().getBytes("GBK"));
			os.close();

			BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream(),"GBK"));

			String line = null;
			while ((line=reader.readLine())!=null){
				result.append(line);
			}
			reader.close();
//			BufferedInputStream br = new BufferedInputStream(conn.getInputStream());
//			byte buffer[] = new byte[1024];
//
//			int size = -1;
//			do {
//				size = br.read(buffer,0,1024);
//				if (size>0)
//					result += new String(buffer,0,size,"GBK");
//			}while (size>0);

			//result = new String(result.getBytes("UTF-8"),"GBK");

//			System.out.println(result);
//			br.close();
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (ProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return result.toString();
	}

	/**
	 * 处理返回的结果
	 *
	 * @param result
	 */
	private void processResult(String result) {
		if (result != null && result.length() > 0) {
			XmlPacket response = XmlPacket.valueOf(result);
			if (response != null) {
				String returnCode = response.getReturnCode();
				if (returnCode.equals("0")) {
					Map propPayResult = response.getProperty("NTQPAYRQZ", 0);
					String sREQSTS = (String) propPayResult.get("REQSTS");
					String sRTNFLG = (String) propPayResult.get("RTNFLG");
					if (sREQSTS.equals("FIN") && sRTNFLG.equals("F")) {
						System.out.println("支付失败："
								+ propPayResult.get("ERRTXT"));
					} else {
						System.out.println("支付已被银行受理（支付状态：" + sREQSTS + "）");
					}
				} else if (returnCode.equals("-9")) {
					System.out.println("支付未知异常，请查询支付结果确认支付状态，错误信息："
							+ response.getErrorMessage());
				} else {
					System.out.println("支付失败：" + response.getErrorMessage());
				}
			} else {
				System.out.println("响应报文解析失败");
			}
		}
	}

	public static void main(String[] args) {
//		String YURREF = test3();
//		System.out.println(YURREF);
		test3after("TEST20170818092338");
	}

	private static void test3before(){
		XmlPacket packet = new XmlPacket("ListMode", "银企直连专用集团1");
		Map interfaceParams=new HashMap();
		interfaceParams.put("BUSCOD","N03030");

		packet.putProperty("SDKMDLSTX",interfaceParams);
		String data = packet.toXmlString();
		System.out.println(data);

		String result = sendRequest(data);
		System.out.println(result);
	}

	//扣款
	private static String test3(){
		XmlPacket packet = new XmlPacket("AgentRequest", "银企直连专用集团1");
		Map<String,String> section1=new HashMap<String,String>();
		section1.put("BUSCOD","N03030");
		section1.put("MODALS","代扣");
		section1.put("C_TRSTYP","代扣出租车规费");
		section1.put("TRSTYP","AYBK");
		section1.put("DBTACC","591902896710201");
		section1.put("BBKNBR","59");
		section1.put("SUM","1000");
		section1.put("TOTAL","1");
		DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
		String YURREF = "TEST"+df.format(new Date());
		section1.put("YURREF",YURREF);
		section1.put("MEMO","代扣出租车费用测试");

		Map<String,String> section2=new HashMap<>();
		section2.put("ACCNBR","591902896710704");
		section2.put("CLTNAM","银企直连专用账户9");
		section2.put("TRSAMT","1000");

		packet.putProperty("SDKATSRQX",section1);
		packet.putProperty("SDKATDRQX",section2);
		String data = packet.toXmlString();
		System.out.println(data);

		String result = sendRequest(data);
		System.out.println(result);
		return YURREF;
	}

	//扣款
	private static void test3after(String YURREF){
		XmlPacket packet = new XmlPacket("GetAgentInfo", "银企直连专用集团1");
		Map<String,String> section1=new HashMap<>();
		section1.put("BUSCOD","N03030");
		DateFormat df = new SimpleDateFormat("yyyyMMdd");
		Calendar time = Calendar.getInstance();
		section1.put("ENDDAT",df.format(time.getTime()));
		time.add(Calendar.DATE,-1);
		section1.put("BGNDAT",df.format(time.getTime()));
//		section1.put("YURREF",YURREF);

		packet.putProperty("SDKATSQYX",section1);
		String data = packet.toXmlString();
		System.out.println(data);

		String result = sendRequest(data);
		System.out.println(result);
	}



	private static void test2(){
		HttpRequest request = new HttpRequest();

		XmlPacket packet = new XmlPacket("QueryAgentList", "银企直连专用集团1");
		Map interfaceParams=new HashMap();
		interfaceParams.put("BUSCOD","N03030");
		packet.putProperty("SDKAGTTSX",interfaceParams);

		String data = packet.toXmlString();
		System.out.println(data);

		String result = request.sendRequest(data);
		System.out.println(result);
	}

	private static void test1() {
		try {
			HttpRequest request = new HttpRequest();

			// 生成请求报文
			String data = request.getRequestStr();

			// 连接前置机，发送请求报文，获得返回报文
			String result = request.sendRequest(data);

			// 处理返回的结果
			request.processResult(result);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

}