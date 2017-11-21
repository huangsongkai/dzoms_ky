package com.dz.common.global;

public class Page {
	//分页
	private int everyPage;//每页的记录条数
	private int totalCount;//总条数
	private int totalPage;//总页数
	private int currentPage;//当前页码
	private int beginIndex;//当页开始索引
	private boolean hasPrePage;//是否有前一页
	private boolean hasNexPage;//是否有后一页

	public Page(){}

	public Page(int everyPage, int totalCount, int totalPage, int currentPage,
				int beginIndex, boolean hasPrePage, boolean hasNexPage) {
		this.everyPage = everyPage;
		this.totalCount = totalCount;
		this.totalPage = totalPage;
		this.currentPage = currentPage;
		this.beginIndex = beginIndex;
		this.hasPrePage = hasPrePage;
		this.hasNexPage = hasNexPage;
	}

	public int getEveryPage() {
		return everyPage;
	}

	public void setEveryPage(int everyPage) {
		this.everyPage = everyPage;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getBeginIndex() {
		return beginIndex;
	}

	public void setBeginIndex(int beginIndex) {
		this.beginIndex = beginIndex;
	}

	public boolean isHasPrePage() {
		return hasPrePage;
	}

	public void setHasPrePage(boolean hasPrePage) {
		this.hasPrePage = hasPrePage;
	}

	public boolean isHasNexPage() {
		return hasNexPage;
	}

	public void setHasNexPage(boolean hasNexPage) {
		this.hasNexPage = hasNexPage;
	}


}
