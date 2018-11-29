package com.dz.common.seqence;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Created by Wang on 2018/11/27.
 */
@Entity
@Table(catalog = "ky_dzomsdb",name = "my_month")
public class MyMonth {
    @Id
    @GeneratedValue
    private int rank;
    private String name;

    public int getRank() {
        return rank;
    }

    public void setRank(int rank) {
        this.rank = rank;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
