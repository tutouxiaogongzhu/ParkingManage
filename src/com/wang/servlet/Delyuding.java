package com.wang.servlet;

import com.wang.db.DBManager;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet(urlPatterns = "/Delyuding")
public class Delyuding extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        PrintWriter out = response.getWriter();
        this.doPost(request, response);
        out.close();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        String id = request.getParameter("id");

        DBManager dbm = new DBManager();
        //删除车辆
        String sql = "delete from yuding where id="+id;

        Statement stat = null;
        Connection conn = null;
        try {
            conn = dbm.getConnection();
            stat = conn.createStatement();
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
        out.println("<script>alert('删除成功！');window.location.href='yuyue/lslist.jsp'</script>");
//        response.sendRedirect("yuyue/lslist.jsp");
        out.flush();
        out.close();
}
}
