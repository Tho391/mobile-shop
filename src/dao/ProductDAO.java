package dao;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import db.DbConnection;
import model.Manufacturer;
import model.Product;

public class ProductDAO {
	public static List<Product> getProducts() {
		List<Product> products = new ArrayList<Product>();
		Connection con = null;
		CallableStatement statement = null;
		ResultSet result = null;

		try {
			con = DbConnection.getInstance().getConnection();
			statement = con.prepareCall("{call layDsSanPhamMS}");
			result = statement.executeQuery();

			while (result.next()) {
				Product product = new Product();
				product.setId(result.getInt(1));
				product.setName(result.getString(2));
				product.setImageBase64(getImageBase64(result.getBlob(3)));
				product.setPrice(result.getInt(4));
				product.setScreenSize(result.getFloat(5));
				product.setWaterproof(result.getBoolean(6));
				product.setDualCamera(result.getBoolean(7));
				product.setFastCharging(result.getBoolean(8));
				product.setFaceSecurity(result.getBoolean(9));
				product.setFingerprintSecurity(result.getBoolean(10));

				products.add(product);
			}
		} catch (SQLException | IOException e) {
			e.printStackTrace();
		} finally {
			if (result != null) {
				try {
					result.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

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

		return products;
	}
	
	public static List<Product> getProducts(Connection con, Manufacturer manuf) {
		List<Product> products = new ArrayList<Product>();
		CallableStatement statement = null;
		ResultSet result = null;

		try {
			if (manuf.getId() == -1) {
				statement = con.prepareCall("{call layDsSanPhamMS}");
			} else {
				statement = con.prepareCall("{call layDsSanPhamTheoHangMS(?)}");
				statement.setInt(1, manuf.getId());
			}
			result = statement.executeQuery();

			while (result.next()) {
				Product product = new Product();
				product.setId(result.getInt(1));
				product.setName(result.getString(2));
				product.setImageBase64(getImageBase64(result.getBlob(3)));
				product.setPrice(result.getInt(4));
				product.setScreenSize(result.getFloat(5));
				product.setWaterproof(result.getBoolean(6));
				product.setDualCamera(result.getBoolean(7));
				product.setFastCharging(result.getBoolean(8));
				product.setFaceSecurity(result.getBoolean(9));
				product.setFingerprintSecurity(result.getBoolean(10));

				products.add(product);
			}
		} catch (SQLException | IOException e) {
			e.printStackTrace();
		} finally {
			if (result != null) {
				try {
					result.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

			if (statement != null) {
				try {
					statement.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}

		return products;
	}
	
	public static void getProductForCart(Product product) {
		Connection con = null;
		CallableStatement statement = null;
		ResultSet result = null;

		try {
			con = DbConnection.getInstance().getConnection();
			statement = con.prepareCall("{call laySanPhamMS(?, ?, ?, ?)}");
			statement.setInt(1, product.getId());
			statement.registerOutParameter(2, Types.VARCHAR);
			statement.registerOutParameter(3, Types.BLOB);
			statement.registerOutParameter(4, Types.INTEGER);
			statement.execute();

			product.setName(statement.getString(2));
			product.setImageBase64(getImageBase64(statement.getBlob(3)));
			product.setPrice(statement.getInt(4));

			if (statement != null) {
				statement.close();
				statement = null;
			}

			statement = con.prepareCall("{call layMauSanPham(?)}");
			statement.setInt(1, product.getId());
			result = statement.executeQuery();

			List<String> colors = new ArrayList<String>();
			while (result.next()) {
				colors.add(result.getString(1));
			}
			product.setColors(colors);
		} catch (SQLException | IOException e) {
			e.printStackTrace();
		} finally {
			if (result != null) {
				try {
					result.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

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
	}

	public static void getProduct(Product product) {
		Connection con = null;
		CallableStatement statement = null;
		ResultSet result = null;

		try {
			con = DbConnection.getInstance().getConnection();
			statement = con.prepareCall("{call laySanPham(?, ?, ?, ?, ?, ?, " + "?, ?, ?, ?, ?, ?, " + "?, ?, ?, ?, ?, "
					+ "?, ?, ?, ?, ?)}");
			statement.setInt(1, product.getId());
			statement.registerOutParameter(2, Types.VARCHAR);
			statement.registerOutParameter(3, Types.BLOB);
			statement.registerOutParameter(4, Types.INTEGER);
			statement.registerOutParameter(5, Types.FLOAT);
			statement.registerOutParameter(6, Types.VARCHAR);
			statement.registerOutParameter(7, Types.VARCHAR);
			statement.registerOutParameter(8, Types.VARCHAR);
			statement.registerOutParameter(9, Types.VARCHAR);
			statement.registerOutParameter(10, Types.VARCHAR);
			statement.registerOutParameter(11, Types.VARCHAR);
			statement.registerOutParameter(12, Types.VARCHAR);
			statement.registerOutParameter(13, Types.VARCHAR);
			statement.registerOutParameter(14, Types.VARCHAR);
			statement.registerOutParameter(15, Types.VARCHAR);
			statement.registerOutParameter(16, Types.BIT);
			statement.registerOutParameter(17, Types.BIT);
			statement.registerOutParameter(18, Types.BIT);
			statement.registerOutParameter(19, Types.BIT);
			statement.registerOutParameter(20, Types.BIT);
			statement.registerOutParameter(21, Types.BIT);
			statement.registerOutParameter(22, Types.INTEGER);

			statement.execute();

			product.setName(statement.getString(2));
			product.setImageBase64(getImageBase64(statement.getBlob(3)));
			product.setPrice(statement.getInt(4));

			if (statement.getObject(5) != null) {
				product.setScreenSize(Float.parseFloat(statement.getObject(5).toString()));
			} else {
				product.setScreenSize(null);
			}
			product.setScreenTechnology(statement.getString(6));
			product.setOs(statement.getString(7));
			product.setFrontCamera(statement.getString(8));
			product.setPosteriorCamera(statement.getString(9));
			product.setCpu(statement.getString(10));
			product.setRam(statement.getString(11));
			product.setInternalMemory(statement.getString(12));
			product.setMemoryStick(statement.getString(13));
			product.setSim(statement.getString(14));
			product.setPin(statement.getString(15));
			product.setWaterproof(statement.getBoolean(16));
			product.setDualCamera(statement.getBoolean(17));
			product.setFastCharging(statement.getBoolean(18));
			product.setFaceSecurity(statement.getBoolean(19));
			product.setFingerprintSecurity(statement.getBoolean(20));
			product.setStatus(statement.getBoolean(21));
			product.setManufacturer(new Manufacturer(statement.getInt(22)));

			if (statement != null) {
				statement.close();
				statement = null;
			}

			statement = con.prepareCall("{call layMauSanPham(?)}");
			statement.setInt(1, product.getId());
			result = statement.executeQuery();

			List<String> colors = new ArrayList<String>();
			while (result.next()) {
				colors.add(result.getString(1));
			}
			product.setColors(colors);
		} catch (SQLException | IOException e) {
			e.printStackTrace();
		} finally {
			if (result != null) {
				try {
					result.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

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
	}

	private static String getImageBase64(Blob blob) throws SQLException, IOException {
		String imageBase64 = null;

		if (blob == null) {
			return imageBase64;
		}

		InputStream inputStream = blob.getBinaryStream();
		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		byte[] buffer = new byte[4096];
		int bytesRead = -1;

		while ((bytesRead = inputStream.read(buffer)) != -1) {
			outputStream.write(buffer, 0, bytesRead);
		}

		byte[] imageBytes = outputStream.toByteArray();
		imageBase64 = Base64.getEncoder().encodeToString(imageBytes);

		inputStream.close();
		outputStream.close();

		return imageBase64;
	}

	public static List<Product> searchProducts(List<Product> products, String searchStr) {
		List<Product> entries = new ArrayList<Product>();

		if (searchStr == null) {
			searchStr = "";
		}
		searchStr = searchStr.toLowerCase();

		for (Product item : products) {
			if (item.getName().toLowerCase().contains(searchStr)) {
				entries.add(item);
			}
		}

		return entries;
	}

	public static List<Product> getHotProducts() {
		List<Product> products = new ArrayList<Product>();
		Connection con = null;
		CallableStatement statement = null;
		ResultSet result = null;

		try {
			con = DbConnection.getInstance().getConnection();
			statement = con.prepareCall("{call layDsSanPhamHotMS}");
			result = statement.executeQuery();

			while (result.next()) {
				Product product = new Product();
				product.setId(result.getInt(1));
				product.setName(result.getString(2));
				product.setImageBase64(getImageBase64(result.getBlob(3)));
				product.setPrice(result.getInt(4));

				products.add(product);
			}
		} catch (SQLException | IOException e) {
			e.printStackTrace();
		} finally {
			if (result != null) {
				try {
					result.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

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

		return products;
	}

	public static List<Product> getNewProducts() {
		List<Product> products = new ArrayList<Product>();
		Connection con = null;
		CallableStatement statement = null;
		ResultSet result = null;

		try {
			con = DbConnection.getInstance().getConnection();
			statement = con.prepareCall("{call layDsSanPhamMoiMS}");
			result = statement.executeQuery();

			while (result.next()) {
				Product product = new Product();
				product.setId(result.getInt(1));
				product.setName(result.getString(2));
				product.setImageBase64(getImageBase64(result.getBlob(3)));
				product.setPrice(result.getInt(4));

				products.add(product);
			}
		} catch (SQLException | IOException e) {
			e.printStackTrace();
		} finally {
			if (result != null) {
				try {
					result.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}

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

		return products;
	}

	public static void sortAsc(List<Product> products) {
		Product temp = new Product();
		Product temp1, temp2;
		for (int i = 0; i < products.size() - 1; i++) {
			int pos = i;
			for (int j = i + 1; j < products.size(); j++) {
				if (products.get(j).getPrice() < products.get(pos).getPrice()) {
					pos = j;
				}
			}
			if (pos != i) {
				temp1 = products.get(i);
				temp2 = products.get(pos);

				temp.setId(temp1.getId());
				temp.setName(temp1.getName());
				temp.setImageBase64(temp1.getImageBase64());
				temp.setPrice(temp1.getPrice());

				temp1.setId(temp2.getId());
				temp1.setName(temp2.getName());
				temp1.setImageBase64(temp2.getImageBase64());
				temp1.setPrice(temp2.getPrice());

				temp2.setId(temp.getId());
				temp2.setName(temp.getName());
				temp2.setImageBase64(temp.getImageBase64());
				temp2.setPrice(temp.getPrice());
			}
		}
	}
	
	public static void sortDesc(List<Product> products) {
		Product temp = new Product();
		Product temp1, temp2;
		for (int i = 0; i < products.size() - 1; i++) {
			int pos = i;
			for (int j = i + 1; j < products.size(); j++) {
				if (products.get(j).getPrice() > products.get(pos).getPrice()) {
					pos = j;
				}
			}
			if (pos != i) {
				temp1 = products.get(i);
				temp2 = products.get(pos);

				temp.setId(temp1.getId());
				temp.setName(temp1.getName());
				temp.setImageBase64(temp1.getImageBase64());
				temp.setPrice(temp1.getPrice());

				temp1.setId(temp2.getId());
				temp1.setName(temp2.getName());
				temp1.setImageBase64(temp2.getImageBase64());
				temp1.setPrice(temp2.getPrice());

				temp2.setId(temp.getId());
				temp2.setName(temp.getName());
				temp2.setImageBase64(temp.getImageBase64());
				temp2.setPrice(temp.getPrice());
			}
		}
	}
	
	public static List<Product> getComparisonProducts(List<Product> products, Product product) {
		List<Product> result = new ArrayList<Product>();
		if (product.getPrice() == null) {
			return result;
		}
		
		for (Product item : products) {
			if (item.getId() != product.getId()
				&& item.getPrice() != null && Math.abs(item.getPrice() - product.getPrice()) <= 3000000) {
				result.add(item);
			}
			if (result.size() == 4) {
				break;
			}
		}
		
		return result;
	}

	public static List<Product> priceFilter(List<Product> products, boolean[] filter) {
		for (int i = 0; i < filter.length; i++) {
			if (filter[i] == true) {
				break;
			}
			if (i == filter.length - 1) {
				return products;
			}
		}

		List<Product> result = new ArrayList<Product>();
		boolean flag = true;
		for (Product item : products) {
			if (flag && filter[0] == true) {
				if (item.getPrice() < 2000000) {
					result.add(item);
					flag = false;
				}
			}
			if (flag && filter[1] == true) {
				if (item.getPrice() >= 2000000 && item.getPrice() < 4000000) {
					result.add(item);
					flag = false;
				}
			}
			if (flag && filter[2] == true) {
				if (item.getPrice() >= 4000000 && item.getPrice() < 7000000) {
					result.add(item);
					flag = false;
				}
			}
			if (flag && filter[3] == true) {
				if (item.getPrice() >= 7000000 && item.getPrice() < 13000000) {
					result.add(item);
					flag = false;
				}
			}
			if (flag && filter[4] == true) {
				if (item.getPrice() >= 13000000) {
					result.add(item);
					flag = false;
				}
			}
			flag = true;
		}
		return result;
	}

	public static List<Product> screenSizeFilter(List<Product> products, boolean[] filter) {
		for (int i = 0; i < filter.length; i++) {
			if (filter[i] == true) {
				break;
			}
			if (i == filter.length - 1) {
				return products;
			}
		}
		List<Product> result = new ArrayList<Product>();
		boolean flag = true;
		for (Product item : products) {
			if (flag && filter[0] == true) {
				if (item.getScreenSize() != null && item.getScreenSize() >= 3 && item.getScreenSize() < 4) {
					result.add(item);
					flag = false;
				}
			}
			if (flag && filter[1] == true) {
				if (item.getScreenSize() != null && item.getScreenSize() >= 4 && item.getScreenSize() < 5) {
					result.add(item);
					flag = false;
				}
			}
			if (flag && filter[2] == true) {
				if (item.getScreenSize() != null && item.getScreenSize() >= 5 && item.getScreenSize() < 6) {
					result.add(item);
					flag = false;
				}
			}
			if (flag && filter[3] == true) {
				if (item.getScreenSize() != null && item.getScreenSize() >= 6 && item.getScreenSize() < 7) {
					result.add(item);
					flag = false;
				}
			}
			flag = true;
		}
		return result;
	}
	
	public static List<Product> functionFilter(List<Product> products, boolean[] filter) {
		for (int i = 0; i < filter.length; i++) {
			if (filter[i] == true) {
				break;
			}
			if (i == filter.length - 1) {
				return products;
			}
		}

		List<Product> result = new ArrayList<Product>();
		boolean flag = true;
		for (Product item : products) {
			if (flag && filter[0] == true) {
				if (item.getWaterproof() == true) {
					result.add(item);
					flag = false;
				}
			}
			if (flag && filter[1] == true) {
				if (item.getDualCamera() == true) {
					result.add(item);
					flag = false;
				}
			}
			if (flag && filter[2] == true) {
				if (item.getFastCharging() == true) {
					result.add(item);
					flag = false;
				}
			}
			if (flag && filter[3] == true) {
				if (item.getFaceSecurity() == true) {
					result.add(item);
					flag = false;
				}
			}
			if (flag && filter[4] == true) {
				if (item.getFingerprintSecurity() == true) {
					result.add(item);
					flag = false;
				}
			}
			flag = true;
		}
		return result;
	}
}
