<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%//response.sendRedirect("create-connection.jsp") ;%>

<%
boolean noDb = true;

String dbName = request.getParameter("db");
if(dbName != null){
	noDb = false;
}else
	dbName = "";
String tb = request.getParameter("tb");

%>
<script type="text/javascript" src="js/jquery-1.9.0.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<link rel="shortcut icon" href="images/logo.png">
<link rel="stylesheet" href="css/index.css">
<style type="text/css">
	body{
		margin: 0px;
		font-family: sans-serif;
	}
</style>
<script type="text/javascript" src="js/script.js"></script>
<script type="text/javascript">
	var db = "";
	$(document).ready(function() {
		init();
		<%if(tb != null){%>
			displayResult('select * from <%=tb %>','<%=dbName %>');
		<%}%>
	});
	
	function init(){
		$("#header ul li a").click(function() {
			//alert(this.innerHTML);
			name = this.innerHTML;
			if(name.indexOf("Describe") > -1){
				xhr("describe.jsp?db=<%=dbName%>",function(res){
					document.getElementById("resultFrame").innerHTML = res;
					$("#desc-tableList li a").click(function() {
						xhr(this.href,function(r){
							$("#resultFrame").html(r);
						});
						return false;
					});
				});
			}else if(name.indexOf("Structure") > -1){
				xhr("structure.jsp?db=<%=dbName%>",function(res){
					$("#resultFrame").html(res);
				});
			}else if(name.indexOf("Import") > -1){
				xhr("import.jsp?db=<%=dbName%>",function(res){
					$("#resultFrame").html(res);
				});
			}else if(name.indexOf("Export") > -1){
				xhr("export.jsp?db=<%=dbName%>",function(res){
					$("#resultFrame").html(res);
				});
			}else if(name.indexOf("Drop") > -1){
				$("#overlay").show();
				$("#error_msg").show();
			}
			return false;
		});
		$("#tableList li a").click(function() {
			return false;
		});
		updateSideMenu("<%=dbName%>");
	}
	
	function confDropDB(){
		xhr("dropDB?db=<%=dbName%>", function(res){
			closeWarning();
			document.location.href = "?#home";
		});
	}
	function closeWarning() {
		$("#overlay").fadeOut(900);
		$("#error_msg").fadeOut(900);
	}

</script>
</head>
<body style="overflow: visible;">
	<div class="main-container">
		<div id="leftFrame">
			
		</div>
		<div id="rightFrame">
			<div id="header">
				<br>
				<ul>
				<%if(noDb){ %>
					<li>
						<a href="showDB">
							<img src="images/db.png">Databases
						</a>
					</li>
					<li>
						<a href="s">
							<img alt="" src="images/vars.png">Variables
						</a>
					</li>
				<%}else{ %>
					<li>
						<a href="structure.jsp">
							<img alt="" src="images/b_props.png">Structure
						</a>
					</li>
				<%}%>
					<li>
						<a href="query.jsp?db=<%=dbName%>" target="_top">
							<img alt="" src="images/sql.png">Sql
						</a>
					</li>
					<li>
						<a href="s">
							<img alt="" src="images/search.png">Search
						</a>
					</li>
					<li>
						<a href="import.jsp">
							<img alt="" src="images/tblimport.png">Import
						</a>
					</li>
					<li>
						<a href="export.jsp">
							<img alt="" src="images/tblexport.png">Export
						</a>
					</li>
					<%if(!noDb){ %>
						<li>
							<a href="describe.jsp">
								<img alt="" src="images/desc.png">Describe
							</a>
						</li>
							<li>
								<a href="dropDB">
									<img alt="" src="images/b_drop.png"> Drop
								</a>
						</li>
					<%} %>
				</ul>
				<div class="u-line"></div>
				<br>
			</div>
			<br>
			<br>
			<div id="resultFrame" style="width: 100%;margin-left: 20px;">
				<%if(noDb){ %>
					<script type="text/javascript">
						function addDB() {
							db = document.getElementById("addDBName").value;
							xhr("addDB?db="+db,function(res){
								//alert(res);
								document.location.href = "?db="+db;
							});
						}
					</script>
					<fieldset class="fieldset">
						<legend>Create New Database</legend>
							<label>Database Name:</label>
							<input id="addDBName">
							<button onclick="addDB()">Go</button>
					</fieldset>
				
				<%}else{%>
					<script type="text/javascript">
						function addTable() {
							try {
								table = document.getElementById("table_name").value;
								var columns = parseInt(document.getElementById("no_columns").value);
								if(isNaN(document.getElementById("no_columns").value) || document.getElementById("no_columns").value == "")
									return;
								xhr("new_table.jsp?columns="+columns,function(res){
									$("#table_fields").html(res);
								});
							} catch (e) {
								alert(e.message);
							}
						}
						function addTableFinal(e) {
							try {
								var elements = e.elements;
								var table = document.getElementById("table_name").value;
								var query = "create table "+table+"(";
								for(var i = 0;i < elements.length-1;i+=5){
									/* var name = elements[i].name;
									var value = elements[i].value;
									var type = elements[i].type; */
									if(i != 0)
										query += ",";
									
									var name = elements[i].value;
									var type = elements[i+1].value;
									var length = elements[i+2].value;
									var nullable = elements[i+3].checked;
									var index = elements[i+4].value;
									
									if(name == ""){
										alert("Please complete the form!");
										return false;
									}
									if(!nullable)
										nullable = "";
									if(type == "VARCHAR"){
										if(isNaN(length) || length == ""){
											alert("Invalid value for length!");
											elements[i+2].focus();
											return false;
										}
										length = "("+length+")";
									}else{
										length = "";
									}
									query += name+" "+type+length+nullable+" "+index; 
								}
								query += ")";
								xhr("executeQuery?q="+query+"&db=<%=dbName%>",function(res){
									$("#content_res").html(res);
									$("#query_response").show();
									$("#overlay").show();
								});
								return false;
							} catch (e) {
								alert(e.message);
							}
						}
						function closeResponse() {
							$("#query_response").hide();
							$("#overlay").hide();
						}
					</script>
					<br><br><br><br>
					<fieldset class="fieldset">
						<legend>Create New Table</legend>
							<label>Table Name:</label>
							<input id="table_name">
							<input placeHolder="No. of Columns" id="no_columns">
							<button onclick="addTable()">Go</button>
					</fieldset>
					<div id="table_fields">
					
					</div>
				<%} %>
			</div>
		</div>
	</div>
	<div id="overlay"></div>
	<div id="error_msg">
		<div style="width: 290;;margin: 5px;text-align: center;background: darkred;font-weight: bolder;color: white;padding:10px;">Confirm</div>
		<div id="msg_value" style="margin: 10px;font-size: 15px;">Are you sure you want to delete a whole database?
			<br><br>
			<center><b><%=dbName %></b></center>
		</div>
		<div style="float: right;margin-right: 10px;margin-top: 30px;"><button onclick="closeWarning()">No</button>&nbsp;<button onclick="confDropDB()">Yes</button> </div>
	</div>
	<div id="query_response">
		<div id="content_res"></div>
		<br>
		<button onclick="closeResponse()" style="float: right;height: 30px;width: 100px;background: darkred;color: white;font-weight: bolder;">Close</button>
	</div>
</body>
</html>