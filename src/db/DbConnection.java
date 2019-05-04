package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConnection {
//	static final String url = "jdbc:mysql://localhost:3306/mobile_store" + "?useUnicode=yes&characterEncoding=UTF-8";
//	static final String user = "root";
//	static final String password = "123456";
	static final String url = "jdbc:mysql://aaaxld1nlje8fv.cmuawpxdv6pg.us-east-2.rds.amazonaws.com:3306/mobile_store";
	static final String user = "root";
	static final String password = "123456ty";
//	static final String url = "jdbc:mysql://mydb.cvr0svowjwnv.ap-southeast-1.rds.amazonaws.com:3306/mobile_store";
//	static final String user = "root";
//	static final String password = "12345678";

	static DbConnection instance;

	public static DbConnection getInstance() {
		if (instance == null) {
			instance = new DbConnection();
		}
		return instance;
	}

	private DbConnection() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	public Connection getConnection() {
		Connection con = null;

		try {
			con = DriverManager.getConnection(url, user, password);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return con;
	}
}
