package com.dz.kaiying.util;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

/**
 * Created by huang on 2017/4/20.
 */
public class MVCFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest httpServletRequest = (HttpServletRequest)servletRequest;
        //跳过后面的过滤器，直接请求servlet
        servletRequest.getRequestDispatcher(httpServletRequest.getServletPath()
                + httpServletRequest.getPathInfo()).forward(servletRequest, servletResponse);
    }

    @Override
    public void destroy() {

    }
}
