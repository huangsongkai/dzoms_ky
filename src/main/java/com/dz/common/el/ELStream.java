package com.dz.common.el;

import com.opensymphony.xwork2.inject.util.Function;
import org.javatuples.Pair;

import java.io.FilterInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PushbackInputStream;
import java.util.Map;

public class ELStream {
    public ELStream(InputStream in) {
        this.inputStream = in;
    }

    private InputStream inputStream;
    private int state;

    public String transfer() throws IOException {
        init();

        do{
            int ch = inputStream.read();
            if (ch >= 0) {
                accept((char)ch);
            }else {
                break;
            }
        }while (true);

        return builder.toString();
    }

    private void accept(char ch) {

    }

    static Map<Integer,Map<Character,Pair<Integer,Function>>> transferMap;

    private void init(){
        state=0;
        builder = new StringBuilder();
        buffer = new StringBuilder();
    }

    private StringBuilder builder;
    private StringBuilder buffer;
}
