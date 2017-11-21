package com.dz.common.other;


import com.dz.common.global.Page;

public class PageUtil {
	public static final int PAGE_SIZE = 15;

	public static Page createPage(int everyPage, int totalCount, int currentPage) {
		everyPage = getEveryPage(everyPage);
		
		int totalPage = getTotalPage(everyPage, totalCount);
		currentPage = totalPage<getCurrentPage(currentPage)?totalPage:getCurrentPage(currentPage);
		
		
		int beginIndex = getBeginIndex(everyPage, currentPage);
		boolean hasPrePage = getHasPrePage(currentPage);
		boolean hasNexPage = getHasNexPage(totalPage, currentPage);
		return new Page(everyPage, totalCount, totalPage, currentPage,beginIndex, hasPrePage, hasNexPage);

	}


	public static int getEveryPage(int everyPage) {
		// 获得每页记录条数
		return everyPage == 0 ? 5 : everyPage;
	}

	// 获得当前页码
	public static int getCurrentPage(int currentPage) {
		return currentPage == 0 ? 1 : currentPage;
	}

	// 获得总页数
	public static int getTotalPage(int everyPage, int totalCount) {
		int totalPage = 0;
		if (totalCount != 0 && totalCount % everyPage == 0) {
			totalPage = totalCount / everyPage;
		} else {
			totalPage = totalCount / everyPage + 1;
		}
		return totalPage;
	}

	// 获得当页开始索引
	public static int getBeginIndex(int everyPage, int currentPage) {
		return (currentPage - 1) * everyPage;
	}

	// 获得是否有前一页
	public static boolean getHasPrePage(int currentPage) {
		return currentPage == 1 ? false : true;
	}

	// 获得是否有后一页
	public static boolean getHasNexPage(int totalPage, int currentPage) {
		return currentPage == totalPage || totalPage == 0 ? false : true;
	}
}
