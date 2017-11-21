package com.dz.module.charge.receipt;

import org.hibernate.Session;

/**
 * @author doggy
 *         Created on 15-12-28.
 */
public interface RollDao {
	boolean addFromSeg(int startNum, int endNum, int year);
    void addFromSeg(int startNum, int endNum, int year, Session session);
    boolean markAsUsed(int startNum, int endNum);
    void markAsUsed(int startNum, int endNum, Session session);
    boolean markAsUnUsed(int startNum, int endNum);
    boolean isValidForIn(int startNum, int endNum);
    boolean isValidForSold(int startNum, int endNum, int year);
    long getStorage();
    boolean deleteRoll(int startNum, int endNum);
}
