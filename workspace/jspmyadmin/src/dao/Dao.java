package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;

import utils.ConnectionInfo;
import bean.ConnectionBean;
import connection.Myconnection;

public class Dao extends Myconnection {

	public Dao(ConnectionBean bean) throws SQLException {
		super(bean);
		// TODO Auto-generated constructor stub
	}

	public Dao(ConnectionBean bean, String db) throws SQLException {
		super(bean, db);
		// TODO Auto-generated constructor stub
	}

	public ArrayList<String> getDatabases() {
		ArrayList<String> db = new ArrayList<String>();
		try {
			result = conn.createStatement().executeQuery("show databases;");
			while (result.next()) {
				try {
					String database = result.getString(1);
					db.add(database);
				} catch (Exception e) {
					db.add(" ???? ");
				}
			}
			result.close();
			conn.close();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
			db.clear();
			db.add("error");
		}
		return db;
	}

	public ArrayList<String> getTables(String dbName) {
		ArrayList<String> tables = new ArrayList<String>();
		try {
			result = conn.createStatement().executeQuery(
					"show tables from " + dbName);
			while (result.next()) {
				String database = result.getString(1);
				tables.add(database);
			}
			result.close();
			conn.close();
		} catch (SQLException e) {
			System.err.println(e.getMessage());
		}
		return tables;
	}

	public ArrayList<ArrayList<String>> executeQuery(String q)
			throws SQLException {
		ArrayList<ArrayList<String>> retVal = new ArrayList<ArrayList<String>>();
		// ResultSet rs = conn.createStatement().executeQuery(q);

		PreparedStatement stmt = conn.prepareStatement(q);
		stmt.execute();
		try {
			ResultSet rs = stmt.getResultSet();
			ResultSetMetaData rsmd = rs.getMetaData();
			int columnCount = rsmd.getColumnCount();
			ArrayList<String> columnNames = new ArrayList<String>();
			for (int i = 1; i < columnCount + 1; i++) {
				String name = rsmd.getColumnName(i);
				columnNames.add(name);
			}
			retVal.add(columnNames);
			while (rs.next()) {
				ArrayList<String> row = new ArrayList<String>();
				for (int i = 1; i < columnCount + 1; i++) {
					String name = rs.getString(i);
					row.add(name);
				}
				retVal.add(row);
			}
			rs.close();
			stmt.close();
			conn.close();
		} catch (Exception e) {
			System.err.println("executeQuery() : "+e.getMessage());
		}
		return retVal;
	}

	public String getMySQLDir() {
		String path = "";

		try {
			ResultSet result = conn.createStatement().executeQuery("select @@basedir");
			while (result.next()) {
				path = result.getString(1);
			}
			this.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return path;
	}

	public String addDB(String db) {
		String msg = "";

		try {
			conn.createStatement().executeUpdate("create database "+db);
		} catch (SQLException e) {
			// TODO Auto-generated catch block	
			msg = e.getMessage();
		}

		return msg;
	}


	public String dropDB(String db) {
		String msg = "";

		try {
			conn.createStatement().executeUpdate("drop database "+db);
		} catch (SQLException e) {
			// TODO Auto-generated catch block	
			msg = e.getMessage();
		}

		return msg;
	}

	public static void main(String[] args) {
		try {
			System.out.println(new Dao(ConnectionInfo.getInfo()).getMySQLDir());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}