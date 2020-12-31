package com.wang.servlet;
import java.io.IOException;	
import java.io.PrintWriter;	
import java.sql.*;	
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;	
import javax.servlet.http.HttpServletResponse;

import com.wang.db.DBManager;
@WebServlet(urlPatterns = "/RegUserinfoAction")
public class RegUserinfoAction extends HttpServlet {
 
	private static final long serialVersionUID = 1L;
	 

	public void doPost(HttpServletRequest request, HttpServletResponse response)	
			throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		String name = request.getParameter("name");
		String pwd = request.getParameter("pwd");
		String age = request.getParameter("age");
		String tel = request.getParameter("tel");
		String gender = request.getParameter("gender");
		DBManager dbm = new DBManager();
		Integer count = dbm.selectUserNameCount(name);
		if (name != "" && pwd == "") {
			if (count > 0) {
				PrintWriter writer = response.getWriter();
				writer.write("true");
//			out.println("<script>window.location.href='login.jsp'</script>");
				writer.flush();
				writer.close();
			} else {
				PrintWriter writer = response.getWriter();
				writer.write("false");
				writer.flush();
				writer.close();
			}
		} else {
			//用户注册
			String sql = "insert into userinfo(name,pwd,age,tel,gender,jine) values('" + name + "','" + pwd + "','" + age + "','" + tel + "','" + gender + "','0')" ;

			Statement stat = null;
			Connection conn = null;
			try {
				conn = dbm.getConnection();
				stat = conn.createStatement();
				System.out.println(sql);
				stat.execute(sql);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				try {
					if (stat != null)
						stat.close();
					if (conn != null)
						conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			out.println("<script>alert('注册成功请登录！');window.location.href='login.jsp'</script>");
			out.flush();
			out.close();
		}
	}
 
}	
