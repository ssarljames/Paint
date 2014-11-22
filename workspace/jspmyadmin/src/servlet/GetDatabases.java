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
import javax.servlet.http.HttpSession;

import utils.ConnectionInfo;

import bean.ConnectionBean;

import connection.Myconnection;
import dao.Dao;

/**
 * Servlet implementation class GetDatabases
 */
@WebServlet("/getDatabases")
public class GetDatabases extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetDatabases() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			//HttpSession session = request.getSession();
			ConnectionBean bean = ConnectionInfo.getInfo();
			ArrayList<String> dbs = new Dao(bean).getDatabases();
			
			PrintWriter out = response.getWriter();
			out.print("<ul>");
			for (String db : dbs) {
				out.print("<li ><a href='query.jsp?db="+db+"'>"+db+"</a></li>");
			}
			out.print("</ul>");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			//response.sendRedirect("");
			e.printStackTrace();
		}		
	}

}
