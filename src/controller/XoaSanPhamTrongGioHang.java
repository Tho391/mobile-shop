package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Order;
import model.OrderDetail;

@WebServlet("/XoaSanPhamTrongGioHang")
public class XoaSanPhamTrongGioHang extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
    public XoaSanPhamTrongGioHang() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String productId = request.getParameter("productId");
		if (productId != null) {
			Order order = (Order)request.getSession().getAttribute("order");
			if (order == null) {
				response.sendRedirect(request.getContextPath() + "/TrangChu");
				return;
			}
			
			for (OrderDetail item : order.getOrderDetails()) {
				if (item.getProduct().getId() == Integer.parseInt(productId)) {
					order.getOrderDetails().remove(item);
					
					int value = 0;
					for (OrderDetail item1 : order.getOrderDetails()) {
						value += item1.getProduct().getPrice() * item1.getAmountProduct();
					}
					order.setValue(value);
					
					break;
				}
			}
			
			if (order.getOrderDetails().size() == 0) {
				request.getSession().removeAttribute("order");
			}
		}
		response.sendRedirect(request.getContextPath() + "/GioHang");
	}
}
