package com.dz.common.other;

import com.dz.common.tablelist.ListValue;
import com.dz.common.tablelist.TableList;
import com.dz.common.tablelist.TableListService;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;
import java.util.logging.ConsoleHandler;
import java.util.logging.Level;
import java.util.logging.Logger;

@Service
public class FileAccessUtil {
	@Autowired
	private TableListService tableListService;
	
	public void setTableListService(TableListService tableListService) {
		this.tableListService = tableListService;
	}
	
	/***
	 * 存储文件列表
	 * @param basePath 基地址
	 * @param files 文件对象列表
	 * @param filenames 文件名列表
	 * @return 文件列表指针
	 * @throws IOException
	 */
	public int store(String basePath,File[] files,String[] filenames) throws IOException{
		int fileListNumber;
		
		TableList tl = new TableList();
		tl.setName(basePath);
		tableListService.addTableList(tl);
		fileListNumber = tl.getId();
		
		ListValue root = tableListService.getRoot(tl);
		
		File baseFile = new File(basePath);
		if(!baseFile.exists()){
			baseFile.mkdirs();
		}
		
		if(files!=null)
		for(int i=0;i<files.length;i++){
			int id = tableListService.addSubItem(root, new ListValue(filenames[i],null,null));
			FileUtils.copyFile(files[i], new File(baseFile,""+id));
		}
		
		return fileListNumber;
	}
	/**
	 * 删除文件列表中的某几个文件
	 * @param fileListNumber
	 * @param filenames
	 * @throws IOException
	 */
	public void remove(int fileListNumber,String... filenames) throws IOException {
		TableList tl = tableListService.getById(fileListNumber);
		ListValue root = tableListService.getRoot(tl);
		String basePath = root.getValue();
		List<ListValue> flist = tableListService.getChildren(root);
		for(ListValue lv:flist){
			if(ArrayUtils.contains(filenames, lv.getValue())){
				File file = new File(basePath,""+lv.getId());
				file.delete();
				tableListService.deleteItem(lv);
			}
		}
	}
	/**
	 * 向文件列表中增加文件
	 * @param fileListNumber
	 * @param files
	 * @param filenames
	 * @throws IOException
	 */
	public void addMoreFile(int fileListNumber,File[] files,String[] filenames) throws IOException{
		TableList tl = tableListService.getById(fileListNumber);
		ListValue root = tableListService.getRoot(tl);
		String basePath = root.getValue();
		File baseFile = new File(basePath);
		if(!baseFile.exists()){
			baseFile.mkdirs();
		}
		
		for(int i=0;i<files.length;i++){
			int id = tableListService.addSubItem(root, new ListValue(filenames[i],null,null));
			FileUtils.copyFile(files[i], new File(baseFile,""+id));
		}
	}
	/**
	 * 加载文件列表中的某个文件
	 * @param fileListNumber
	 * @param filename
	 * @return
	 * @throws FileNotFoundException
	 */
	public FileInputStream load(int fileListNumber,String filename) throws FileNotFoundException{
		
		TableList tl = tableListService.getById(fileListNumber);
		ListValue root = tableListService.getRoot(tl);
		String basePath = root.getValue();
		List<ListValue> flist = tableListService.getChildren(root);
		for(ListValue lv:flist){
			if(StringUtils.equals(filename, lv.getValue())){
				File file = new File(basePath,""+lv.getId());
				return new FileInputStream(file);
			}
		}
		
		return null;
	}
/**
 * 删除文件列表
 * @param fileListNumber
 */
	public void removeList(int fileListNumber){
		TableList tl = tableListService.getById(fileListNumber);
		ListValue root = tableListService.getRoot(tl);
		String basePath = root.getValue();
		
		List<ListValue> flist = tableListService.getChildren(root);
		for(ListValue lv:flist){
			File file = new File(basePath,""+lv.getId());
			file.delete();
			tableListService.deleteItem(lv);
		}
		
		tableListService.deleteItem(root);
		tableListService.deleteTableList(fileListNumber);
	}

	/**
	 * 存储单个文件
	 * @param basePath 基地址
	 * @param file 上传的文件对象
	 * @param filename 上传的文件名称
	 * @throws IOException
	 */
	public void store(String basePath,File file,String filename) throws IOException{
		File baseFile = new File(basePath);
		if(!baseFile.exists()){
			baseFile.mkdirs();
		}
		FileUtils.copyFile(file, new File(baseFile,filename));
	}
	/**
	 * 删除单个文件
	 * @param basePath 基地址
	 * @param filename 文件名称
	 */
	public void remove(String basePath,String filename){
		File file = new File(basePath,filename);
		if(file.isFile())
			file.delete();
		else{
			try {
				FileUtils.deleteDirectory(file);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	/**
	 * 加载单个文件
	 * @param basePath 基地址
	 * @param filename 文件名
	 * @return
	 * @throws FileNotFoundException
	 */
	public FileInputStream load(String basePath,String filename) throws FileNotFoundException{
		File file = new File(basePath,filename);
		return new FileInputStream(file);
	}
	
	public void store(String basePath,String listname,File[] files,String[] filenames) throws IOException{
		File baseFile = new File(basePath+"/"+listname);
		if(!baseFile.exists()){
			baseFile.mkdirs();
		}
		for(int i=0;i<files.length;i++){
			FileUtils.copyFile(files[i], new File(baseFile,filenames[i]));
		}
	}
	
	public static File[] list(String basePath){
		File baseFile = new File(basePath);
		if(!baseFile.exists()){
			return null;
		}
		
		return baseFile.listFiles();
	}
	
	public static boolean exist(String path){
		File file = new File(System.getProperty("com.dz.root")+path);
		return file.exists();
	}
}
