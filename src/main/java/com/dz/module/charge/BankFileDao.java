package com.dz.module.charge;

import java.util.Date;

/**
 * @author doggy
 *         Created on 15-11-20.
 */

public interface BankFileDao {
    boolean isFileImported(String md5);
    int importFile(String md5, Date date);
}
