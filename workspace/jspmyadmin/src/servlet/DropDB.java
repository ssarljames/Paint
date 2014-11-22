package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import utils.ConnectionInfo;
import dao.Dao;

@WebServlet("/dropDB")
public class DropDB extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public DropDB() {
        super();
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String db = request.getParameter("db");
		PrintWriter out = response.getWriter();
		String msg = "error";
		try {
			Dao d = new Dao(ConnectionInfo.getInfo());
			msg = d.dropDB(db);
			d.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
		System.out.println(db);
		out.print(msg);
	}

}
