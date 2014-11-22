package connection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;

import javax.swing.JOptionPane;

import bean.ConnectionBean;


public class Myconnection {

	protected Connection conn = null;
	protected PreparedStatement stmt = null;
	protected ResultSet result = null;
	protected String database = "";
	
	public Myconnection(ConnectionBean bean) throws SQLException{
		this.conn = getConnection(bean.getHost(), bean.getPort(),bean.getUser(),bean.getPassword());
	}

	public Myconnection(ConnectionBean bean,String database) throws SQLException{
		this.database = database;
		this.conn = getConnection(bean.getHost(), bean.getPort(),bean.getUser(),bean.getPassword());
	}
	
	public Myconnection(String host,String port,String username,String password) throws SQLException{
		this.conn = getConnection(host, port, username, password);
		
	}

	private Connection getConnection(String host,String port,String username,String password) throws SQLException{
		
		try{
			String dbDriver = "com.mysql.jdbc.Driver";
			String dbURL = "jdbc:mysql://" + host + ":" + port;
			if(!database.isEmpty())
				dbURL += "/" + database;
			//System.out.println(dbURL);
			Class.forName(dbDriver);
	    	Connection conn =  DriverManager.getConnection(dbURL, username, password);
			
		return conn;	
		}catch(Exception e){
			if(e.getMessage().contains("Communications link failure")){
				//JOptionPane.showMessageDialog(null, "Exception : "+e.getClass()+e.getMessage(), "error", JOptionPane.ERROR_MESSAGE);
				throw new SQLException("getConnection() : Server Not Found");
			}
			System.err.println("getConnection() : "+e.getMessage());
			//throw new SQLException("Server Not Found");
			return null;
		}
	}
	
	public String getServerInfo(){
		
		
		
		return "";
	}
	
	public void close() throws SQLException {
		if(conn != null)
			conn.close();
		if(stmt != null)
			stmt.close();
		if(result != null)
			result.close();
	}
	
	public static void main(String []args) {
		try {
			ConnectionBean cb = new ConnectionBean("localhost", "3306", "root", "");
			
			Myconnection mysql = new Myconnection(cb,"mysql");
			
			ResultSet rs = mysql.conn.createStatement().executeQuery("show tables;");
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnCount = rsmd.getColumnCount();
			for (int i = 1; i < columnCount + 1; i++ ) {
			  String name = rsmd.getColumnName(i);
			  System.out.print(name+" - ");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}
