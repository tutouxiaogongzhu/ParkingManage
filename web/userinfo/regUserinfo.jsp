<%@include file="/common/sub_header.jsp"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

	</head>

	<body>
	<div class="snow-container">
		<div class="snow foreground"></div>
		<div class="snow foreground layered"></div>
		<div class="snow middleground"></div>
		<div class="snow middleground layered"></div>
		<div class="snow background"></div>
		<div class="snow background layered"></div>
	</div>
			
			<div class="main-wrap1">
				<div class="crumb-wrap">
					<div class="crumb-list">
						<i class="icon-font"></i><span>用户注册</span>
					</div>
				</div>
				<div class="result-wrap">
					<div class="result-content">
						<form action="<%=path%>/RegUserinfoAction" method="post" id="myform" name="myform" onsubmit="return save()">
							<table class="insert-tab" width="100%">
								<tbody>

									<tr>
										<th>
											<i class="require-red"></i>登录名：
										</th>
										<td>
											<input class="common-text required" id="name" name="name"
												size="50" value="" type="text">
										</td>
									</tr>

									<tr>
										<th>
											<i class="require-red"></i>密码：
										</th>
										<td>
											<input class="common-text required" id="pwd" name="pwd"
												size="50" value="" type="text">
										</td>
									</tr>

									<tr>
										<th>
											<i class="require-red"></i>年龄：
										</th>
										<td>
											<input class="common-text required" id="age" name="age"
												size="50" value="" type="text">
										</td>
									</tr>

									<tr>
										<th>
											<i class="require-red"></i>性别：
										</th>
										<td>
											<input type="radio" name="gender" value="男" checked>男
											<input type="radio" name="gender" value="女" >女
										</td>
									</tr>

									<tr>
										<th>
											<i class="require-red"></i>电话：
										</th>
										<td>
											<input class="common-text required" id="tel" name="tel"
												size="50" value="" type="text">
										</td>
									</tr>


									<tr>
										<th></th>
										<td>
											<input class="btn btn-primary btn6 mr10"
												value="提交" type="submit">
											<input class="btn btn6" onclick="history.go(-1)" value="返回"
												type="button">
										</td>
									</tr>
								</tbody>
							</table>
						</form>
					</div>
				</div>

			
			<!--/main-->
		</div>
	</body>
</html>
<script>

function save() {
	// if ($("#name").val() == "") {
	// 	$.messager.alert('警告', '姓名不能为空！', 'warning');
	// 	return;
	// }
	// if ($("#pwd").val() == "") {
	// 	$.messager.alert('警告', '密码不能为空！', 'warning');
	// 	return;
	// }
	var name = document.getElementById("name").value;
	var pwd = document.getElementById("pwd").value;
	// var pattern = /^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/;
	var pattern =/^[a-z]{5,10}$/;//账户为英文，不能有其他字符，且长度可控制在3-5位
	var pattern1=/^[a-zA-Z0-9]{5,10}$/;
	if (name == '') {
		alert("不能为空！")
		return false;
	} else if (!pattern.test(name)) {
		alert("姓名格式不正确！")
		return false;
	}
	if (pwd == '') {
		alert("password不能为空！")
		return false;
	} else if (!pattern1.test(pwd)) {
		alert("password格式不正确！")
		return false;
	}
	// return true;
	return true;
	<%--document.forms[0].action = "<%=path%>/RegUserinfoAction";--%>
	<%--document.forms[0].submit();--%>
}

$("#name").blur(function(){
	var name = document.getElementById("name").value;
	var pwd = document.getElementById("pwd").value;
	console.log(name);
	$.ajax({
		type: "POST",//写一下重复密码
		url: "<%=path%>/RegUserinfoAction",
		data: {name: name,pwd:pwd},
		dataType: 'json',
		success: function (data) {
			if(data==true){
				alert("抱歉，该用户名已经被注册");
			}else{
				alert("恭喜，该用户名还没有注册");
			}
		}
	});
});
</script>
