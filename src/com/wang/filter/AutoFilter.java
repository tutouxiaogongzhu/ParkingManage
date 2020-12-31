package com.wang.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

//urlPatterns 过滤器拦截的url
@WebFilter(
        urlPatterns = { "/admin/list.jsp","/userinfo/list.jsp","/chewei/list.jsp","/fei/modFei.jsp","/chewei/jflist.jsp","/chewei/cwlist.jsp","/cfei/list.jsp","/userinfo/myUserinfo.jsp","/che/list.jsp","/userinfo/myUserinfo.jsp","/userinfo/getCard.jsp","/fei/viewFei.jsp","/chewei/tlist.jsp","/yuyue/lslist.jsp" },
        initParams = { @WebInitParam(name = "login", value = "login.jsp"),
                @WebInitParam(name="register",value = "regUserinfo.jsp")},
        dispatcherTypes = { DispatcherType.REQUEST, DispatcherType.FORWARD })//配置拦截的类型，可配置多个,FORWARD转发的, INCLUDE包含在页面的,REQUEST请求的,
public class AutoFilter implements Filter {
    private String login = "login.jsp";
    public AutoFilter() {

    }
    public void destroy() {
        this.login = null;
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
    //业务逻辑
        HttpServletRequest reque = (HttpServletRequest) req;
        HttpServletResponse respo = (HttpServletResponse) resp;
        HttpSession session = reque.getSession();
        // 判断被拦截的请求用户是否处于登录状态
        if (session.getAttribute("USER") == null) {
            // 获取被拦截的请求地址及参数
            String requestPath = reque.getRequestURI();
            if (reque.getQueryString() != null) {
                requestPath += "?" + reque.getQueryString();
            }
            // 将请求地址保存到request对象中转发到登录页面
            req.setAttribute("requestPath", requestPath);
            req.getRequestDispatcher( "/" + login)
                    .forward(req, resp);
            return;
        } else {
            //将当前拦截的请求放行，让请求继续访问他要访问的资源
            chain.doFilter(req, resp);
        }

    }

    public void init(FilterConfig config) throws ServletException {
        // 获取当请求被拦截时转向的页面
        login = config.getInitParameter("loginPage");
        if (null == login) {
            login = "login.jsp";
        }
    }

}
