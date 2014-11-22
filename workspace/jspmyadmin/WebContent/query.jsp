<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Query</title>
<%
boolean noDb = true;

String dbName = request.getParameter("db");

try{
	if(dbName == null || dbName.isEmpty()){
		noDb = true;
	}else{
		noDb = false;
	}
}catch(Exception e){
	noDb = true;
}


%>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript">
	function showDatabases() {
		

		xhr("getDatabases",function(res){
			document.getElementById("dialogf").innerHTML =  res;
		});
		
		document.getElementById("overlay").style.display = "block";
		document.getElementById("dialog").style.display = "block";
	}
	


	
	function displayResult(q,db) {
		xhr("executeQuery?q="+q+"&db="+db,function(res){
			document.getElementById("qBody").innerHTML = "<a href='query.jsp?db="+db+"&q="+q+"'>Back</a><br><br>"+res;
		});
	}
	

</script>
</head>
<body id="qBody">
	<%
	String p = request.getParameter("q");
	if(p == null)
		p = "";
	
	if(noDb){%>
		<font style="color: red;">No database selected. <a onclick="showDatabases();return false" href="selectdb.jsp?redirectURL=query.jsp">click here</a> to select.</font>
	
		<div id="overlay" style="position: fixed;height: 100%;width: 100%;background: black;top: 0;opacity:0.7;display: none;z-index: 100;"></div>
		<div id="dialog" style="position: fixed;min-height: 200px;width: 200px;border: 1px solid #aaa;top: 25%;left:40%; ;display: none;z-index: 101;background: white;">
			<div style="width: 100%;height: 30px;background: orange;">Select Database:</div>
			<div id="dialogf"></div>
		</div>
		<script type="text/javascript">
		</script>
	
	<%}%>
	<div style="width: 500px;height: 400px;padding: 5px;">
		<textarea id="qq" rows="" cols="" style="resize: none;height: 350px;width: 480px"><%=p%></textarea>
		<button onclick="displayResult(document.getElementById('qq').value,'<%=dbName %>')" style="float: right;margin-right: 10px;">Go</button>
	</div>
</body>
</html>