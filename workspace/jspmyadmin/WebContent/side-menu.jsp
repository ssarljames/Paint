<%@page import="java.sql.SQLException"%>
<%@page import="utils.ConnectionInfo"%>
<%@page import="dao.Dao"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>


<%
boolean noDb = true;

String dbName = request.getParameter("db");
String param = "";
try{
	if(dbName == null || dbName.isEmpty()){
		noDb = true;
	}else{
		param = "?db="+dbName;
		noDb = false;
	}
}catch(Exception e){
	noDb = true;
}
Dao dao = null;
try{
	dao = new Dao(ConnectionInfo.getInfo());
}catch(SQLException e){
	if(e.getMessage().equals("Server Not Found")){
		
	}
}

%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/index.css">
<title></title>
<style type="text/css">
body {
	
}
</style>
</head>
<body>
	<img alt="" src="images/logo.png" class="logo">
	<!-- <br> -->
	<ul class="main-menu">
		<li>
			<a href="index.jsp">
				<img alt="" src="images/b_home.png">
			</a>
		</li>
		<li>
			<a target="_" href="query.jsp<%=param%>">
				<img alt="" src="images/b_selboard.png">
			</a>
		</li>
		<li>
			<a href="sql.jsp">
				<img alt="" src="images/s_loggoff.png">
			</a>
		</li>
	</ul>
	<br>
	
	<%
		if(noDb){
				
				try{
					ArrayList<String> dbs = dao.getDatabases();%>
					<ul class="db-list">
						<%for(String db:dbs){%>
							<li  class="dbnames">
								<a style="width: 100%;" id="<%="db-"+db %>" href="?db=<%=db%>"><%=db %></a>
							</li>
						<%} %>
					</ul>
				<%}catch(Exception e){%>
					<br><br>
					<b style="margin-left: 20px;color: red">Server not found!!</b> 
					Try to fix <a href="server.jsp">here</a>
				<%}
				
		}else{%>
			<fieldset class="table-list">
				<legend><a href="?db=<%=dbName %>"><%=dbName %></a></legend>
				<%try{
					ArrayList<String> tables = dao.getTables(dbName);
					if(!tables.isEmpty()){%>
						<ul id="tableList">
							<%for(String tb:tables){%>
								<li class="dbnames">
									<a id="<%="db-"+tb %>" onclick="displayResult('select * from <%=tb %>','<%=dbName %>') ;return false;" href="?db=<%=dbName %>&tb=<%=tb%>"><%=tb %></a>
								</li>
							<%}%>
						</ul>
					<%}else{%>
						<ul id="tableList">
							<li class="dbnames">
								<label>( No tables )</label>
							</li>
						</ul>
					<%}%>
				<%}catch(Exception e){%>
					
				<%}%>
				<a href="index.jsp?db=<%=dbName %>" style="font-size: 10px;font-weight: bolder;">+Create New Table</a>
			</fieldset>
		<% }%>
</body>
</html>