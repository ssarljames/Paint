package servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;

import dao.Dao;

import utils.ConnectionInfo;

import bean.ConnectionBean;

/**
 * Servlet implementation class ImportDB
 */
@WebServlet("/importDB")
public class ImportDB extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ImportDB() {
        super();
        // TODO Auto-generated constructor stub
    }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String db = request.getParameter("db");
		String filename = request.getParameter("name");
		InputStream is = request.getInputStream();
		File tempFile = new File("temp_"+new Random().nextInt(100)+filename);
		ConnectionBean cb = ConnectionInfo.getInfo();
		PrintWriter out = response.getWriter();
		try {
			byte[] buffer = new byte[1024*4];
			int bytesRead = 0;
			tempFile.createNewFile();
			FileOutputStream fos = new FileOutputStream(tempFile);
			/*do {
				bytesRead = is.read(buffer, 0, buffer.length);
				fos.write(buffer, 0, bytesRead);
			} while (bytesRead == buffer.length);
			 */
			fos.write(IOUtils.toByteArray(is));
			fos.flush();
			fos.close();

			String mysqldPath = new Dao(cb).getMySQLDir();
			//String[] executeCmd = new String[]{mysqldPath+"/bin/mysql", "--user=" + cb.getUser(), "--password=" + cb.getPassword(),db, "-e", "source "+tempFile};
			String[] executeCmd = new String[]{mysqldPath+"/bin/mysql", "--user=" + cb.getUser(),db, "-e", "source "+tempFile};
			for (String string : executeCmd) {
				System.out.println(string);
			}
	        Process runtimeProcess;
	        try {
	 
	            runtimeProcess = Runtime.getRuntime().exec(executeCmd);
	            int processComplete = runtimeProcess.waitFor();
	 
	            if (processComplete == 0) {
	                out.println("Backup restored successfully!!!!");
	            } else {
	                out.println("Could not restore the backup");
	            }
	        } catch (Exception ex) {
	            ex.printStackTrace();
	        }
		}catch (Exception e) {
            out.println(e.getMessage());
		}

		tempFile.delete();
		//System.out.println(tempFile.getAbsolutePath());
	}

}
