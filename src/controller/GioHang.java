package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.OrderDAO;
import dao.ProductDAO;
import model.Order;
import model.OrderDetail;
import model.Product;

@WebServlet("/GioHang")
public class GioHang extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public GioHang() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String productId = request.getParameter("productId");

		Order order = (Order) request.getSession().getAttribute("order");
		if (order == null) {
			if (productId == null) {
				response.sendRedirect(request.getContextPath() + "/TrangChu");
				return;
			}

			order = new Order();

			order.setOrderDetails(new ArrayList<OrderDetail>());
			request.getSession().setAttribute("order", order);
		}

		if (productId != null) {
			boolean hasProduct = false;
			for (OrderDetail item : order.getOrderDetails()) {
				if (item.getProduct().getId() == Integer.parseInt(productId)) {
					hasProduct = true;
					break;
				}
			}

			if (hasProduct == false) {
				Product product = new Product(Integer.parseInt(productId));
				ProductDAO.getProduct(product);

				OrderDetail orderDetail = new OrderDetail();
				orderDetail.setProduct(product);
				orderDetail.setAmountProduct(1);
				orderDetail.setUnitPrice(product.getPrice());
				orderDetail.setColor(product.getColors().get(0));

				order.getOrderDetails().add(orderDetail);

				int value = 0;
				for (OrderDetail item : order.getOrderDetails()) {
					value += item.getProduct().getPrice() * item.getAmountProduct();
				}
				order.setValue(value);
			}
		}

		request.setAttribute("order", order);
		
		Boolean insertOrderError = (Boolean) getServletContext().getAttribute("insertOrderError");
		if (insertOrderError != null) {
			getServletContext().removeAttribute("insertOrderError");
		} else {
			insertOrderError = false;
		}
		request.setAttribute("insertOrderError", insertOrderError);
		
		request.getRequestDispatcher("/WEB-INF/GioHang.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		Order order = new Order();
		List<OrderDetail> orderDetails = new ArrayList<OrderDetail>();
		order.setOrderDetails(orderDetails);

		int i = 0;
		while (true) {
			String productId = request.getParameter("product" + i + "Id");
			if (productId == null) {
				break;
			}
			Product product = new Product(Integer.parseInt(productId));
			String productPrice = request.getParameter("product" + i + "Price");
			String productColor = request.getParameter("product" + i + "Color");
			String productAmount = request.getParameter("product" + i + "Amount");

			OrderDetail orderDetail = new OrderDetail();
			orderDetail.setProduct(product);
			orderDetail.setUnitPrice(Integer.parseInt(productPrice));
			orderDetail.setColor(productColor);
			orderDetail.setAmountProduct(Integer.parseInt(productAmount));

			orderDetails.add(orderDetail);
			i++;
		}

		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");

		order.setPersonName(name);
		order.setPersonPhone(phone);
		order.setPersonAddress(address);
		if (request.getParameter("sex").equals("male")) {
			order.setPersonSex(true);
		} else {
			order.setPersonSex(false);
		}

		int value = 0;
		for (OrderDetail item : order.getOrderDetails()) {
			value += item.getUnitPrice() * item.getAmountProduct();
		}
		order.setValue(value);
		
		boolean insertOrderError = OrderDAO.insertOrder(order);
		if (insertOrderError == true) {
			getServletContext().setAttribute("insertOrderError", insertOrderError);
			response.sendRedirect(request.getContextPath() + "/GioHang");
		}
		else {
			request.getSession().removeAttribute("order");
			response.sendRedirect(request.getContextPath() + "/TrangChu");
		}
	}
}
