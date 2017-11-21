package com.dz.module.driver.accident;

import java.util.List;

public interface AccidentCheckDao {
	/**
	 * @param ac
	 * @return null
	 */
	public AccidentCheck recentAccidentCheck(Accident ac);
	public List<AccidentCheck> allAccidentCheck(Accident ac);
	public boolean addOne(AccidentCheck ac);
}
