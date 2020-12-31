package com.wang.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.wang.db.DBManager;
import com.wang.user.users;

@WebServlet(urlPatterns = "/LoginAction")
public class LoginAction extends HttpServlet {
 
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {


		PrintWriter out = response.getWriter();
		this.doPost(request, response);
		out.close();
	}

	 
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		String username = request.getParameter("username");
		String userpwd = request.getParameter("userpwd");
		String type = request.getParameter("type");
		users us=new users(username,userpwd);
		request.getSession().setAttribute("USER",us);
		DBManager dbm = new DBManager();
		
		//从数据库查询到停车场停车一小时的费用
		request.getSession().setAttribute("fei", dbm.getSF());
		String gender=dbm.checkGender(username,userpwd);
		request.getSession().setAttribute("SESSION_GENDER",gender);
		request.setAttribute("gender",gender);
		if (type.equals("用户")) {
			//返回用户编号
			int uid = dbm.loginYH(username, userpwd);

//			request.setAttribute("gender",gender);
			if (uid > 0) {
				request.getSession().setAttribute("user", username);
				request.getSession().setAttribute("uid", uid+"");
				request.getSession().setAttribute("type", "用户");
				response.sendRedirect("index.jsp");

			} else {
				out
						.println("<script>alert('用户名或密码有误！');window.location.href='login.jsp'</script>");
			}

		} else if (type.equals("管理员")) {
			boolean login = dbm.login(username, userpwd);
			if (login) {
				request.getSession().setAttribute("user", username);
				request.getSession().setAttribute("type", "管理员");
//				request.getSession().setAttribute("gender",gender);
				response.sendRedirect("index.jsp");

			} else {
				out.println("<script>alert('用户名或密码有误！');window.location.href='login.jsp'</script>");
			}
		} else {
			out.println("<script>alert('用户名或密码有误！');window.location.href='login.jsp'</script>");
		}

		out.flush();
		out.close();
	}
 

}
