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

@WebServlet("/TrangChu")
public class TrangChu extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
    public TrangChu() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Manufacturer> manufs = ManufacturerDAO.getManufs();
		request.setAttribute("manufs", manufs);
		
		List<Product> hotProducts = ProductDAO.getHotProducts();
		request.setAttribute("hotProducts", hotProducts);
		
		List<Product> newProducts = ProductDAO.getNewProducts();
		request.setAttribute("newProducts", newProducts);
		
		request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);
	}
}
