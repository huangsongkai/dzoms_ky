package com.dz.common.global;

import java.util.List;
import java.util.Map;

import com.dz.module.user.Role;

public interface WaitToDo {
	public Map<String, List<ToDo>> waitToDo(Role role);
}
