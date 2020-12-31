package com.wang.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.*;

import com.wang.db.DBManager;

import java.sql.*;

@WebServlet(urlPatterns = "/YudingAction")
public class YudingAction extends HttpServlet {
 
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		String id = request.getParameter("id");

//		String info=request.getParameter("info");
//		String qu=request.getParameter("qu");
//		String chepai=request.getParameter("chepai");
		//预订车位
		int uid = Integer.parseInt((String) request.getSession().getAttribute(
				"uid"));
		int hours=0;

		DBManager dbm = new DBManager();
		String hao = dbm.getChe(uid);

		if (hao != null) {
			if (dbm.isDing(hao) != null) {
				out
						.println("<script>alert('你的车已经停在车位上！');window.location.href='chewei/tlist.jsp'</script>");
			} else {
				java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//				String hour= JOptionPane.showInputDialog("请输入预定时长");
//				if(hour==""){
//					hours=0;
//				}else{
//					hours=Integer.valueOf(hour);
//				}

				request.getSession().setAttribute("YudingHours",new java.util.Date().getTime());
				String sql = "update chewei set chepai='" + hao + "',adate='"
						+ format.format(new java.util.Date()) + "' where id="
						+ id;


				System.out.println(sql);
				Statement stat = null;
				Connection conn = null;
				try {
					conn = dbm.getConnection();
					stat = conn.createStatement();
					stat.execute(sql);
					String sql2="select * from chewei where id="+id;
					ResultSet rs=stat.executeQuery(sql2);
					rs.next();
					String sql1 = "insert into yuding(hao,info,qu,chepai,hours,adate) values('"+rs.getString("hao")+"','"+rs.getString("info")+"','"+rs.getString("qu")+"','"+rs.getString("chepai")+"','"+hours+"','"+format.format(new java.util.Date())+"')";
					stat.execute(sql1);
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
				out.println("<script>alert('预订成功！');window.location.href='chewei/tlist.jsp'</script>");

			}

		} else {
			out.println("<script>alert('请添加车辆信息！');window.location.href='chewei/tlist.jsp'</script>");
		}

		
		out.flush();
		out.close();
	}
 
}
