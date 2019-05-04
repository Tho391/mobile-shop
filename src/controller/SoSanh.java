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

@WebServlet("/SoSanh")
public class SoSanh extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SoSanh() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Manufacturer> manufs = ManufacturerDAO.getManufs();
		request.setAttribute("manufs", manufs);
		
		Product product1 = new Product(Integer.parseInt(request.getParameter("product1Id")));
		ProductDAO.getProduct(product1);
		request.setAttribute("product1", product1);
		
		Product product2 = new Product(Integer.parseInt(request.getParameter("product2Id")));
		ProductDAO.getProduct(product2);
		request.setAttribute("product2", product2);
		
		request.getRequestDispatcher("/WEB-INF/SoSanh.jsp").forward(request, response);
	}
}
