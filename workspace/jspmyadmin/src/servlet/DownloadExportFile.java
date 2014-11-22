package servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import utils.ConnectionInfo;
import bean.ConnectionBean;
import dao.Dao;

/**
 * Servlet implementation class DownloadExportFile
 */
@WebServlet("/downloadExportFile")
public class DownloadExportFile extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final String sep = File.separator;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DownloadExportFile() {
		super();
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	@SuppressWarnings("resource")
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String db = request.getParameter("db").toString();
		String fileName = request.getParameter("name");
		String fileExt = request.getParameter("ext");
		String temp = System.getProperty("user.home") + sep + "sql_"
				+ new Random().nextInt(100) + fileExt;
		String mysqldPath = "";
		ConnectionBean cb = ConnectionInfo.getInfo();
		try {
			mysqldPath = new Dao(cb).getMySQLDir();
			
			Process runtimeProcess;
			String[] executeCmds = new String[] {
					mysqldPath + File.separator+"bin"+File.separator+"mysqldump", "--user=" + cb.getUser(),
					db, "--add-drop-database", "-r", temp };

			runtimeProcess = Runtime.getRuntime().exec(executeCmds);

			File f = new File(temp);
			// Process runtimeProcess = Runtime.getRuntime().exec(executeCmd);
			int processComplete = runtimeProcess.waitFor();
			if ((processComplete == 0 || System.getProperty("os.name").equals(
					"Linux"))
					&& f.exists()) {

				response.setHeader("Content-Disposition",
						"attachment; filename=\"" + fileName + fileExt + "\"");
				ServletOutputStream sos = response.getOutputStream();

				InputStream inputStream = new FileInputStream(f);
				byte[] buffer = new byte[1024 * 2];
				int bytesRead = 0;
				do {
					bytesRead = inputStream.read(buffer, 0, buffer.length);
					sos.write(buffer, 0, bytesRead);
				} while (bytesRead == buffer.length);
				sos.flush();
				sos.close();
				// f.delete();

			} else {

				System.out.println("Could not take mysql backup");

			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
