package com.dz.kaiying.util;

import com.dz.kaiying.DTO.DriverKpToExcelDTO;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ExportExcelUtil {

	/**
	 * 描述：根据文件路径获取项目中的文件
	 * @param fileDir 文件路径
	 * @return
	 * @throws Exception
	 */
	public  File getExcelDemoFile(String fileDir) throws Exception{
		String classDir = null;
		String fileBaseDir = null;
		File file = null;
		classDir = Thread.currentThread().getContextClassLoader().getResource("/").getPath();
		fileBaseDir = classDir.substring(0, classDir.lastIndexOf("classes"));

		file = new File(fileBaseDir+fileDir);
		if(!file.exists()){
			throw new Exception("模板文件不存在！");
		}
		return file;
	}
	/**
	 *@param driverKps 导出Excel定义的DTO
	 *@param mExcelName 下载后文件名
	 *
	 */
	public void getExcel(List<DriverKpToExcelDTO> driverKps, HttpServletResponse response, String mExcelName)throws Exception{
		ExportExcelUtil util = new ExportExcelUtil();
		File file = util.getExcelDemoFile("classes/ExcelDemo/大众模板.xlsx");
		FileInputStream fis = new FileInputStream(file);
		Workbook workbook = new ImportExcelUtil().getWorkbook(fis, file.getName());    //获取工作薄
		Sheet sheet =  workbook.getSheet("Sheet1");
		for (int row = 0; row < driverKps.size(); row++){
			DriverKpToExcelDTO driverKp=driverKps.get(row);
			Map<Integer,String> map=getKeyAndInteger(driverKp);
			Map<String, Object> objDTO=getKeyAndValue(driverKp);
			Row rows=sheet.createRow(row+3);
			for (int col = 0; col < map.size(); col++){
				String key=map.get(col);//getFieldValue(driverKp,col);
				if(driverKp!=null && key != "")
					rows.createCell(col).setCellValue(objDTO.get(key).toString());
				else
					rows.createCell(col).setCellValue("");
			}
		}
		ByteArrayOutputStream os = new ByteArrayOutputStream();
		BufferedInputStream bis=null;
		BufferedOutputStream bos=null;
		try {
			workbook.write(os);
			byte[] bytes = os.toByteArray();
			InputStream is = new ByteArrayInputStream(bytes);
			response.reset();
			response.setContentType("application/vnd.ms-excel;charset=utf-8");
			response.setHeader("Content-Disposition", new String(("attachment;filename="+mExcelName+".xls").getBytes("UTF-8"), "UTF-8"));
			ServletOutputStream out = response.getOutputStream();
			bis=new BufferedInputStream(is);
			bos=new BufferedOutputStream(out);
			byte[] buff = new byte[1024];
			int lengthByte=-1;
			while ((lengthByte=bis.read(buff,0,buff.length))!=-1){
				bos.write(buff,0,lengthByte);
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}finally {
			if (bis!=null) {
				try {
					bis.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if (bos!=null) {
				try {
					bos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}

	/**
	 *获取实体类中属性的个数
	 */
	public int getClassFields(Object obj){
		if (obj != null){
			Class<?> cal=obj.getClass();
			Field[] fields = cal.getDeclaredFields();
			return fields.length;
		}
		return 0;
	}

	/**
	 * 将对象放入Map
	 * @param obj
	 * @return
	 */
	public Map<Integer,String> getKeyAndInteger(DriverKpToExcelDTO obj) {
		Map<Integer,String> map = new HashMap<Integer,String>();
		Class userCla = (Class) obj.getClass();
		Field[] fs = userCla.getDeclaredFields();
		for (int i = 0; i < fs.length; i++) {
			Field f = fs[i];
			f.setAccessible(true);
			//Object val = new Object();
			try {
				//val = i;
				// 得到此属性的值
				map.put( i,f.getName());// 设置键值
				f.setAccessible(false);
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			}
		}
		return map;
	}

	/**
	 * 将对象放入Map
	 * @param obj
	 * @return
	 */
	public Map<String, Object> getKeyAndValue(DriverKpToExcelDTO obj) {
		Map<String, Object> map = new HashMap<String, Object>();
		Class userCla = (Class) obj.getClass();
		Field[] fs = userCla.getDeclaredFields();
		for (int i = 0; i < fs.length; i++) {
			Field f = fs[i];
			f.setAccessible(true);
			Object val = new Object();
			try {
				val = f.get(obj);
				// 得到此属性的值
				map.put(f.getName(), val);// 设置键值
				f.setAccessible(false);
			} catch (IllegalArgumentException e) {
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				e.printStackTrace();
			}
		}
		return map;
	}

	/**
	 *获取属性名
	 */
	/*public String getFieldValue(DriverKpDTO driverKp, int n){
		if (driverKp != null){
			Field[] fields = driverKp.getClass().getFields();
			String str=fields[n].getName();
			return str;
		}
		return "";
	}*/

}


