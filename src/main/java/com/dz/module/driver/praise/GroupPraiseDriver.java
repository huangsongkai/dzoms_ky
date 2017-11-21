package com.dz.module.driver.praise;
// default package

import javax.persistence.*;

import static javax.persistence.GenerationType.IDENTITY;


/**
 * GroupPraiseDriver entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name="group_praise_driver"
    ,catalog="ky_dzomsdb"
)

public class GroupPraiseDriver  implements java.io.Serializable {


    // Fields    

     /**
	 * 
	 */
	private static final long serialVersionUID = 3733750226360966707L;
	private Integer id;
     private Integer groupPraiseId;
     private String idNum;


    // Constructors

    /** default constructor */
    public GroupPraiseDriver() {
    }

    
    /** full constructor */
    public GroupPraiseDriver(Integer groupPraiseId, String idNum) {
        this.groupPraiseId = groupPraiseId;
        this.idNum = idNum;
    }

   
    // Property accessors
    @Id @GeneratedValue(strategy=IDENTITY)
    
    @Column(name="id", unique=true, nullable=false)

    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    
    @Column(name="group_praise_id")

    public Integer getGroupPraiseId() {
        return this.groupPraiseId;
    }
    
    public void setGroupPraiseId(Integer groupPraiseId) {
        this.groupPraiseId = groupPraiseId;
    }
    
    @Column(name="id_num", length=30)

    public String getIdNum() {
        return this.idNum;
    }
    
    public void setIdNum(String idNum) {
        this.idNum = idNum;
    }
   








}