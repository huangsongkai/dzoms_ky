package com.dz.module.charge.bank;

import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.parsers.SAXParser;
import javax.xml.parsers.SAXParserFactory;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;
import java.util.Vector;

/**
 * 
 * 招行XML通讯报文类
 *
 */
public class XmlPacket{
	protected String functionName;
	protected final String dataType ="2";//报文类型固定为2
	protected String loginName;
	protected String returnCode;
	protected String errorMessage;
	protected Map data; //<String,Vector>
	
	public XmlPacket(){
		data = new Properties();
	}
	
	public XmlPacket(String functionName){
		this.functionName = functionName;
		data = new Properties();
	}
	
	public XmlPacket(String functionName, String loginName){
		this.functionName = functionName;
		this.loginName = loginName;
		data = new Properties();
	}

	public String getFunctionName() {
		return functionName;
	}

	public void setFunctionName(String functionName) {
		this.functionName = functionName;
	}

	public String getDataType() {
		return dataType;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getReturnCode() {
		return returnCode;
	}

	public void setReturnCode(String returnCode) {
		this.returnCode = returnCode;
	}

	public String getErrorMessage() {
		return errorMessage;
	}

	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}

	/**
	 * XML报文返回头中内容是否表示成功
	 * @return
	 */
	public boolean isError(){
		if(returnCode.equals("0")){
			return false;
		}else{
			return true;
		}
	}
	
	/**
	 * 插入数据记录
	 * @param sectionName
	 * @param mpData <String, String>
	 */
	public void putProperty(String sectionName,Map mpData){
		if(data.containsKey(sectionName)){
			Vector vt = (Vector)data.get(sectionName);
			vt.add(mpData);
		}else{
			Vector vt = new Vector();
			vt.add(mpData);
			data.put(sectionName, vt);
		}		
	}
	
	/**
	 * 取得指定接口的数据记录
	 * @param sectionName
	 * @param index 索引，从0开始
	 * @return Map<String,String>
	 */
	public Map getProperty(String sectionName, int index){
		if(data.containsKey(sectionName)){
			return (Map)((Vector)data.get(sectionName)).get(index);
		}else{
			return null;
		}
	}
	
	/**
	 * 取得制定接口数据记录数
	 * @param sectionName
	 * @return
	 */
	public int getSectionSize(String sectionName){
		if(data.containsKey(sectionName)){
			Vector sec = (Vector)data.get(sectionName);
			return sec.size();
		}
		return 0;
	}
	
	/**
	 * 把报文转换成XML字符串
	 * @return
	 */
	public String toXmlString(){
		StringBuffer dataStringBuffer = new StringBuffer(
				"<?xml version=\"1.0\" encoding = \"GBK\"?>");
		dataStringBuffer.append("<CMBSDKPGK>");
		dataStringBuffer.append("<INFO>" +
				"<FUNNAM>"+ functionName +"</FUNNAM>" +
				"<DATTYP>"+ dataType +"</DATTYP>" +
				"<LGNNAM>"+ loginName +"</LGNNAM>" +
				"</INFO>");
		int section_size = data.size();
		Iterator it = data.keySet().iterator();
		while(it.hasNext()){
			String sectionName = (String)it.next();
			Vector v = (Vector)data.get(sectionName);
			for(int i=0; i<v.size(); i++){
				Map record = (Map)v.get(i);
				Iterator it2 = record.keySet().iterator();
				dataStringBuffer.append("<"+sectionName+">");
				while(it2.hasNext()){
					String datakey = (String)it2.next();
					String dataValue = record.get(datakey).toString();
					dataStringBuffer.append("<"+datakey+">");
					dataStringBuffer.append(dataValue);
					dataStringBuffer.append("</"+datakey+">");
				}
				dataStringBuffer.append("</"+sectionName+">");
			}
		}
		dataStringBuffer.append("</CMBSDKPGK>");
		return dataStringBuffer.toString();
	}
	
	/**
	 * 解析xml字符串，并转换为报文对象
	 * @param message
	 */
	public static XmlPacket valueOf(String message) {
		SAXParserFactory factory = SAXParserFactory.newInstance();
		try {
			SAXParser parser = factory.newSAXParser();
			ByteArrayInputStream bin = new ByteArrayInputStream(message.getBytes());
			XmlPacket packet= new XmlPacket();
			parser.parse(bin, new SaxHandler(packet));
			bin.close();
			packet.setReturnCode((String) packet.getProperty("INFO",0).get("RETCOD"));
			packet.setErrorMessage((String) packet.getProperty("INFO",0).get("ERRMSG"));
			packet.setFunctionName((String) packet.getProperty("INFO",0).get("FUNNAM"));
			packet.setLoginName((String) packet.getProperty("INFO",0).get("LGNNAM"));
			return packet;
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}	
		return null;
	}
}