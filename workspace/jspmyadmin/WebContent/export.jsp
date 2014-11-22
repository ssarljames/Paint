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
if(dbName != null){
	noDb = false;
}else{
	dbName = "";
}%>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%if(noDb){ %>
		<fieldset>
			<legend>Please Select a database</legend>
			<%
			try{
				ArrayList<String> dbs = new Dao(ConnectionInfo.getInfo()).getDatabases();%>
				<ul style="list-style-image: url('images/database.png');">
				<%for(String db:dbs){%>
					<li  class="dbnames"><a style="width: 100%;" href="export.jsp?db=<%=db%>"><%=db %></a></li>
				<%} %>
				</ul>
			<%}catch(Exception e){%>
				
			<%}%>
		</fieldset>
	<%}else{ %>
		<br>
		<br>
		<br>
		<br>
		<fieldset style="border: 2px solid #cccccc;padding: 30px;">
			<legend style="border: 2px solid #cccccc;padding:10px;">Export Database</legend>
			<label>rename file: </label>
			<input id="fname" value="<%=dbName%>">
			<select id="file-ext">
				<option value=".sql" selected="selected">.sql</option>
				<option value=".txt">.txt</option>
			</select>
			<button style="float: right;" onclick="download_exportFile('<%=dbName%>')">done</button>
		</fieldset>
	<%} %>
</body>
</html>