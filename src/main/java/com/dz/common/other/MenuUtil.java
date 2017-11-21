package com.dz.common.other;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Predicate;

import com.dz.module.user.Authority;

public class MenuUtil {
	private static final class TreeMapCompare implements Comparator<String> {
		private final class MnamePredicate implements Predicate {
			private String mname;
			public MnamePredicate(String mname) {
				this.mname=mname;
			}

			@Override
			public boolean evaluate(Object arg0) {
				Authority a = (Authority) arg0;
				
				return a.getMname().equals(mname);
			}
		}

		List<Authority> lst;
		public TreeMapCompare(List<Authority> lst) {
			this.lst = lst;
		}

		@Override
		public int compare(String mname1, String mname2) {
			Authority m1 = (Authority) CollectionUtils.find(lst, new MnamePredicate(mname1));
			Authority m2 = (Authority) CollectionUtils.find(lst, new MnamePredicate(mname2));
			return m1.getOrder()-m2.getOrder();
		}
	}

	public static Map<String,List<Authority>> convert(List<Authority> lst){
		TreeMap<String,List<Authority>> map = new TreeMap<String,List<Authority>>(new TreeMapCompare(lst));
		if(lst != null)
		for(Authority a:lst){
			String key = a.getMname();
			if(!map.containsKey(key)){
				map.put(key, new ArrayList<Authority>());
			}
			
			map.get(key).add(a);
		}
		return map;
	}
}
