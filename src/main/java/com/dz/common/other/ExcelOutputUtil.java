package com.dz.common.other;

import com.dz.common.global.BaseAction;
import net.sf.json.JSONObject;
import org.apache.commons.beanutils.MethodUtils;
import org.apache.commons.beanutils.PropertyUtils;
import org.apache.commons.lang3.ClassUtils;
import org.apache.commons.lang3.StringUtils;
import org.jxls.area.Area;
import org.jxls.builder.AreaBuilder;
import org.jxls.builder.xls.XlsCommentAreaBuilder;
import org.jxls.common.CellRef;
import org.jxls.common.Context;
import org.jxls.expression.ExpressionEvaluator;
import org.jxls.expression.JexlExpressionEvaluator;
import org.jxls.formula.FastFormulaProcessor;
import org.jxls.transform.TransformationConfig;
import org.jxls.transform.Transformer;
import org.jxls.util.TransformerFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import java.io.*;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;
import java.util.*;

@Controller
@Scope("prototype")
public class ExcelOutputUtil extends BaseAction {
	private List datalist;
	private List<String> datasrc;
	private String templatePath;
	private InputStream excelStream;
	private String outputName;
	
	public String export(){
		if(datasrc==null||datasrc.size()==0){
			datasrc=(List<String>) request.getAttribute("datasrc");
		}
		
		if(datalist==null||datalist.size()==0){
			datalist=(List) request.getAttribute("datalist");
		}
		
		if(StringUtils.isBlank(outputName)){
			outputName = (String) request.getAttribute("outputName");
		}
		
		if(StringUtils.isBlank(templatePath)){
			templatePath = (String) request.getAttribute("templatePath");
		}
		
		try(InputStream is = new FileInputStream(System.getProperty("com.dz.root")+"/"+templatePath)) {
			File file = File.createTempFile(outputName, "xls");
	        
			try (OutputStream os = new FileOutputStream(file)) {
	            Context context = new Context();
	            
//	            System.out.println(datasrc);
//	            System.out.println(datalist);
	            for (int i = 0; i < datasrc.size(); i++) {
	            	context.putVar(datasrc.get(i), datalist.get(i));
				}
//	            System.out.println(context);
	            
	            AreaBuilder areaBuilder = new XlsCommentAreaBuilder();

	            Transformer transformer = TransformerFactory.createTransformer(is, os);
	            if (transformer==null){
					System.out.println("Cannot create the Transformer.");
					return ERROR;
				}
				TransformationConfig config = transformer.getTransformationConfig();
				ExpressionEvaluator expressionEvaluator = config.getExpressionEvaluator();
	            JexlExpressionEvaluator evaluator = (JexlExpressionEvaluator) expressionEvaluator;
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
	            
	            this.setExcelStream(new FileInputStream(file));
	            
	            this.outputName = new String(outputName.getBytes(),"iso8859-1");
	        } catch (IOException e) {
				e.printStackTrace();
			}
		} catch (FileNotFoundException e1) {
			e1.printStackTrace();
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		return SUCCESS;
	}

//	public static Transformer createTransformer(InputStream inputStream, OutputStream outputStream) {
//		Class transformer = null;
//		try {
//			transformer = Class.forName("org.jxls.transform.jexcel.JexcelTransformer");
//		} catch (ClassNotFoundException e) {
//			e.printStackTrace();
//		}
//		if (transformer == null) {
//			System.err.println("Cannot load any Transformer class. Please make sure you have necessary libraries in CLASSPATH.");
//			return null;
//		} else {
//			System.out.println("Transformer class is " + transformer.getName());
//
//			try {
//				Method initMethod = transformer.getMethod("createTransformer", InputStream.class, OutputStream.class);
//				return (Transformer)initMethod.invoke((Object)null, inputStream, outputStream);
//			} catch (NoSuchMethodException var4) {
//				System.err.println("The specified public method createTransformer does not exist in " + transformer.getName());
//				return null;
//			} catch (InvocationTargetException var5) {
//				System.err.println("Method createTransformer of " + transformer.getName() + " class thrown an Exception"+ var5.getCause());
//				return null;
//			} catch (IllegalAccessException var6) {
//				System.err.println("Method createTransformer of " + transformer.getName() + " is inaccessible"+ var6.getCause());
//				return null;
//			} catch (RuntimeException var7) {
//				System.err.println("Failed to execute method createTransformer of " + transformer.getName()+ var7.getCause());
//				return null;
//			}
//		}
//	}
	
	 private void setFormulaProcessor(Area xlsArea) {
	     xlsArea.setFormulaProcessor(new FastFormulaProcessor());
	    // xlsArea.setFormulaProcessor(new StandardFormulaProcessor());
	 }

	public List getDatalist() {
		return datalist;
	}

	public void setDatalist(List datalist) {
		this.datalist = datalist;
	}

	public List<String> getDatasrc() {
		return datasrc;
	}

	public void setDatasrc(List<String> datasrc) {
		this.datasrc = datasrc;
	}

	public String getTemplatePath() {
		return templatePath;
	}

	public void setTemplatePath(String templatePath) {
		this.templatePath = templatePath;
	}

	public InputStream getExcelStream() {
		return excelStream;
	}

	public void setExcelStream(InputStream excelStream) {
		this.excelStream = excelStream;
	}

	public String getOutputName() {
		return outputName;
	}

	public void setOutputName(String outputName) {
		this.outputName = outputName;
	}

	public static class MyELFunctionExtend{
		public Object getObject(String classname,Serializable id){
			return ObjectAccess.getObject(classname, id);
		}
		public Object queryObject(String ql){
			return ObjectAccess.execute(ql);
		}

		private int seq=0;
		private Map<String,List<Number>> map = new HashMap<>();

		public int initSeq(){
			seq=0;
			return seq;
		}

		public int geneSeq(int step){
			seq+=step;
			return seq;
		}

		public Number group(String key,Number val){
			return group(key, val,2);
		}

		public Number group(String key,Number val,int scale){
			if(!map.containsKey(key)){
				map.put(key, new ArrayList<>());
			}

			map.get(key).add(val);
			if (val instanceof BigDecimal){
				((BigDecimal) val).setScale(scale, BigDecimal.ROUND_HALF_UP);
			}

			return Double.parseDouble(String.format("%."+scale+"f", val.doubleValue()));
		}

		public Number sum(String key){
			return sum(key,2);
		}

		public Number sum(String key,int scale){
			BigDecimal sum = BigDecimal.ZERO;
			sum.setScale(scale+2, BigDecimal.ROUND_HALF_UP);

			for (Number val : map.get(key)) {
				sum = sum.add(BigDecimal.valueOf(val.doubleValue()));
			}

			sum.setScale(scale, BigDecimal.ROUND_HALF_UP);
			return Double.parseDouble(String.format("%."+scale+"f", sum.doubleValue()));
		}


		private Map<String,Object> dict = new HashMap<>();

		public MyELFunctionExtend mapTo(String key,Object value){
			dict.put(key, value);
			return this;
		}

		public Object mapOf(String key){
			return dict.get(key);
		}

		public Object ifelse(boolean b, Object o1, Object o2) {
			return b ? o1 : o2;
		}

		public String getValueOfJson(String jsonStr,String key){
			JSONObject json = JSONObject.fromObject(jsonStr);
			return json.getString(key);
		}

		private Map<String,Object> keyMap= new HashMap<>();
		public Object setAsValue(String name,Object setValue,Object showValue){
			keyMap.put(name,setValue);
			return showValue;
		}
		public Object getAsValue(String name){
			return keyMap.get(name);
		}

		/**
		 * List映射功能  List<E> -->  List<T>  T = E.propertyPath
		 * @param list  原List
		 * @param propertyPath 属性路径，可多级  如p1  p1.x 等
         * @return
         */
		public List mapGet(List list,String propertyPath){
			List resultList = new ArrayList();
			for (Object o:list) {
				try {
					Object res = PropertyUtils.getProperty(o,propertyPath);
					resultList.add(res);
				} catch (IllegalAccessException | InvocationTargetException | NoSuchMethodException e) {
					e.printStackTrace();
					resultList.add(null);
				}
			}
			return resultList;
		}

		/**
		 * 提供Excel导出静态方法调用
		 * @param className 类名
		 * @param method 函数名
		 * @param args 参数列表
         * @param argTypes 参数类型 对于基础数组请自行输出测试 引用类型数组使用 [L类名;
		 * 示例：  int[] -- [I    int[][]  --  [[I   String[]  --  [Ljava.lang.String;
         * @return
         */
		public Object staticCall(String className,String method,Object[] args,String[] argTypes){
			try {
				Class[] classes = new Class[argTypes.length];
				for (int i = 0; i < argTypes.length ; i++) {
					switch (argTypes[i]){
						case "int":
							classes[i] = int.class;
							break;
						case "long":
							classes[i] = long.class;
							break;
						case "short":
							classes[i] = short.class;
							break;
						case "float":
							classes[i] = float.class;
							break;
						case "double":
							classes[i] = double.class;
							break;
						case "char":
							classes[i] = char.class;
							break;
						case "byte":
							classes[i] = byte.class;
							break;
						case "boolean":
							classes[i] = boolean.class;
							break;
						default:
							classes[i] = ClassUtils.getClass(argTypes[i]);
					}
				}
				return MethodUtils.invokeExactStaticMethod(ClassUtils.getClass(className),method,args,classes);
			} catch (NoSuchMethodException | IllegalAccessException | InvocationTargetException | ClassNotFoundException e) {
				e.printStackTrace();
			}
			return null;
		}

	}

	public static void main(String[] args) throws IllegalAccessException, NoSuchMethodException, InvocationTargetException, ClassNotFoundException {
//		BankCardOfVehicle bov = new BankCardOfVehicle();
//		bov.setBankCard(new BankCard());
//		bov.getBankCard().setCardClass("asc");
//
//		System.out.println( PropertyUtils.getProperty(bov,"bankCard.cardClass"));
		MyELFunctionExtend extend = new MyELFunctionExtend();
//		System.out.println(Class.forName("[I").isInstance(new int[]{123}));
//		System.out.println(Class.forName("[Ljava.lang.Object;"));
		System.out.println(extend.staticCall("org.apache.commons.lang3.StringUtils","join",
				new Object[]{Arrays.asList(1,2,3).toArray(),","},
				new String[]{"[Ljava.lang.Object;","java.lang.String"}));
	}
}
