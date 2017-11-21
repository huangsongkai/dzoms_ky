package com.dz.common.download;

import com.opensymphony.xwork2.ActionSupport;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

/**
 * @author doggy
 *         Created on 16-4-13.
 */
@Controller("fileDownloadAction")
@Scope(value = "prototype")
public class FileDownLoadAction extends ActionSupport{
    private String filePath;
    private String fileName;

    public InputStream getDownload(){
        if(filePath == null)
            return null;
        String path = System.getProperty("com.dz.root")+filePath;
        String[] xs = filePath.split("/");
        fileName = xs[xs.length - 1];
        InputStream ins = null;
        try{
            File f = new File(path);
            ins = new FileInputStream(f);
        }catch (Exception e){
            e.printStackTrace();
        }
        return ins;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    @Override
    public String execute() throws Exception {
        return SUCCESS;
    }
}
