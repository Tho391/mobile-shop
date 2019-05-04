package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import db.DbConnection;
import model.Account;
import model.Comment;
import model.Product;

public class CommentDAO {
	public static List<Comment> getComments(Product product) {
		List<Comment> comments = new ArrayList<Comment>();
		Connection con = null;
		CallableStatement statement = null;
		ResultSet result = null;

		try {
			con = DbConnection.getInstance().getConnection();

			statement = con.prepareCall("{call layDsBinhLuanTheoSanPhamMS(?)}");
			statement.setInt(1, product.getId());
			result = statement.executeQuery();

			while (result.next()) {
				Comment comment = new Comment();
				comment.setId(result.getInt(1));
				comment.setContent(result.getString(2));
				comment.setTime(result.getTimestamp(3));
				comment.setPersonName(result.getString(4));
				comment.setPersonSex(result.getBoolean(5));
				if (result.getString(6) == null) {
					comment.setAnswerAccount(null);
				} else {
					Account acc = new Account();
					acc.setDisplayName(result.getString(6));
					acc.setSex(result.getBoolean(7));
					comment.setAnswerAccount(acc);
				}

				comments.add(comment);
			}

			if (statement != null) {
				statement.close();
				statement = null;
			}

			for (Comment item : comments) {
				item.setComments(getCommentsByCommentId(con, item));
				for (Comment item1 : item.getComments()) {
					item1.setComments(getCommentsByCommentId(con, item1));
				}
			}
		} catch (SQLException e) {
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

		return comments;
	}

	public static List<Comment> getCommentsByCommentId(Connection con, Comment comment) {
		List<Comment> comments = new ArrayList<Comment>();
		CallableStatement statement = null;
		ResultSet result = null;

		try {
			statement = con.prepareCall("{call layDsBinhLuanTheoBinhLuanMS(?)}");
			statement.setInt(1, comment.getId());
			result = statement.executeQuery();

			while (result.next()) {
				Comment cmt = new Comment();
				cmt.setId(result.getInt(1));
				cmt.setContent(result.getString(2));
				cmt.setTime(result.getTimestamp(3));
				cmt.setPersonName(result.getString(4));
				cmt.setPersonSex(result.getBoolean(5));
				if (result.getString(6) == null) {
					cmt.setAnswerAccount(null);
				} else {
					Account acc = new Account();
					acc.setDisplayName(result.getString(6));
					acc.setSex(result.getBoolean(7));
					cmt.setAnswerAccount(acc);
				}

				comments.add(cmt);
			}
		} catch (SQLException e) {
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

		return comments;
	}

	public static boolean insertComment(Comment comment) {
		boolean error = false;
		Connection con = null;
		CallableStatement statement = null;

		try {
			con = DbConnection.getInstance().getConnection();
			statement = con.prepareCall("{call themBinhLuanNguoiDung(?, ?, ?, ?, ?)}");
			statement.setString(1, comment.getContent());
			statement.setString(2, comment.getPersonName());
			statement.setBoolean(3, comment.getPersonSex());
			if (comment.getAnswerComment() == null) {
				statement.setNull(4, Types.INTEGER);
			} else {
				statement.setInt(4, comment.getAnswerComment().getId());
			}
			statement.setInt(5, comment.getProduct().getId());

			statement.executeUpdate();
		} catch (SQLException e) {
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
