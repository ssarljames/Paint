<%@page import="utils.ConnectionInfo"%>
<%@page import="dao.Dao"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%
boolean noDb = true;
boolean noTb = true;

String dbName = request.getParameter("db");
if(dbName != null){
	noDb = false;
}else{
	dbName = "";
}

String tbName = request.getParameter("tb");
if(tbName != null){
	noTb = false;
}else{
	tbName = "";
}
	


%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="js/script.js"></script>
<title>Describe Table</title>
</head>
<body>
	<%if(noDb){ %>
		<fieldset style="border: 2px solid #cccccc;padding: 20px;">
			<legend style="border: 2px solid #cccccc;padding: 20px;">Please Select a database</legend>
			<%
			try{
				ArrayList<String> dbs = new Dao(ConnectionInfo.getInfo()).getDatabases();%>
				<ul style="list-style-image: url('images/database.png');">
				<%for(String db:dbs){%>
					<li  class="dbnames"><a style="width: 100%;" href="describe.jsp?db=<%=db%>"><%=db %></a></li>
				<%} %>
				</ul>
			<%}catch(Exception e){%>
				
			<%}%>
		</fieldset>
	<%}else if(noTb){ %>
		<fieldset style="border: 2px solid #cccccc;padding: 20px;">
			<legend style="border: 2px solid #cccccc;padding: 20px;">Please Select a Table</legend>
			<%try{
				ArrayList<String> tables = new Dao(ConnectionInfo.getInfo()).getTables(dbName);
				 if(tables.size() != 0){%>
					<ul id="desc-tableList" style="list-style-image: url('images/table.png');">
					<%for(String tb:tables){%>
						<li  class="desc-tb"><a style="width: 100%;color: black;" href="describe.jsp?db=<%=dbName%>&tb=<%=tb %>"><%=tb %></a></li>
					<%}%>
					</ul>
				<%}else{%>
					<label>(No tables)</label>
				<%}%>
			<%}catch(Exception e){%>
				
			<%}%>
		</fieldset>
	<%}else{
		ArrayList<ArrayList<String>> table = new Dao(ConnectionInfo.getInfo(),dbName).executeQuery("describe "+tbName);%>
		<table border="1">
		<%
		String cName = "dark";
		for(int i=0;i<table.size();i++){
			ArrayList<String> tr = table.get(i);%>
			<%if(i == 0){ %>
				<tr class="columnName">
			<%}else{ %>
				<tr class="<%=cName%>">
				<%}for(String td : tr){%>
					<td><%=td %></td>
				<%} %>
			</tr>
		<%
		if(cName.equals("light"))
			cName = "dark";
		else
			cName = "light";
		} %>
		</table>
	<%} %>
</body>
</html>