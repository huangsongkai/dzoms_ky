package com.dz.module.charge.receipt;

import java.util.Date;
import java.util.List;

import org.hibernate.Session;

/**
 * @author doggy
 *         Created on 15-12-28.
 */
public interface ReceiptDao {
    boolean deleteRecord(int id);
    void addRecord(ReceiptRecord rr, Session session);
    ReceiptRecord getRecord(int id);
    List<ReceiptRecord> searchRecordsByProveNum(String proveNum);
    List<ReceiptRecord> searchRecords(Date start, Date end);
    int getNextAvaliable(String proveNum);
}
