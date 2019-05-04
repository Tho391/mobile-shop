package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;

import db.DbConnection;
import model.Order;

public class OrderDAO {
	public static boolean insertOrder(Order order) {
		boolean error = false;
		Connection con = null;
		CallableStatement statement = null;

		try {
			con = DbConnection.getInstance().getConnection();
			con.setAutoCommit(false);
			
			statement = con.prepareCall("{call themDonHang(?, ?, ?, ?, ?)}");
			statement.setString(1, order.getPersonName());
			statement.setBoolean(2, order.getPersonSex());
			statement.setString(3, order.getPersonPhone());
			statement.setString(4, order.getPersonAddress());
			statement.setInt(5, order.getValue());

			statement.executeUpdate();
			
			if (statement != null) {
				statement.close();
				statement = null;
			}
			
			statement = con.prepareCall("{ ? = call layMaDonHang()}");
			statement.registerOutParameter(1, Types.INTEGER);
			statement.execute();
			
			order.setId(statement.getInt(1));
			
			OrderDetailDAO.insertOrderDetail(con, order);
			
			con.commit();
		} catch (SQLException e) {
			try {
				con.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			error = true;
			e.printStackTrace();
		} finally {
			if (statement != null) {
				try {
					statement.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
		return error;
	}
}
