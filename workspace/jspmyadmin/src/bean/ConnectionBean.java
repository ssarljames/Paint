package bean;

public class ConnectionBean {
	private String host = "";
	private String port = "";
	private String user = "";
	private String password = "";
	
	
	
	public ConnectionBean(String host, String port, String user, String password) {
		super();
		this.host = host;
		this.port = port;
		this.user = user;
		this.password = password;
	}
	
	public String getHost() {
		return host;
	}
	public String getPort() {
		return port;
	}
	public String getUser() {
		return user;
	}
	public String getPassword() {
		return password;
	}
}
