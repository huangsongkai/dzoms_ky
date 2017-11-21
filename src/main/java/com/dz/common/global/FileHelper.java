package com.dz.common.global;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

/**
 * @author doggy
 *         Created on 16-3-25.
 */
public class FileHelper {
    public static boolean addFile(File file, String filePath, String fileName){
        try{
            File f = new File(System.getProperty("com.dz.root")+"/"+filePath);
            if(!f.exists())
                f.mkdirs();
            FileOutputStream fos = new FileOutputStream(System.getProperty("com.dz.root")+"/"+filePath+"/"+fileName);
            FileInputStream fis = new FileInputStream(file);
            byte[] bytes = new byte[200*1024];
            int length = fis.read(bytes);
            while(length >= 0){
                fos.write(bytes,0,length);
                length = fis.read(bytes);
            }
            file.delete();
            fis.close();
            fos.close();
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }
    public static boolean delete(String absolutePath){
        File f = new File(absolutePath);
        if(f.exists())
            f.delete();
        return true;
    }
}
