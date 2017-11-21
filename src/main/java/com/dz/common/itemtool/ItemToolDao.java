package com.dz.common.itemtool;

import java.util.List;

public interface ItemToolDao {
	void addItem(ItemTool it);
	void removeItem(ItemTool it);
	void changeItem(ItemTool newIt);
	List<ItemTool> selectByKey(ItemTool it);
	List<ItemTool> selectByKeyValue(ItemTool it);
}
