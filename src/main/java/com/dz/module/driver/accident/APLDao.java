package com.dz.module.driver.accident;

import java.util.List;

public interface APLDao {
	void addOne(Relation_Accident_PeopleLoss rac);
	void removeOne(Relation_Accident_PeopleLoss rac);
	List<PeopleLoss> search(Accident accident, int part);
}
