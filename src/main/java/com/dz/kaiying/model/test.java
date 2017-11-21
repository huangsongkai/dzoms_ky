package com.dz.kaiying.model;
// default package

import javax.persistence.*;

import static javax.persistence.GenerationType.IDENTITY;

/**
 * Authority entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "test", catalog = "dzomsdb")
public class test implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = -7885510207958408068L;
	private Integer aid;
	private String aname;
	private String gname;
	private String mname;
	private String tname;
	private String url;
	private Integer order;
	private String cssClass;
	private String icon;
	private Boolean visible;
	private Integer frameSize;
	private String img;

	// Constructors

	/** default constructor */
	public test() {
	}

	/** minimal constructor */
	public test(String aname, String gname, String mname, String url,
				Integer order) {
		this.aname = aname;
		this.gname = gname;
		this.mname = mname;
		this.url = url;
		this.order = order;
	}

	/** full constructor */
	public test(String aname, String gname, String mname, String tname,
				String url, Integer order, String cssClass, String icon,
				Boolean visible) {
		this.aname = aname;
		this.gname = gname;
		this.mname = mname;
		this.tname = tname;
		this.url = url;
		this.order = order;
		this.cssClass = cssClass;
		this.icon = icon;
		this.visible = visible;
	}

	// Property accessors
	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "aid", unique = true, nullable = false)
	public Integer getAid() {
		return this.aid;
	}

	public void setAid(Integer aid) {
		this.aid = aid;
	}

	@Column(name = "aname", nullable = false, length = 30)
	public String getAname() {
		return this.aname;
	}

	public void setAname(String aname) {
		this.aname = aname;
	}

	@Column(name = "gname", nullable = false, length = 30)
	public String getGname() {
		return this.gname;
	}

	public void setGname(String gname) {
		this.gname = gname;
	}

	@Column(name = "mname", nullable = false, length = 30)
	public String getMname() {
		return this.mname;
	}

	public void setMname(String mname) {
		this.mname = mname;
	}

	@Column(name = "tname", length = 30)
	public String getTname() {
		return this.tname;
	}

	public void setTname(String tname) {
		this.tname = tname;
	}

	@Column(name = "url", nullable = false, length = 100)
	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	@Column(name = "order", nullable = false)
	public Integer getOrder() {
		return this.order;
	}

	public void setOrder(Integer order) {
		this.order = order;
	}

	@Column(name = "cssClass")
	public String getCssClass() {
		return this.cssClass;
	}

	public void setCssClass(String cssClass) {
		this.cssClass = cssClass;
	}

	@Column(name = "icon")
	public String getIcon() {
		return this.icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	@Column(name = "visible")
	public Boolean getVisible() {
		return this.visible;
	}

	public void setVisible(Boolean visible) {
		this.visible = visible;
	}

	@Column(name="frameSize",nullable=false)
	public Integer getFrameSize() {
		return frameSize;
	}

	public void setFrameSize(Integer frameSize) {
		this.frameSize = frameSize;
	}

	@Column(name = "img")
	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}
	
	

}