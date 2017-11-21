package com.dz.common.global;

public class ToDo {
	private String msg,state,url;

	public ToDo(){
		
	}
	public ToDo(String msg, String state, String url) {
		super();
		this.msg = msg;
		this.state = state;
		this.url = url;
	}

	public String getMsg() {
		return msg;
	}

	public String getState() {
		return state;
	}

	public String getUrl() {
		return url;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public void setState(String state) {
		this.state = state;
	}

	public void setUrl(String url) {
		this.url = url;
	}
	
}
