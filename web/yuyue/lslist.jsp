<%@include file="/common/sub_header.jsp"%>
<%@ page language="java" import="java.util.*,java.sql.*,com.wang.db.*"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<link rel="stylesheet" type="text/css" href="css/common.css" />
		<link rel="stylesheet" type="text/css" href="css/main.css" />
		<script type="text/javascript" src="js/libs/modernizr.min.js">
</script>
	</head>
	<body>
		<jsp:include page="/top.jsp"></jsp:include>
		<jsp:include page="/left.jsp"></jsp:include>
		<!--/sidebar-->
		<div class="main-wrap">

			<div class="crumb-wrap">
				<div class="crumb-list">
					<span class="crumb-name">预约信息查看</span>
				</div>
			</div>
			<div class="search-wrap">
				<div class="search-content">
					<form action="<%=path%>/cfei/list.jsp" method="post">
						<table class="search-tab">
							<tr>

								
								
							</tr>
						</table>
					</form>
				</div>
			</div>
			<div class="result-wrap">
				<form name="myform" id="myform" method="post">
					<div class="result-title">
						<div class="result-list">


						</div>
					</div>
					<div class="result-content">
						<table class="result-tab" width="100%">
							<tr>


								<th>
									ID
								</th>
								<th>
									车位号
								</th>

								<th>
									区号
								</th>
								<th>

									备注
								</th>

								<th>
									预定时间
								</th>

								<th>
									预定时长
								</th>

								<th>
									总计费用
								</th>
								<th>
									操作
								</th>
							</tr>
							<%
								DBManager dbm = new DBManager();
								Connection conn = dbm.getConnection();
								String queryName = request.getParameter("queryName");
								String sql2="select * from che where uid="+request.getSession().getAttribute("uid");
								PreparedStatement pstmt2 = conn.prepareStatement(sql2);
								ResultSet rs2 = pstmt2.executeQuery();
								rs2.next();
								String hao=rs2.getString("hao");
								String sql = "select * from yuding where chepai="+"'"+hao+"'";
								String sql1="select * from fei where id=1";
//								if (queryName != null) {
//									sql = sql + " and  hao like '%" + queryName + "%'";
//								}
//
//								String queryName2 = request.getParameter("queryName2");
//								if (queryName2 != null) {
//									sql = sql + " and  adate like '%" + queryName2 + "%'";
//								}

								System.out.println(sql);
								PreparedStatement pstmt = conn.prepareStatement(sql);
								ResultSet rs = pstmt.executeQuery();
								PreparedStatement pstmt1 = conn.prepareStatement(sql1);
								ResultSet rs1 = pstmt1.executeQuery();
								rs1.next();
								try {

									int pageSize;//一页显示的记录数
									int totalItem;//记录总数
									int totalPage;//总页数
									int curPage;//待显示页码
									String strPage;
									int i;
									pageSize = 5;//设置一页显示的记录数
									strPage = request.getParameter("page");//获得待显示页码
//									PrintWriter writer = response.getWriter();
//									writer.write(strPage);
//									writer.flush();
//									writer.close();
									if (strPage == null) {
										curPage = 1;
									} else {
										curPage = java.lang.Integer.parseInt(strPage);//将字符串转换成整形
									}
									if (curPage < 1) {
										curPage = 1;
									}
									rs.last();//获取记录总数
									totalItem = rs.getRow();
									totalPage = (totalItem + pageSize - 1) / pageSize;
									if (curPage > totalPage)
										curPage = totalPage;//调整待显示的页码
									if (totalPage > 0) {//将记录指针到待显示页的第一条记录上
										rs.absolute((curPage - 1) * pageSize + 1);
									}
									i = 0;

									while (i < pageSize && !rs.isAfterLast()) {
										String id = rs.getString("id");
							%>
							<tr>


								<td>
									<%=id%>
								</td>
								<td title="">
									<%=rs.getString("hao")%>
								</td>

								<td title="">
									<%=rs.getString("qu")%>
								</td>

								<td title="">
									<%=rs.getString("info")%>

								</td>


								<td title="">
									<%=rs.getString("adate")%>
								</td>

								<td title="">
									<%=rs.getString("hours")%>
								</td>

								<td title="">
<%--									Integer.parseInt(rs.getString("hours"))*--%>
									<%
										Double price=((int)((Double.parseDouble(rs1.getString("price"))*Double.parseDouble(rs.getString("hours"))*100))/100.0);
									%>
									<%=price%>
								</td>

								<td title="">
									<%=rs.getString("chepai")%>
									<a class="link-del" href="<%=path%>/Delyuding?id=<%=id%>">删除</a>
								</td>

							</tr>

							<%
								rs.next();
										i++;
									}
									if (rs != null)
										rs.close();
									if (pstmt != null)
										pstmt.close();
									if (conn != null)
										conn.close();
							%>
						</table>
						<div class="list-page">
							&nbsp; 共<%=totalItem%>个记录,分<%=totalPage%>页显示,当前页是:第<%=curPage%>页


							<%
								if (curPage > 1) {
							%><a href="<%=path%>/yuyue/lslist.jsp?page=1">首页</a>
							<%
								}
							%>&nbsp;&nbsp;

							<%
								if (curPage > 1) {
							%><a href="<%=path%>/yuyue/lslist.jsp?page=<%=curPage - 1%>">上一页</a>
							<%
								}
							%>&nbsp;&nbsp;

							<%
								for (int j = 1; j <= totalPage; j++) {
										out.print("&nbsp;&nbsp;<a href='"+path+"/yuyue/lslist.jsp?page=" + j
												+ "'>" + j + "</a>");
									}
							%>

							&nbsp;&nbsp;
							<%
								if (curPage < totalPage) {
							%><a href="<%=path%>/yuyue/lslist.jsp?page=<%=curPage + 1%>">下一页</a>
							<%
								}
							%>&nbsp;&nbsp;

							<%
								if (totalPage > 1) {
							%><a href="<%=path%>/yuyue/lslist.jsp?page=<%=totalPage%>">末页</a>
							<%
								}
							%>
							<%
								} catch (SQLException e1) {
									System.out.println(e1);
								}
							%>

						</div>
					</div>
				</form>
			</div>
		</div>
		<!--/main-->
		</div>
	</body>
</html>
