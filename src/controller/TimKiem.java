package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ManufacturerDAO;
import dao.ProductDAO;
import model.Manufacturer;
import model.Product;

@WebServlet("/TimKiem")
public class TimKiem extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
    public TimKiem() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Manufacturer> manufs = ManufacturerDAO.getManufs();
		request.setAttribute("manufs", manufs);
		
		List<Product> products = ProductDAO.getProducts();
		String searchStr = request.getParameter("phoneName");
		products = ProductDAO.searchProducts(products, searchStr);
		request.setAttribute("products", products);
		
		request.getRequestDispatcher("/WEB-INF/TimKiem.jsp").forward(request, response);
	}
}
