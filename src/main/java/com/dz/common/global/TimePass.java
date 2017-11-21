package com.dz.common.global;

import java.util.Date;

/**
 * @author doggy
 *         Created on 15-10-10.
 */
public class TimePass {
    private Date startTime;
    private Date endTime;

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(Date startTime) {
        this.startTime = startTime;
    }

    public boolean isTimeInIt(Date now){
        if(startTime == null || endTime == null || now == null){
            return true;
        }
        if(now.compareTo(startTime) >= 0 && now.compareTo(endTime) <= 0){
            return true;
        }
        return false;
    }
    @SuppressWarnings("deprecation")
	public void checkNotNull(){
        if(startTime == null){
            startTime = new Date(0);
        }
        if(endTime == null){
            endTime = new Date();
            endTime.setYear(215);
        }
    }
}
