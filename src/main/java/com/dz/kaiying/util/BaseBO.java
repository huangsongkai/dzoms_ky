package com.dz.kaiying.util;

/**
 * 
 */
import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import javax.persistence.Transient;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.hibernate.annotations.Formula;

/** 
 * <!-- begin-UML-doc -->
 * 基于业务模型的实体类对象的超类。依赖于后台。
 * <!-- end-UML-doc -->
 * @author luchongbin
 * @param <T>
 * @generated "UML 至 Java (com.ibm.xtools.transform.uml2.java5.internal.UML2JavaTransform)"
 */
@MappedSuperclass
@org.hibernate.annotations.Entity(dynamicUpdate=true,dynamicInsert=true) 
public class BaseBO implements Serializable {
	
	private static final long serialVersionUID = 4567041038811176723L;
	/** 定义状态：0：正常（默认） */
	public static final Integer lifeStatus_0 = 0;
	/** 定义状态：1：增加  */
	public static final Integer lifeStatus_1 = 1;
	/** 定义状态：2：删除 */
	public static final Integer lifeStatus_2 = 2;
	/** 定义状态：3：修改 */
	public static final Integer lifeStatus_3 = 3;
	
	public BaseBO() {
		super();
	}
	public BaseBO(String id) {
		super();
		this.id = id;
	}
	
	// ==== fields ====
	
	public String getReferenceAbstractId() {
		return referenceAbstractId;
	}
	public void setReferenceAbstractId(String referenceAbstractId) {
		this.referenceAbstractId = referenceAbstractId;
	}

	@Id
	protected String id = splituuid();
	//引用定义id，区分此对象是否是实例
	private String referenceAbstractId;
	//是否是定义，0代表不是定义，1代表是定义
	private Integer isDefine=0;
	// ==== not map fields ====
	@Transient
	private int hashCode = Integer.MIN_VALUE;
	/**
	 * 
	 * <p>
	 * 不映射到数据库
	 * </p>
	 */
	@Transient
	protected Integer lifeStatus = 0;
	
	protected String name;
	
	
	/**
	 * 查询时使用，不用映射数据库字段。
	 */
	@Formula(value="database()")
	protected String dbName;
	
	@Transient
	private Map<String, String> propMap = new HashMap<String, String>();
	// ==== tools methods ====
	
	/**
	 * 将id简化掉“-”，长度32个字符
	 * @return
	 */
	private String splituuid(){
		if(id == null){
			String uuid = java.util.UUID.randomUUID().toString();
			uuid = uuid.replace("-", "");
			return uuid;
		}else{
			return id;
		}
		
	}
	
	// ==== getter / setter ====
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	public Integer getLifeStatus() {
		return lifeStatus;
	}
	
	public Integer getIsDefine() {
		return isDefine;
	}
	public void setIsDefine(Integer isDefine) {
		this.isDefine = isDefine;
	}
	public void setLifeStatus(Integer lifeStatus) {
		this.lifeStatus = lifeStatus;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	// ==== system methods ====
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this);
	}
	
	public boolean equals (Object obj) {
		if (null == obj) return false;
		if (!(obj instanceof BaseBO)) return false;
		else {
			BaseBO bo = (BaseBO) obj;
			if (null == this.getId() || null == bo.getId()) {
				return false;
			} else if (null == this.getDbName() || null == bo.getDbName()) {
				return false;
			} else  {
				return (this.getId().equals(bo.getId()) && this.getDbName().equals(bo.getDbName()));
			}
		}
	}

	public int hashCode () {
		if (Integer.MIN_VALUE == this.hashCode) {
			if (null == this.getId()) return super.hashCode();
			else {
				String hashStr = this.getClass().getName() + ":" + this.getId().hashCode();
				this.hashCode = hashStr.hashCode();
			}
		}
		return this.hashCode;
	}
	
	public String getDbName() {
		return dbName;
	}
	
	public void setDbName(String dbName) {
		this.dbName = dbName;
	}
		
	public Map<String, String> getPropMap() {
		return propMap;
	}
	public void setPropMap(Map<String, String> propMap) {
		this.propMap = propMap;
	}
	
	public String getProperty(String key) {
		return propMap.get(key);
	}
	
	public void setProperty(String key, String value) {
		propMap.put(key, value);
	}
	
	
}