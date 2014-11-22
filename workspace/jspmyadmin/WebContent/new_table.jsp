<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
int no_of_columns = 0;
try{
	no_of_columns = Integer.parseInt(request.getParameter("columns"));
}catch(Exception e){}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
<style type="text/css">
	.new_table{
		border-bottom: 1px solid black;
	}
	.new_table .t_header td{
		background: darkgreen;
		color: white;
		font-weight: bolder;
		font-family: Verdana,Arial,sans-serif;
		padding: 10px;
	}
	.new_table .t_column:HOVER{
		background: palegreen;
	}
	.new_table .t_column{
		text-align: center;
	}
	.new_table .t_column td input,select{
		padding: 5px;
	}
</style>
</head>
<body>
	<br><br><br>
	<form onsubmit="return addTableFinal(this);">
	<table class="new_table">
		<tr class="t_header">	
			<td>Name</td>
			<td>Type</td>
			<td>Length</td>
			<td>Null</td>
			<td>Index</td>
		</tr>
		<%for(int i=0;i<no_of_columns;i++){ %>
				<tr class="t_column">
					<td><input name="column_name_<%=i%>"></td>
					<td>
						<select name="column_type_<%=i%>">
							<option>INT</option>
							<option>INT AUTO_INCREMENT</option>
							<option>VARCHAR</option>
						</select>
					</td>
					<td><input name="column_length_<%=i%>"></td>
					<td><input type="checkbox" name="column_nullable_<%=i%>"></td>
					<td>
						<select name="column_index_<%=i%>">
							<option> </option>
							<option>PRIMARY KEY</option>
							<option>UNIQUE KEY</option>
							<option>INDEX</option>
							<option>FULLTEXT</option>
						</select>
					</td>
				</tr>
		<%} %>
	</table>
	<br>
	<button style="float: right;padding: 20px;width: 100px" type="submit">Go</button>
	</form>
</body>
</html>