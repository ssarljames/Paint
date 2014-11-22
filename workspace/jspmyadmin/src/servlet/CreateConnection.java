package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import utils.ConnectionInfo;

import connection.Myconnection;

import dao.Dao;

import bean.ConnectionBean;

@WebServlet("/createConnection")
public class CreateConnection extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateConnection() {
        super();
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		try {
			String host = request.getParameter("host");
			String port = request.getParameter("port");
			String user = request.getParameter("uname");
			String password = request.getParameter("pword");
			
			//HttpSession session = request.getSession(true);
			
			//ConnectionBean bean = new ConnectionBean(host, port, user, password);
			ConnectionInfo.createNewConnection(host, port, user, password);
			//Dao d = new 
			out.print("ok");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
			out.print(e.getMessage());
		}
		
	}

}
