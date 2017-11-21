package com.dz.module.driver.meeting;

import com.dz.common.global.Page;

import org.hibernate.HibernateException;
import org.javatuples.Triplet;

import java.util.Date;
import java.util.List;

public interface MeetingDao {

	public abstract List<Meeting> selectAllMeeting(Page page, Date beginDate,
												   Date endDate) throws HibernateException;

	public abstract int selectAllMeetingCount(Date beginDate, Date endDate)
			throws HibernateException;

	public abstract void addMeeting(Meeting Meeting)
			throws HibernateException;

	public abstract void updateMeeting(Meeting Meeting)
			throws HibernateException;

	public abstract void deleteMeeting(Meeting Meeting)
			throws HibernateException;
	public void addMeetingCheck(MeetingCheck meetingCheck);

	public abstract void updateMeetingCheck(MeetingCheck meetingCheck);

	public abstract MeetingCheck selectMeetingCheck(Integer meetingId,
													String idNum);

	public abstract List<MeetingCheck> selectMeetingCheck(Integer meetingId, Triplet<String, String, Object>... conditions);

	List<MeetingCheck> selectMeetingCheck(String dept, Integer meetingId, Triplet<String, String, Object>... conditions);

	int selectLeaveNumber(Integer meetingId, String dept);

	int selectMeetingCheckCount(Integer meetingId,
								Triplet<String, String, Object>... conditions);
}