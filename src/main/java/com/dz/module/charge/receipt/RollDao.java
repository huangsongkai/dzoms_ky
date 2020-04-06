package com.dz.module.charge.receipt;

import org.hibernate.Session;

/**
 * @author doggy
 *         Created on 15-12-28.
 */
public interface RollDao {
	boolean addFromSeg(int startNum, int endNum, int year);
    void markAsUsed(int startNum, int endNum, int numberSize, String prefix, Session session);

    void addFromSeg(int startNum, int endNum, int numberSize, String prefix, int year, Session session);

    boolean markAsUnUsed(int startNum, int endNum,String prefix);
    boolean isValidForIn(int startNum, int endNum,String prefix);
    boolean isValidForSold(int startNum, int endNum, int year,String prefix);
    long getStorage();
    boolean deleteRoll(int startNum, int endNum,String prefix);
}
