package com.dz.common.seqence;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * @author doggy
 *         Created on 16-3-2.
 */
@Entity
@Table(catalog = "ky_dzomsdb",name = "seq")
public class Seq {
    @Id
    @GeneratedValue
    private int id;
    private int num;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

}
