package com.dz.module.vehicle.newcheck;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * @author doggy
 *         Created on 15-12-7.
 */
@Entity
@Table(name = "plan",catalog = "ky_dzomsdb")
public class Plan {
    @Id
    @GeneratedValue
    private int id;
    private String title;
    @Temporal(TemporalType.DATE)
    private Date time;
    @OneToMany(mappedBy = "plan",fetch = FetchType.EAGER)
    private List<Group> groups;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public List<Group> getGroups() {
        return groups;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public void setGroups(List<Group> groups) {
        this.groups = groups;

    }
}
