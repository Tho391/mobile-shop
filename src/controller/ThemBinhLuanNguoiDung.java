package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CommentDAO;
import model.Comment;
import model.Product;

@WebServlet("/ThemBinhLuanNguoiDung")
public class ThemBinhLuanNguoiDung extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
    public ThemBinhLuanNguoiDung() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Product product = new Product(Integer.parseInt(request.getParameter("productId")));
		
		String content = request.getParameter("comment");
		String name = request.getParameter("name");
		String answerCommentId = request.getParameter("answerCommentId");
		
		Comment comment = new Comment();
		comment.setContent(content);
		comment.setPersonName(name);
		if (request.getParameter("sex").equals("male")) {
			comment.setPersonSex(true);
		} else {
			comment.setPersonSex(false);
		}
		if (answerCommentId != null) {
			comment.setAnswerComment(new Comment(Integer.parseInt(answerCommentId)));
		} else {
			comment.setAnswerComment(null);
		}
		comment.setProduct(product);
		
		CommentDAO.insertComment(comment);
		response.sendRedirect(request.getContextPath() + "/ThongTinSanPham?productId=" + product.getId());
	}
}
