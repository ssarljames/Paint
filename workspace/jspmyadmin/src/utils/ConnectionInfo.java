package utils;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

import javax.swing.JOptionPane;

import org.apache.commons.io.IOUtils;

import bean.ConnectionBean;

public class ConnectionInfo {
	
	private static File file = new File("mysql-conn.ini");
	
	
	public static void createNewConnection(String host, String port, String user, String password) {
		
		String file_content = "host="+host+
							"\nport="+port+
							"\nuser="+user+
							"\npword="+password;
		
		FileWriter fw;
		try {
			file.createNewFile();
			fw = new FileWriter(file);
			fw.write(file_content);
			fw.flush();
			fw.close();
			//System.out.println(file_content);
			System.out.println("-- "+file.getAbsolutePath());
		} catch (IOException e) {
			System.out.println("dfgdf");
			JOptionPane.showMessageDialog(null, e.getMessage());
		}
		
	}
	
	public static ConnectionBean getInfo() {
		ConnectionBean cb = null;
		
		try {
			FileReader fr = new FileReader(file);
			String file_content =  IOUtils.toString(fr);
			
			String ext[] = file_content.split("\n");
			cb = new ConnectionBean(ext[0].replaceFirst("host=", "").replaceAll("\n", ""),
					ext[1].replaceFirst("port=", "").replaceAll("\n", ""),
					ext[2].replaceFirst("user=", "".replaceAll("\n", "")),
					ext[3].replaceFirst("pword=", "").replaceAll("\n", ""));
			//System.out.println(ext[0].replaceFirst("host=", "").replaceAll("\n", ""));
		}catch (Exception e) {
			//e.printStackTrace();
			createNewConnection("localhost", "3306", "root", "");
			cb = getInfo();
		}
		
		
		return cb;
	}
	
	public static void main(String []args) {
		//ConnectionInfo ci = new ConnectionInfo();
		//ci.createNewConnection("localhost", "3306", "root", "");
		///ci.getInfo();
	}
	
}
