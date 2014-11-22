<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<%
boolean noDb = true;

String dbName = request.getParameter("db");
if(dbName != null){
	noDb = false;
}else{
	dbName = "";
}%>
<title>Import</title>
</head>
<body>
	<br>
	<br>
	<br>
	<br>
	<fieldset style="border: 2px solid #cccccc;padding: 30px;">
		<legend style="border: 2px solid #cccccc;padding:10px;">Import SQL File</legend>
		<div id="restore-status"></div>
		<div id="upload-f">
			<input type="file" id="file-backup"><button style="float: right;" onclick="uploadBackUp('<%=dbName%>')">upload</button>
		</div>
	</fieldset>
</body>
</html>