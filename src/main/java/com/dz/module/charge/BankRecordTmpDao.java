package com.dz.module.charge;

import java.util.Date;
import java.util.List;

/**
 * @author doggy
 *         Created on 15-11-24.
 */
public interface BankRecordTmpDao{
    boolean saveList(List<BankRecordTmp> list);
    List<BankRecordTmp> selectByTimeAndStaus(Date time, int status);
    boolean clearBadRecord();
    boolean importToSql();
    boolean addBadList(List<BankRecordTmp> brts);
}
