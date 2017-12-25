package com.dz.module.vehicle.electric;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.Serializable;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.jxls.area.Area;
import org.jxls.builder.AreaBuilder;
import org.jxls.builder.xls.XlsCommentAreaBuilder;
import org.jxls.common.CellRef;
import org.jxls.common.Context;
import org.jxls.expression.JexlExpressionEvaluator;
import org.jxls.formula.FastFormulaProcessor;
import org.jxls.transform.Transformer;
import org.jxls.util.TransformerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import com.dz.common.factory.HibernateSessionFactory;
import com.dz.common.other.ObjectAccess;
import com.dz.common.other.ExcelOutputUtil.MyELFunctionExtend;

@Service
public class ElectricAnaylseService {

	public static void main(String[] args) {
		ApplicationContext applicationContext = new ClassPathXmlApplicationContext("applicationContext.xml");
		ElectricAnaylseService service = applicationContext.getBean(ElectricAnaylseService.class);
		
		//service.createAnaylse(new Date(116,6,20), new Date());
		System.setProperty("com.dz.root","D:\\Code\\WorkSpaces\\git\\DZOMS\\WebRoot\\");
		service.geneXls(3);
		
	}
	
	public int createAnaylse(Date beginDate,Date endDate){
		Session session = HibernateSessionFactory.getSession();
		Transaction tx = null;
		int ea_id=0;
		try{
			tx=session.beginTransaction();
			
			ElectricAnaylse ea=new ElectricAnaylse();	
			
			Query query = session.createQuery(
					"select count(*),sum(cast(money as integer)) "
					+ "from ElectricHistory "
					+ "where STR_TO_DATE(date,'%Y-%m-%d %H:%i:%s')>=:beginDate "
					+ "and STR_TO_DATE(date,'%Y-%m-%d %H:%i:%s')<=:endDate");
			
			Query query_dept = session.createQuery(
					"select count(*),sum(cast(money as integer)) "
					+ "from ElectricHistory "
					+ "where STR_TO_DATE(date,'%Y-%m-%d %H:%i:%s')>=:beginDate "
					+ "and STR_TO_DATE(date,'%Y-%m-%d %H:%i:%s')<=:endDate "
					+ "and carframeNum in (select carframeNum from Vehicle where dept=:dept)" );
			
			query.setDate("beginDate", beginDate);
			query.setDate("endDate", endDate);
			
			query_dept.setDate("beginDate", beginDate);
			query_dept.setDate("endDate", endDate);
			
			Object[] oarr = (Object[]) query.uniqueResult();
			
			ea.setBeginDate(beginDate);
			ea.setEndDate(endDate);
			ea.setAllTimes((int)(long)oarr[0]);
			ea.setAllMoney((long)oarr[1]);
			
			query_dept.setString("dept", "一部");
			oarr = (Object[]) query_dept.uniqueResult();
			ea.setTime1((int)(long)oarr[0]);
			ea.setMoney1((long)oarr[1]);
			
			query_dept.setString("dept", "二部");
			oarr = (Object[]) query_dept.uniqueResult();
			ea.setTime2((int)(long)oarr[0]);
			ea.setMoney2((long)oarr[1]);
			
			query_dept.setString("dept", "三部");
			oarr = (Object[]) query_dept.uniqueResult();
			ea.setTime3((int)(long)oarr[0]);
			ea.setMoney3((long)oarr[1]);
			session.save(ea);
			
//			System.out.println("ElectricAnaylseService.createAnaylse(),line 76,ElectricAnaylse:\t"+ea);
			ea_id = ea.getId();
			
			Query query_vehicle = session.createQuery(
					"insert into ElectricAnaylseVehicle(anaylseId,carframeNum,licenseNum,times,moneys) "
					+ "select "+ea.getId()+",carframeNum,licenseNum,cast(count(*) as integer),sum(cast(money as integer)) from ElectricHistory "
					+ "where STR_TO_DATE(date,'%Y-%m-%d %H:%i:%s')>=:beginDate "
					+ "and STR_TO_DATE(date,'%Y-%m-%d %H:%i:%s')<=:endDate "
					+ "group by carframeNum" );
			
			query_vehicle.setDate("beginDate", beginDate);
			query_vehicle.setDate("endDate", endDate);
			
			query_vehicle.executeUpdate();
			
			
			Query query_act = session.createQuery(
					"insert into ElectricAnaylseAct(anaylseId,act,times,moneys) "
					+ "select "+ea.getId()+",act,cast(count(*) as integer),sum(cast(money as integer)) from ElectricHistory "
					+ "where STR_TO_DATE(date,'%Y-%m-%d %H:%i:%s')>=:beginDate "
					+ "and STR_TO_DATE(date,'%Y-%m-%d %H:%i:%s')<=:endDate "
					+ "group by act" );
			
			query_act.setDate("beginDate", beginDate);
			query_act.setDate("endDate", endDate);
			
			query_act.executeUpdate();
			
			
			Query query_act_area = session.createQuery(
					"insert into ElectricAnaylseActArea(anaylseActId,area,times) "
					+ "select eaa.id,eh.area,cast(count(*) as integer) "
					+ "from ElectricHistory eh,ElectricAnaylseAct eaa "
					+ "where eaa.anaylseId=:aid "
					+ "and eaa.act=eh.act "
					+ "and STR_TO_DATE(eh.date,'%Y-%m-%d %H:%i:%s')>=:beginDate "
					+ "and STR_TO_DATE(eh.date,'%Y-%m-%d %H:%i:%s')<=:endDate "
					+ "group by eh.act,eh.area" );
			
			query_act_area.setInteger("aid", ea.getId());
			query_act_area.setDate("beginDate", beginDate);
			query_act_area.setDate("endDate", endDate);
			
			query_act_area.executeUpdate();
			
			tx.commit();
		}catch(HibernateException ex){
			if(tx!=null){
				tx.rollback();
			}
			ex.printStackTrace();
			return 0;
		}finally{
			HibernateSessionFactory.closeSession();
		}
		
		return ea_id;
	}

	public boolean geneXls(int anaylseId){
		ElectricAnaylse anaylse = ObjectAccess.getObject(ElectricAnaylse.class, anaylseId);
		List<ElectricAnaylseVehicle> anaylseVehicles = ObjectAccess.query(ElectricAnaylseVehicle.class, "anaylseId="+anaylseId+" order by times desc");
		List<ElectricAnaylseAct> anaylseActs = ObjectAccess.query(ElectricAnaylseAct.class, "anaylseId="+anaylseId+" order by times desc");
		Map<Integer,List<ElectricAnaylseActArea>> anaylseActAreaMap = new HashMap<Integer,List<ElectricAnaylseActArea>>();
		
		for (ElectricAnaylseAct electricAnaylseAct : anaylseActs) {
			List<ElectricAnaylseActArea> actAreas = ObjectAccess.query(ElectricAnaylseActArea.class, "anaylseActId="+electricAnaylseAct.getId()+" order by times desc");
			anaylseActAreaMap.put(electricAnaylseAct.getId(), actAreas);
		}
		
		String saveName = String.format("%tF到%tF违章分析结果.xls", anaylse.getBeginDate(),anaylse.getEndDate());
		
		try(InputStream is = new FileInputStream(System.getProperty("com.dz.root")+"vehicle/electric/anaylse.xls")) {
			File file = File.createTempFile("Electric", "xls");
			
			try (OutputStream os = new FileOutputStream(file)) {
	            Context context = new Context();
	            
	            context.putVar("electricAnaylse", anaylse);
	            context.putVar("anaylseVehicles", anaylseVehicles);
	            context.putVar("anaylseActs", anaylseActs);
	            context.putVar("anaylseActAreaMap", anaylseActAreaMap);
	            
	            System.out.println(context);
	            
	            AreaBuilder areaBuilder = new XlsCommentAreaBuilder();
	            
	            Transformer transformer = TransformerFactory.createTransformer(is, os);
	            JexlExpressionEvaluator evaluator = (JexlExpressionEvaluator) transformer.getTransformationConfig().getExpressionEvaluator();
	            Map<String, Object> functionMap = new HashMap<>();
	            functionMap.put("my", new MyELFunctionExtend());
	            evaluator.getJexlEngine().setFunctions(functionMap);
	           
	            areaBuilder.setTransformer(transformer);
	            List<Area> xlsAreaList = areaBuilder.build();
	            for (Area xlsArea : xlsAreaList) {
	                xlsArea.applyAt(
	                        new CellRef(xlsArea.getStartCellRef().getCellName()), context);
	                
	                setFormulaProcessor(xlsArea);
	                xlsArea.processFormulas();
	            }
	            transformer.write();
	            
	            //将 file 转存
	            FileUtils.copyFile(file, new File(System.getProperty("com.dz.root")+"data/electric/"+saveName));
	            //this.setExcelStream(new FileInputStream(file));
	        } catch (IOException e) {
				// TODO 自动生成的 catch 块
				e.printStackTrace();
				return false;
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		
		anaylse.setFilePath(saveName);
		ObjectAccess.saveOrUpdate(anaylse);
		
		return true;
	}
	
	private void setFormulaProcessor(Area xlsArea) {
	     xlsArea.setFormulaProcessor(new FastFormulaProcessor());
	    // xlsArea.setFormulaProcessor(new StandardFormulaProcessor());
	 }
}
