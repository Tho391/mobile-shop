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

@WebServlet("/SanPham")
public class SanPham extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public SanPham() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<Manufacturer> manufs = ManufacturerDAO.getManufs();
		request.setAttribute("manufs", manufs);

		String manufId = request.getParameter("manufId");
		Manufacturer manuf = new Manufacturer();
		if (manufId == null) {
			manuf.setId(-1);
		} else {
			manuf.setId(Integer.parseInt(manufId));
		}
		ManufacturerDAO.getManuf(manuf);

		// Price filter
		boolean[] priceFilter = new boolean[5];
		for (int i = 0; i < priceFilter.length; i++) {
			if (request.getParameter("gia" + i) != null) {
				priceFilter[i] = true;
			} else {
				priceFilter[i] = false;
			}
		}
		manuf.setProducts(ProductDAO.priceFilter(manuf.getProducts(), priceFilter));
		request.setAttribute("priceFilter", priceFilter);

		// Screen size filter
		boolean[] screenSizeFilter = new boolean[4];
		for (int i = 0; i < screenSizeFilter.length; i++) {
			if (request.getParameter("mh" + i) != null) {
				screenSizeFilter[i] = true;
			} else {
				screenSizeFilter[i] = false;
			}
		}
		manuf.setProducts(ProductDAO.screenSizeFilter(manuf.getProducts(), screenSizeFilter));
		request.setAttribute("screenSizeFilter", screenSizeFilter);

		// Function filter
		boolean[] functionFilter = new boolean[5];
		for (int i = 0; i < functionFilter.length; i++) {
			if (request.getParameter("tn" + i) != null) {
				functionFilter[i] = true;
			} else {
				functionFilter[i] = false;
			}
		}
		manuf.setProducts(ProductDAO.functionFilter(manuf.getProducts(), functionFilter));
		request.setAttribute("functionFilter", functionFilter);

		// Sort
		String sx = request.getParameter("sx");
		if (sx == null || sx.equals("tang")) {
			if (sx == null) {
				sx = "tang";
			}
			ProductDAO.sortAsc(manuf.getProducts());
		} else {
			ProductDAO.sortDesc(manuf.getProducts());
		}
		request.setAttribute("sx", sx);

		request.setAttribute("manuf", manuf);

		request.getRequestDispatcher("/WEB-INF/SanPham.jsp").forward(request, response);
	}
}
