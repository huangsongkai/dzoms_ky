package com.dz.kaiying.util;

import java.util.List;

/**
 * Created by song on 16/9/21.
 */
public class PageDecorator<E> {
    int pageSize = PageUtil.PAGE_SIZE;
    int totalPage;
    int currentPage;
    List<E> data;

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
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

    public List<E> getData() {
        return data;
    }

    public void setData(List<E> data) {
        this.data = data;
    }
}
