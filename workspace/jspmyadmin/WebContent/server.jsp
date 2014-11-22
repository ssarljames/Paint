<%@page import="utils.ConnectionInfo"%>
<%@page import="com.mysql.jdbc.ConnectionImpl"%>
<%@page import="bean.ConnectionBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
.info td {
	padding: 15px;
}
</style>
<script type="text/javascript">
	function useDefault(){
		document.getElementById("host").value = "localhost";
		document.getElementById("port").value = "3306";
		document.getElementById("uname").value = "root";
		document.getElementById("pword").value = "";
	}
	
	function submit(e){
		try{
			host = document.getElementById("host").value;
			port = document.getElementById("port").value;
			uname = document.getElementById("uname").value;
			pword = document.getElementById("pword").value;
			e.disabled = true;
			url = "createConnection?host="+host+"&port="+port+"&uname="+uname+"&pword="+pword;
			//alert(url);
			xhr("post", url, function(res) {
				if(res == "ok"){
					xhr("get", "CheckServer", function(res2) {
						if(res2 == "0"){
							alert("Server unavailable!");
						}else{
						}
						e.disabled = false;
						init();
					});
				}
			});
		}catch (e) {
			alert(e.message);
		}
	}
	function init() {
		xhr("get", "CheckServer", function(res2) {
			if(res2 == "0"){
				document.getElementById("status").innerHTML = "not connected"
				document.getElementById("status").style.color = "red"
				document.getElementById("disconnected").style.display = "block";
				document.getElementById("connected").style.display = "none";
				
			}else{
				document.getElementById("status").innerHTML = "connected"
				document.getElementById("status").style.color = "green"
					document.getElementById("connected").style.display = "block";
				document.getElementById("disconnected").style.display = "none";
			}
		});
	}
	
	function xhr(method,url,success){
		var xhr;
  		if (window.XMLHttpRequest){
  			xhr = new XMLHttpRequest();
		}else{
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		}
  		xhr.onreadystatechange=function(){
			if (xhr.readyState==4 && xhr.status==200) {
				resp = xhr.responseText;
				success(resp);
			}
		};
		xhr.open(method	,url ,true);
		xhr.send();
	}
	
</script>
<title>New Monnection</title>
</head>
<body onload="init()">
	<%
	ConnectionBean cb = ConnectionInfo.getInfo();
	%>
	<div style="width: 500px; border: 1px solid #aaaaaa; margin: 0px auto; margin-top: 150px">
		<div
			style="width: 100%; border-bottom: 1px solid #aaaaaa; height: 50px; padding-top: 25px;">
			<a href="index.jsp" style="width: 100px;margin-left: 30px"><img style="width: 100px;" src="images/logo.png"></a>
			<label style="margin-left: 70px;">MySQL Server</label>
		</div>

		<table class="info" style="margin-left: 40px; margin-top: 30px;">
			<tr>
				<td>Host</td>
				<td><input id="host" value="<%=cb.getHost() %>"></td>
			</tr>
			<tr>
				<td>Port</td>
				<td><input id="port" value="<%=cb.getPort() %>"></td>
			</tr>
			<tr>
				<td>Username</td>
				<td><input id="uname" value="<%=cb.getUser() %>"></td>
			</tr>
			<tr>
				<td>Password</td>
				<td><input type="password" id="pword"
					value="<%=cb.getPassword() %>"></td>
			</tr>
			<tr>
				<td>Status</td>
				<td><label style="font-weight: bolder;" id="status"></label></td>
			</tr>
		</table>

		<div id="cdisconnected" style="margin-left: 150px; display: ;">
			<button onclick="useDefault()">use defaults</button>
			<button onclick="submit(this)">finish</button>
		</div>
		<div id="cconnected" style="margin-left: 150px; display: ;">
			<button onclick="useDefault()">disconnect</button>
		</div>
		<br> <br> <br>
	</div>
</body>
</html>