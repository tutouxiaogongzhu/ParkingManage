package com.wang.Listen;

import com.wang.user.users;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.*;
import java.util.HashMap;
import java.util.Map;

@WebListener()
public class LoginListener implements ServletContextListener,
        HttpSessionListener, HttpSessionAttributeListener {

    // Public constructor is required by servlet spec
    public LoginListener() {
    }

    // -------------------------------------------------------
    // ServletContextListener implementation
    // -------------------------------------------------------
    public void contextInitialized(ServletContextEvent sce) {
      /* This method is called when the servlet context is
         initialized(when the Web application is deployed). 
         You can initialize servlet context related data here.
      */
    }

    public void contextDestroyed(ServletContextEvent sce) {
      /* This method is invoked when the Servlet Context 
         (the Web application) is undeployed or 
         Application Server shuts down.
      */
    }

    // -------------------------------------------------------
    // HttpSessionListener implementation
    // -------------------------------------------------------
    public void sessionCreated(HttpSessionEvent se) {
        //session创建后调用
        System.out.println("sessionCreated");
        //统计信息ServletContext
        ServletContext context=se.getSession().getServletContext();

        //人数,servletContext中取
        Integer count=(Integer)context.getAttribute("count");
        if(count==null){
            count=0;
        }else{
            count++;
        }
        context.setAttribute("count",count);
    }

    public void sessionDestroyed(HttpSessionEvent se) {
        //session销毁调用
        System.out.println("sessionDestroyed");
        //
        ServletContext context=se.getSession().getServletContext();
        Integer count=(Integer)context.getAttribute("count");
        count--;
        context.setAttribute("count",count);
    }

    // -------------------------------------------------------
    // HttpSessionAttributeListener implementation
    // -------------------------------------------------------

    public void attributeAdded(HttpSessionBindingEvent sbe) {
        //当属性添加之后触发
        //将用户信息保存到servletContext中
        String attrName=sbe.getName();//添加的属性名 username

        if(attrName.equals("username")){
            String username=(String)sbe.getValue(); //获取添加的属性值
            //将用户信息保存
            users user=new users(username);
            HttpSession session=sbe.getSession();
            ServletContext context=session.getServletContext();
            Map<String,users> userMap=(Map<String,users>)context.getAttribute("users");
            if(userMap==null){
                userMap=new HashMap<String, users>();
            }
            userMap.put(session.getId(),user);
            context.setAttribute("users",userMap);
        }
    }

    public void attributeRemoved(HttpSessionBindingEvent sbe) {
        //当属性删除之后触发
        //将用户信息保存到servletContext中
        String attrName=sbe.getName();//添加的属性名 username

        if(attrName.equals("username")){
            HttpSession session=sbe.getSession();
            ServletContext context=session.getServletContext();
            Map<String,users> userMap=(Map<String,users>)context.getAttribute("users");

            userMap.remove(session.getId());
            context.setAttribute("users",userMap);
        }
    }

    public void attributeReplaced(HttpSessionBindingEvent sbe) {
      /* This method is invoked when an attribute
         is replaced in a session.
      */
    }
}
