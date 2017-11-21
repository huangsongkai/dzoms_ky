package com.dz.module.driver.accident;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class APLService {
	@Autowired
	APLDao dao;
	@Autowired
	PeopleLossDao dao2;
	public void addOne(Accident accident,PeopleLoss loss){
		dao2.addOne(loss);
		Relation_Accident_PeopleLoss rac = new Relation_Accident_PeopleLoss();
		rac.setAccId(accident.getAccId());
		rac.setPlId(loss.getPlId());
		dao.addOne(rac);
	}
	public void removeOne(Accident accident,PeopleLoss loss){
		Relation_Accident_PeopleLoss rap = new Relation_Accident_PeopleLoss();
		rap.setAccId(accident.getAccId());
		rap.setPlId(loss.getPlId());
		dao.removeOne(rap);
		dao2.removeOne(loss);
	}
	public List<PeopleLoss> search(Accident accident, int part) {
		return dao.search(accident, part);
	}
}
