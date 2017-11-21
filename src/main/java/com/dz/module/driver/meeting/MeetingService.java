package com.dz.module.driver.meeting;

import org.hibernate.HibernateException;
import org.javatuples.Triplet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dz.common.global.Page;

import java.util.Date;
import java.util.List;

@Service
public class MeetingService {
	@Autowired
	private MeetingDao meetingDao;

	public int selectAllMeetingCount(Date beginDate, Date endDate) throws HibernateException {
		return meetingDao.selectAllMeetingCount(beginDate,endDate);
	}

	public List<Meeting> selectAllMeeting(Page page,Date beginDate, Date endDate) throws HibernateException {
		return meetingDao.selectAllMeeting(page,beginDate,endDate);
	}

	public void setMeetingDao(MeetingDao meetingDao) {
		this.meetingDao = meetingDao;
	}

	public void addMeeting(Meeting meeting) throws HibernateException {
		meetingDao.addMeeting(meeting);
	}

	public void updateMeeting(Meeting meeting) throws HibernateException {
		meetingDao.updateMeeting(meeting);
	}

	public void deleteMeeting(Meeting meeting) throws HibernateException {
		meetingDao.deleteMeeting(meeting);
	}

	public void addMeetingCheck(MeetingCheck meetingCheck) {
		meetingDao.addMeetingCheck(meetingCheck);
	}

	public void updateMeetingCheck(MeetingCheck meetingCheck) {
		meetingDao.updateMeetingCheck(meetingCheck);
	}

	public MeetingCheck selectMeetingCheck(Integer meetingId, String idNum) {
		return meetingDao.selectMeetingCheck(meetingId,idNum);
	}

	public List<MeetingCheck> selectMeetingCheck(Integer meetingId,Triplet<String, String, Object>...triplets ) {
		return meetingDao.selectMeetingCheck(meetingId,triplets);
	}

}
