package com.dz.module.driver.accident;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ACLService {
	@Autowired
	private ACLDao dao;
	@Autowired
	private CarLossDao dao2;
	public void addOne(Accident accident,CarLoss loss){
		dao2.addOne(loss);
		Relation_Accident_CarLoss rac = new Relation_Accident_CarLoss();
		rac.setAccId(accident.getAccId());
		rac.setClId(loss.getClId());
		dao.addOne(rac);
	}
	public void removeOne(Accident accident,CarLoss loss){
		Relation_Accident_CarLoss rac = new Relation_Accident_CarLoss();
		rac.setAccId(accident.getAccId());
		rac.setClId(loss.getClId());
		dao.removeOne(rac);
		dao2.removeOne(loss);
	}
	public List<CarLoss> search(Accident accident, int part) {
		return dao.search(accident, part);
	}
}
