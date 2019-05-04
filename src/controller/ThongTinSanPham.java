package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CommentDAO;
import dao.ManufacturerDAO;
import dao.ProductDAO;
import model.Comment;
import model.Manufacturer;
import model.Product;

@WebServlet("/ThongTinSanPham")
public class ThongTinSanPham extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
    public ThongTinSanPham() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Manufacturer> manufs = ManufacturerDAO.getManufs();
		request.setAttribute("manufs", manufs);
		
		Product product = new Product(Integer.parseInt(request.getParameter("productId")));
		ProductDAO.getProduct(product);
		request.setAttribute("product", product);
		
		List<Product> comparisonProducts = ProductDAO.getComparisonProducts(ProductDAO.getProducts(), product);
		request.setAttribute("comparisonProducts", comparisonProducts);
		
		List<Comment> comments = CommentDAO.getComments(product);
		request.setAttribute("comments", comments);
		
		request.getRequestDispatcher("/WEB-INF/ThongTinSanPham.jsp").forward(request, response);
	}
}
