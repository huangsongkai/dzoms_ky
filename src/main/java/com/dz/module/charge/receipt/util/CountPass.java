package com.dz.module.charge.receipt.util;

/**
 * @author doggy
 *         Created on 16-3-6.
 */
public class CountPass {
    private String prefix;
    private  int start;
    private  int end;
    private int number;
    public CountPass(int start,int end,String prefix){
        this.start = start;
        this.end =  end;
        this.prefix = prefix;
        this.number = (end - start+1)/100;
    }

    public int getStart() {
        return start;
    }

    public int getEnd() {
        return end;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

	public void setStart(int start) {
		this.start = start;
		this.number = (end - start+1)/100;
	}

	public void setEnd(int end) {
		this.end = end;
		this.number = (end - start+1)/100;
	}

    public String getPrefix() {
        return prefix;
    }

    public void setPrefix(String prefix) {
        this.prefix = prefix;
    }
}
