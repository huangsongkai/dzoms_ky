package com.dz.module.vehicle;

import java.util.Date;

public class InsuranceImportLog {
    private long id;
    private boolean automic;
    private Date opTime;
    private String worklog;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public boolean isAutomic() {
        return automic;
    }

    public void setAutomic(boolean automic) {
        this.automic = automic;
    }

    public Date getOpTime() {
        return opTime;
    }

    public void setOpTime(Date opTime) {
        this.opTime = opTime;
    }

    public String getWorklog() {
        return worklog;
    }

    public void setWorklog(String worklog) {
        this.worklog = worklog;
    }
}
