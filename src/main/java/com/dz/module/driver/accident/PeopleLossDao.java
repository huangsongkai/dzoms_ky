package com.dz.module.driver.accident;

public interface PeopleLossDao {
	public void addOne(PeopleLoss cl);
	public void removeOne(PeopleLoss cl);
	public PeopleLoss selectById(int id);
}
