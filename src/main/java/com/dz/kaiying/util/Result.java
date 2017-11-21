package com.dz.kaiying.util;

import java.io.Serializable;

/**
 * 返回json格式数据
 * <p>setFailed()返回错误结果</p>
 * <p>setSuccess()返回正确结果</p>
 * @author liuruichao
 * 
 */
public class Result<E> implements Serializable {
	private static final long serialVersionUID = 1L;

	public Result(){}

	public Result(Integer status, String message){
		this.status = status;
		this.message = message;
	}
	private Integer status; // 1表示正确，-1表示错误
	private String message; // 详细信息
	private E data; // 返回的数据

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public E getData() {
		return data;
	}

	public void setData(E data) {
		this.data = data;
	}

	/**
	 * 错误结果
	 * 
	 * @param message 详细信息
	 */
	public void setFailed(String message) {
		this.status = -1;
		this.message = message;
	}
	
	/**
	 * 正确结果
	 * @param message 详细信息
	 * @param data 返回的数据
	 */
	public void setSuccess(String message, E data) {
		this.status = 1;
		this.data = data;
		this.message = message;
	}
}
