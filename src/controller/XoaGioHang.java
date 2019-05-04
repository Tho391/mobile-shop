package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Order;

@WebServlet("/XoaGioHang")
public class XoaGioHang extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
    public XoaGioHang() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Order order = (Order)request.getSession().getAttribute("order");
		if (order != null) {
			request.getSession().removeAttribute("order");
		}
		response.sendRedirect(request.getContextPath() + "/TrangChu");
	}
}
