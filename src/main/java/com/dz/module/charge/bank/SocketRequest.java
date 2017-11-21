package com.dz.module.charge.bank;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.InetAddress;
import java.net.Socket;
import java.net.SocketTimeoutException;
import java.util.Map;
import java.util.Properties;

/**
 * SOCKET通讯范例:查询账户信息
 */
public class SocketRequest {
	/**
	 * 生成请求报文
	 * 
	 * @return
	 */
	private String getRequestStr() {
		// 构造查询余额的请求报文
		XmlPacket xmlPkt = new XmlPacket("GetAccInfo", "USRA01");
		Map mpAccInfo = new Properties();
		mpAccInfo.put("BBKNBR", "57");
		mpAccInfo.put("ACCNBR", "571905400610301");
		xmlPkt.putProperty("SDKACINFX", mpAccInfo);
		return xmlPkt.toXmlString();
	}

	/**
	 * 连接前置机，发送请求报文，获得返回报文
	 * 
	 * @param data
	 * @return
	 */
	private String sendRequest(String data) {
		// 连接前置机：Ip + port
		String hostname = "localhost";
		int port = 28080;
		String result = null;
		try {
			InetAddress addr = InetAddress.getByName(hostname);
			Socket socket = new Socket(addr, port);

			// 设置2分钟通讯超时时间
			socket.setSoTimeout(120 * 1000);

			DataOutputStream wr = new DataOutputStream(socket.getOutputStream());

			// 通讯头为8位长度，右补空格：先补充8位空格，再取前8位作为报文头
			String strLen = String.valueOf(data.getBytes().length) + "        ";
			wr.write((strLen.substring(0, 8) + data).getBytes());
			wr.flush();
			DataInputStream rd = new DataInputStream(socket.getInputStream());
			// 接收返回报文的长度
			byte rcvLen[] = new byte[8];
			rd.read(rcvLen);
			String sLen = new String(rcvLen);
			int iSum = 0;
			try {
				iSum = Integer.valueOf(sLen.trim());
			} catch (NumberFormatException e) {
				System.out.println("报文头格式错误：" + sLen);
			}
			if (iSum > 0) {
				System.out.println("响应报文长度:" + iSum);
				// 接收返回报文的内容	
				int nRecv = 0, nOffset = 0;
				byte[] rcvData = new byte[iSum];// data
				while (iSum > 0) {
					nRecv = rd.read(rcvData, nOffset, iSum);
					if (nRecv < 0)
						break;
					nOffset += nRecv;
					iSum -= nRecv;
				}
				result = new String(rcvData);
				System.out.println("响应报文内容:" + result);
			}
			wr.close();
			rd.close();
		} catch (SocketTimeoutException e) {
			System.out.println("通讯超时：" + e.getMessage());
		} catch (IOException e) {
			System.out.println(e.getMessage());
		}
		return result;
	}

	/**
	 * 处理返回的结果
	 * 
	 * @param result
	 */
	private void processResult(String result) {
		if (result != null && result.length() > 0) {
			XmlPacket pktRsp = XmlPacket.valueOf(result);
			if (pktRsp != null) {
				if (pktRsp.isError()) {
					System.out.println("取账户信息失败：" + pktRsp.getErrorMessage());
				} else {
					Map propAcc = pktRsp.getProperty("NTQACINFZ", 0);
					System.out.println("账户" + propAcc.get("ACCNBR") + "的联机余额："
							+ propAcc.get("ONLBLV"));
				}
			} else {
				System.out.println("响应报文解析失败");
			}
		}
	}

	public static void main(String[] args) {
		try {
			SocketRequest request = new SocketRequest();

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