package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import model.Order;
import model.OrderDetail;

public class OrderDetailDAO {
	public static void insertOrderDetail(Connection con, Order order) {
		CallableStatement statement = null;

		try {
			for (OrderDetail item : order.getOrderDetails()) {
				statement = con.prepareCall("{call themChiTietDonHang(?, ?, ?, ?, ?)}");
				statement.setInt(1, order.getId());
				statement.setInt(2, item.getProduct().getId());
				statement.setInt(3, item.getAmountProduct());
				statement.setInt(4, item.getUnitPrice());
				statement.setString(5, item.getColor());
				
				statement.executeUpdate();
				
				if (statement != null) {
					statement.close();
					statement = null;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (statement != null) {
				try {
					statement.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
}
