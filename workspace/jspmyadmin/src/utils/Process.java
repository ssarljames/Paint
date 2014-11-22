package utils;

import java.io.IOException;

public class Process {
	public static java.lang.Process exec(String command, boolean wait){
		java.lang.Process p;
		try {
			p = Runtime.getRuntime().exec(command);
		} catch (IOException e) {
			return null;
		}
		if (wait) {
			try {
				p.waitFor();
			} catch (InterruptedException e) {
				Thread.currentThread().interrupt();
			}
		}
		// You must close these even if you never use them!
		try {
			p.getOutputStream().write(null);
			p.getOutputStream().close();
			p.getInputStream().close();
			p.getErrorStream().close();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return p;
	} // end exec
}
