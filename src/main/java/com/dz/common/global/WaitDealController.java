package com.dz.common.global;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import com.dz.module.vehicle.VehicleApprovalService;
import net.sf.json.JSONObject;

import org.apache.commons.lang.BooleanUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.BeanDefinitionStoreException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ScannedGenericBeanDefinition;
import org.springframework.context.annotation.Scope;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.core.io.support.ResourcePatternResolver;
import org.springframework.core.type.classreading.CachingMetadataReaderFactory;
import org.springframework.core.type.classreading.MetadataReader;
import org.springframework.core.type.classreading.MetadataReaderFactory;
import org.springframework.stereotype.Controller;
import org.springframework.util.ClassUtils;

import com.dz.common.test.DataTrackFilter;
import com.dz.module.user.Role;
import com.opensymphony.xwork2.ActionContext;

@Controller
@Scope("prototype")
public class WaitDealController extends BaseAction {
	private ResourcePatternResolver resourcePatternResolver = new PathMatchingResourcePatternResolver();
	private MetadataReaderFactory metadataReaderFactory = new CachingMetadataReaderFactory(this.resourcePatternResolver);
	
	protected String resolveBasePackage(String basePackage) {	
		return ClassUtils.convertClassNameToResourcePath(DataTrackFilter.getCtx().getEnvironment().resolveRequiredPlaceholders(basePackage));
	}
	
	public List<String> findCandidateComponents(String basePackage) {
		List<String> waitList = new ArrayList<String>();
		try {
			String packageSearchPath = "classpath*:" +resolveBasePackage(basePackage) + "/" + "**/*.class";
			Resource[] resources = this.resourcePatternResolver.getResources(packageSearchPath);
			for (Resource resource : resources) {
				if (resource.isReadable()) {					
					try {
						
						MetadataReader metadataReader = this.metadataReaderFactory.getMetadataReader(resource);
						ScannedGenericBeanDefinition sbd = new ScannedGenericBeanDefinition(metadataReader);
								
						Class<?> clazz = Class.forName(sbd.getBeanClassName());
						WaitDeal waitDeal  = clazz.getAnnotation(WaitDeal.class);
						
						if(waitDeal != null){
							waitList.add(waitDeal.name());
						}
						
					}
					catch (Throwable ex) {
						throw new BeanDefinitionStoreException(
								"Failed to read candidate component class: " + resource, ex);
					}
				}	
			}
		}
		catch (IOException ex) {
			throw new BeanDefinitionStoreException("I/O failure during classpath scanning", ex);
		}
		return waitList;
	}
	
	private static List<String> waitBeanList = null;
	
	private String waitType;
	public void getWaitDeal() throws IOException{
		Map<String, List<ToDo>> map = getWaitDealMap();
		
		JSONObject json = JSONObject.fromObject(map.get(waitType));
		
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter pw = ServletActionContext.getResponse().getWriter();
		pw.print(json.toString());
		pw.flush();
		pw.close();
	}
	
	public void getWaitDealCount() throws IOException{
		Map<String, List<ToDo>> map = getWaitDealMap();
			
		ServletActionContext.getResponse().setContentType("application/json");
		ServletActionContext.getResponse().setCharacterEncoding("utf-8");
		PrintWriter pw = ServletActionContext.getResponse().getWriter();

		if(org.apache.commons.lang3.StringUtils.equals("开业审批",waitType)||org.apache.commons.lang3.StringUtils.equals("废业审批",waitType)){
			List<Role> roles = (List<Role>) session.getAttribute("roles");
			Map<String,List<ToDo>> map1 = new TreeMap<String,List<ToDo>>();

			for(Role role:roles){
				Map<String,List<ToDo>> tmp = vehicleApprovalService.waitToDo(role);
				for(String key:tmp.keySet()){
					if(map1.containsKey(key)){
						map1.get(key).addAll(tmp.get(key));
					}else{
						map1.put(key, tmp.get(key));
					}
				}
			}
			pw.print(map1.get(waitType).size());
		}else{
			pw.print(map.get(waitType).size());
		}

		pw.flush();
		pw.close();
	}

	/**
	 * @return
	 */
	public  Map<String, List<ToDo>> getWaitDealMap() {
		@SuppressWarnings("unchecked")
		Map<String, List<ToDo>> map = (Map<String, List<ToDo>>) ActionContext.getContext().getSession().get("waitDealMap");
		Boolean needRefresh = (Boolean) ActionContext.getContext().getSession().get("waitDealNeedRefresh");
		if(map!=null&&BooleanUtils.isFalse(needRefresh)){
			return map;
		}
		
		if(waitBeanList == null){
			waitBeanList = findCandidateComponents("com.dz.module");
		}
		
		@SuppressWarnings("unchecked")
		List<Role> roles = (List<Role>) ActionContext.getContext().getSession().get("roles");
		map = new TreeMap<String,List<ToDo>>();
		
		for(Role role:roles){
			for(String beanName:waitBeanList){
				WaitToDo waitToDo = (WaitToDo) DataTrackFilter.getCtx().getBean(beanName);
				Map<String,List<ToDo>> tmp = waitToDo.waitToDo(role);
				for(String key:tmp.keySet()){
					if(map.containsKey(key)){
						map.get(key).addAll(tmp.get(key));
					}else{
						map.put(key, tmp.get(key));
					}
				}
				//map.putAll(tmp);
			}
		}
		ActionContext.getContext().getSession().put("waitDealNeedRefresh", false);
		return map;
	}

	public String getWaitType() {
		return waitType;
	}

	public void setWaitType(String waitType) {
		this.waitType = waitType;
	}

	@Autowired
	private VehicleApprovalService vehicleApprovalService;

	public void setVehicleApprovalService(VehicleApprovalService vehicleApprovalService) {
		this.vehicleApprovalService = vehicleApprovalService;
	}
}
