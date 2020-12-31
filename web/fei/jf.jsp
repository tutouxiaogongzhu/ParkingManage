<%@include file="/common/sub_header.jsp"%>
<%@ page contentType="text/html;charset=UTF-8"
	import="java.util.*,java.sql.*,com.wang.db.*" pageEncoding="UTF-8"%>
<%@ page import="javax.xml.transform.Result" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

	</head>

	<body>
		<jsp:include page="/top.jsp"></jsp:include>
		<div class="container clearfix">
			<jsp:include page="/left.jsp"></jsp:include>
			<!--/sidebar-->
			<div class="main-wrap">

				<div class="crumb-wrap">
					<div class="crumb-list">
						<i class="icon-font"></i><span>缴费</span>
					</div>
				</div>
				<div class="result-wrap">
					<div class="result-content">
						<form method="post" id="myform" name="myform">
							<table class="insert-tab" width="100%">
								<tbody>
									<%
										DBManager dbm = new DBManager();
										Connection conn = dbm.getConnection();
										

										String sql = "select * from yuding where chepai="+"'"+request.getParameter("chepai")+"'";

//										String sql1="select * from "
										PreparedStatement stat = conn.prepareStatement(sql);
										ResultSet rs = stat.executeQuery();
										rs.next();
										rs.absolute(rs.getRow());
										rs.last();
										String bdate=rs.getString("adate");
										
										java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
										String ldate=format.format(new java.util.Date());
										long count=dbm.calcHour(bdate,ldate);
										double hours=dbm.calcHMS(bdate,ldate);
										DBManager dbm1= new DBManager();
										Connection conn1 = dbm1.getConnection();
										String sql2= "update yuding set hours=" + hours+ " where id="+"'"+rs.getString("id")+"'";
										String fei=(String)session.getAttribute("fei");

										PreparedStatement stat1 = conn1.prepareStatement(sql2);
										 stat1.execute();
										conn1.close();
										stat1.close();
//										String sql3="select id from yuding where chepai="+"'"+request.getParameter("chepai")+"'";
//										DBManager dbm2= new DBManager();
//										Connection conn2 = dbm1.getConnection();
//										PreparedStatement stat2 = conn2.prepareStatement(sql2);
//										ResultSet rs2=stat2.executeQuery();
//										rs2.last();

//										long jine=count*Long.parseLong(fei);
										
										
										String yue=dbm.getYue(rs.getString("chepai"));
										
									    double yu=Double.parseDouble(yue);
									    
									    boolean isNo=false;
//									    if(jine-yu>=0){
//									       isNo=true;
//									    }
										 
									%>
									<tr>
										<th>
											<i class="require-red"></i>车牌：
										</th>
										<td>
											<input class="common-text required" id="hao"
												value='<%=rs.getString("chepai")%>' name="hao" size="20"
												type="text" readonly>
										</td>
									</tr>

									<tr>
										<th>
											<i class="require-red"></i>停车时间：
										</th>
										<td>
											<input class="common-text required" id="jdate"
												value='<%=bdate%>' name="jdate" size="20"
												type="text" readonly >
										</td>
									</tr>
									<tr>
										<th>
											<i class="require-red"></i>离开时间：
										</th>
										<td>
											<input class="common-text required" id="ldate" value='<%=ldate%>'
												name="ldate" size="20" type="text" readonly>
										</td>
									</tr>
									<tr>
										<th>
											<i class="require-red"></i>停车标准：
										</th>
										<td>
											<input class="common-text required" id="biao"
												value='<%=fei%>' name="biao"
												size="5" type="text" readonly>
											元/小时
										</td>
									</tr>
									<tr>
										<th>
											<i class="require-red"></i>停车时长：
										</th>
										<td>
											<input class="common-text required" id="shijian"
												value='<%=((int)(hours*100))/100.0%>' name="shijian"
<%--												   rs.getString("hours")--%>
												size="5" type="text" readonly>
											小时
										</td>
									</tr>
									<tr>
										<th>
											<i class="require-red"></i>费用：
										</th>
										<td>
											<input class="common-text required" id="jine"
												value='<%=((int)((Integer.parseInt(fei)*((int)(hours*100))/100.0)*100))/100.0%>' name="jine"
												size="5" type="text"  readonly>
											(卡内余额:<%=yu %>)	
										 <%
											 boolean IsNo=false;
											 if((Integer.parseInt(fei)*hours)>yu){
//											 Integer.parseInt(rs.getString("hours")
												 IsNo=true;
											 }
										 %>
										</td>
									</tr>


									<%
										if (rs != null)
											rs.close();
										if (stat != null)
											stat.close();
										if (conn != null)
											conn.close();
									%>
									<tr>
										<th></th>
										<td>
											<input class="btn btn-primary btn6 mr10" onclick="save();"
												value="提交" type="button">
											<input class="btn btn6" onclick="history.go(-1)" value="返回"
												type="button">
										</td>
									</tr>
								</tbody>
							</table>
						</form>
					</div>
				</div>

			</div>
			<!--/main-->
		</div>
	</body>
</html>
<script>

function save() {
    var isNo="<%=IsNo%>";
    <%--var yue="<%=yu %>";--%>
    <%--var feiyong="<%=%>"--%>
    if(isNo=='true'){
	// if(yue<feiyong){
       $.messager.alert('警告', '开内余额不足，请充值！', 'warning');
		return;
    }
	if ($("#name").val() == "") {
		$.messager.alert('警告', '姓名不能为空！', 'warning');
		return;
	}
	if ($("#pwd").val() == "") {
		$.messager.alert('警告', '密码不能为空！', 'warning');
		return;
	}
	document.forms[0].action = "<%=path%>/AddCfeiAction";
	document.forms[0].submit();

}
</script>
