package com.dz.common.itemtool;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Transformer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dz.common.other.ObjectAccess;

import java.util.List;

@Service
public class ItemToolService {
	@Autowired
	ItemToolDao dao;
	public boolean addItem(ItemTool it){
		if(dao.selectByKeyValue(it).size() != 0){
			return false;
		}else{
			dao.addItem(it);
			return true;
		}
	}
	public boolean removeItem(ItemTool it){
		dao.removeItem(it);
		return true;
	}
	public boolean changeItem(ItemTool newItem){
		if(dao.selectByKeyValue(newItem).size() == 0){
			return false;
		}else{
			dao.changeItem(newItem);
			return true;
		}
	}
	public List<ItemTool> selectByKey(ItemTool it){
		return dao.selectByKey(it);
	}
	
	public static List<String> selectByKey(String key){
		List<ItemTool> l = ObjectAccess.query(ItemTool.class, "key='"+key+"'");
		return (List<String>) CollectionUtils.<String>collect(l, new Transformer() {
			@Override
			public Object transform(Object input) {
				ItemTool tool = (ItemTool) input;
				return tool.getValue();
			}
		});
	}
}
