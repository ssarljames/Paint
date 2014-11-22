package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import connection.Myconnection;
import dao.Dao;
import utils.ConnectionInfo;
import bean.ConnectionBean;

/**
 * Servlet implementation class ExecuteQuery
 */
@WebServlet("/executeQuery")
public class ExecuteQuery extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ExecuteQuery() {
        super();
        // TODO Auto-generated constructor stub
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.sendRedirect("");
		doPost(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		try {
			String query = request.getParameter("q");
			String db = request.getParameter("db");
			
			ConnectionBean cb = ConnectionInfo.getInfo();
			Dao dao;
			if(db != null){
				dao = new Dao(cb,db);
			}else{
				dao = new Dao(cb);
			}

			ArrayList<ArrayList<String>> table = dao.executeQuery(query);
			String classNAme = "light";
			out.print("<fieldset style='padding: 20px;max-width: 400px;border: 1px solid #00FF00;background:#E5E5E5'>"
					+ "<legend style='color:green;border: 3px solid #00FF00;padding-left: 20px;padding-right: 20px;background:#f0fff0;'>Mysql returned "+(table.size()-1)+" result/s</legend>"
					+query+
					"</fieldset><br><br><br>");
			if( table.size() > 1){
				out.print("<table border='1' class='resultTable'>\n");
				for(int i=0;i<table.size();i++){
					if(i == 0)
						out.print("<tr class='columnName'>\n");
					else
						out.print("<tr class='"+classNAme+"'>\n");
					ArrayList<String> row = table.get(i);
					for(int j=0;j<row.size();j++){
						String colValue = row.get(j);
						out.print("		<td>"+colValue+"</td>\n");
					}
					out.print("</tr>\n");
					if(classNAme.equals("light"))
						classNAme = "dark";
					else
						classNAme = "light";
						
				}
				out.print("</table>");
			}else{
				out.print("MySQL returned an empty result set (i.e. zero rows).");
			}
			
			
			
		} /*catch (SQLException e) {
			out.print("<fieldset style='padding: 20px;'>"
					+ "<legend style='color:red;'>Error Occured</legend>"
					+ e.getMessage()+
					"</fieldset>");
		}*/catch (Exception e) {
			out.print("<fieldset style='padding: 20px;border:2px solid red;'>"
					+ "<legend style='color:red;border:3px solid red;'>Error Occured</legend>"
					+ e.getMessage()+
					"</fieldset>");
			//e.printStackTrace();
		}
	}

}
