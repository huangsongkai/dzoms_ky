package com.dz.module.driver.accident;

import java.util.List;

public interface ACLDao {
	public void addOne(Relation_Accident_CarLoss rac);
	public void removeOne(Relation_Accident_CarLoss rac);
	public List<CarLoss> search(Accident accident, int part);
}
