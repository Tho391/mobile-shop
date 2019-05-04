<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Mobile store</title>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz"
        crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/product.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/manufacturer.css">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.2/jspdf.min.js"></script>
</head>

<body>
    <header>
        <div class="nav-top">
            <a class="nav-logo" href="${pageContext.request.contextPath}/TrangChu">
                <img src="${pageContext.request.contextPath}/images/logo.png" width="50" height="auto">
                Mobile Store
            </a>
            <div class="search-container">
                <form action="${pageContext.request.contextPath}/TimKiem" method="get">
                    <input type="text" class="search-box" name="phoneName" placeholder="Tìm kiếm điện thoại">
                    <button type="submit" class="search-btn" value="">
                        <i class="fas fa-search"></i>
                    </button>
                </form>
            </div>
        </div>
    </header>

    <section>
        <div class="main-content">
            <div class="manuf">
                <h3 class="title">SẢN PHẨM HÃNG</h3>
                
                <c:forEach var="manuf" items="${manufs}">
                 	<div class=manuf-container>
	                    <a class="manuf-item" href="${pageContext.request.contextPath}/SanPham?manufId=${manuf.id}">
	                        <strong>${manuf.name}</strong>
	                    </a>
	                </div>
                </c:forEach>
                
                <div class=manuf-container>
                    <a class="manuf-item" href="${pageContext.request.contextPath}/SanPham">
                        <strong>TẤT CẢ</strong>
                    </a>
                </div>
            </div>
            <div class="hot-product">
                <h3 class="title">SẢN PHẨM HOT</h3>
                <div class="container-fluid">
                    <div class="row">
                    	<c:forEach var="hotProduct" items="${hotProducts}">
	                        <div class="col-sm-6 col-md-3 col-lg-3 product-container">
	                            <a class="product-href" href="${pageContext.request.contextPath}/ThongTinSanPham?productId=${hotProduct.id}">
	                                <div class="product-item">
	                                    <div class="product-info">
	                                        <img src="data:image/jpeg;base64,${hotProduct.imageBase64}" alt="" width="200" height="200">
	                                        <p class="phone-name">${hotProduct.name}</p>
	                                        <p class="phone-cost">${hotProduct.money}</p>
	                                        <a class="buy-btn" href="${pageContext.request.contextPath}/GioHang?productId=${hotProduct.id}">Mua</a>
	                                    </div>
	                                </div>
	                            </a>
	                        </div>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <div class="new-product">
                <h3 class="title">SẢN PHẨM MỚI</h3>
                <div class="container-fluid">
                    <div class="row">
                        <c:forEach var="newProduct" items="${newProducts}">
	                        <div class="col-sm-6 col-md-3 col-lg-3 product-container">
	                            <a class="product-href" href="${pageContext.request.contextPath}/ThongTinSanPham?productId=${newProduct.id}">
	                                <div class="product-item">
	                                    <div class="product-info">
	                                        <img src="data:image/jpeg;base64,${newProduct.imageBase64}" alt="" width="200" height="200">
	                                        <p class="phone-name">${newProduct.name}</p>
	                                        <p class="phone-cost">${newProduct.money}</p>
	                                        <a class="buy-btn" href="${pageContext.request.contextPath}/GioHang?productId=${newProduct.id}">Mua</a>
	                                    </div>
	                                </div>
	                            </a>
	                        </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

		<c:if test="${order != null}">
	        <a class="cart-href" href="${pageContext.request.contextPath}/GioHang">
	            <i class="fas fa-shopping-cart"></i>
	        </a>
	    </c:if>
    </section>

    <footer>
        <div class="footer-content">
            <div class="info-container">
                <h4>Về chúng tôi</h4>
                <p>Liên hệ: 0123456789</p>
                <p>Email: everyone@example.com</p>
                <p>Design: Nguyễn Duy Bảo, Nguyễn Quang Thọ, Lê Hoàng Công</p>
            </div>
            <div class="contact-container">
                <h4>Theo chúng tôi</h4>
                <img src="images/facebook.png" alt="facebook" width="40" height="40">
                <img src="images/twitter.png" alt="facebook" width="40" height="40">
            </div>
        </div>
    </footer>

</body>

</html>