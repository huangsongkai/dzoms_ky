package com.dz.module.driver.accident;

public interface CarLossDao {
	public void addOne(CarLoss cl);
	public void removeOne(CarLoss cl);
	public CarLoss selectById(int id);
}
