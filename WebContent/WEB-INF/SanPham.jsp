<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Điện thoại di động</title>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz"
        crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/product.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/filter.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/manufacturer.css">
</head>

<body>
    <header>
        <div class="nav-top">
            <a class="nav-logo" href="${pageContext.request.contextPath}/">
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
            
            <h3 class="title">${manuf.name}</h3>

            <div class="filter">
                <button type="button" class="btn btn-info" data-toggle="collapse" data-target="#demo">
                    <i class="fa fa-bars"></i>
                </button>
                <a href="${pageContext.request.contextPath}/SanPham<c:if test="${manuf.id != -1}">?manufId=${manuf.id}</c:if> 
                  " class="none-filter-btn">Xóa bộ lọc</a>
                <p class="filter-title">LỌC SẢN PHẨM</p>

                <form action="${pageContext.request.contextPath}/SanPham" method="get">
                	<c:if test="${manuf.id != -1}">
                		<input type="hidden" name="manufId" value="${manuf.id}">
                	</c:if>
                    <div id="demo" class="collapse">
                        <div class="container-fluid">
                            <div class="row">
                                <div class="col-sm-6 col-md-3 col-lg-3 filter-container">
                                    <p class="sub-filter-title">Giá</p>
                                    <label>
                                        <input type="checkbox" name="gia0" value="d2"
                                        	<c:if test="${priceFilter[0] == true}">
                                        		checked
                                        	</c:if>
                                        >
                                        Dưới 2 triệu
                                    </label>
                                    <label>
                                        <input type="checkbox" name="gia1" value="t2d4"
                                        	<c:if test="${priceFilter[1] == true}">
                                        		checked
                                        	</c:if>
                                        >
                                        Từ 2 đến 4 triệu
                                    </label>
                                    <label>
                                        <input type="checkbox" name="gia2" value="t4d7"
                                        	<c:if test="${priceFilter[2] == true}">
                                        		checked
                                        	</c:if>
                                        >
                                        Từ 4 đến 7 triệu
                                    </label>
                                    <label>
                                        <input type="checkbox" name="gia3" value="t7d13"
                                        	<c:if test="${priceFilter[3] == true}">
                                        		checked
                                        	</c:if>
                                        >
                                        Từ 7 đến 13 triệu
                                    </label>
                                    <label>
                                        <input type="checkbox" name="gia4" value="t13"
                                        	<c:if test="${priceFilter[4] == true}">
                                        		checked
                                        	</c:if>
                                        >
                                        Trên 13 triệu
                                    </label>
                                </div>
                                <div class="col-sm-6 col-md-3 col-lg-3 filter-container">
                                    <p class="sub-filter-title">Màn hình</p>
                                    <label>
                                        <input type="checkbox" name="mh0" value="k3"
                                        	<c:if test="${screenSizeFilter[0] == true}">
                                        		checked
                                        	</c:if>
                                        >
                                        Khoảng 3"
                                    </label>
                                    <label>
                                        <input type="checkbox" name="mh1" value="k4"
                                        	<c:if test="${screenSizeFilter[1] == true}">
                                        		checked
                                        	</c:if>
                                        >
                                        Khoảng 4"
                                    </label>
                                    <label>
                                        <input type="checkbox" name="mh2" value="k5"
                                        	<c:if test="${screenSizeFilter[2] == true}">
                                        		checked
                                        	</c:if>
                                        >
                                        Khoảng 5"
                                    </label>
                                    <label>
                                        <input type="checkbox" name="mh3" value="k6"
                                        	<c:if test="${screenSizeFilter[3] == true}">
                                        		checked
                                        	</c:if>
                                        >
                                        Khoảng 6"
                                    </label>
                                </div>
                                <div class="col-sm-6 col-md-3 col-lg-3 filter-container">
                                    <p class="sub-filter-title">Tính năng</p>
                                    <label>
                                        <input type="checkbox" name="tn0" value="chong-nuoc"
                                        	<c:if test="${functionFilter[0] == true}">
                                        		checked
                                        	</c:if>
                                        >
                                        Chống nước
                                    </label>
                                    <label>
                                        <input type="checkbox" name="tn1" value="camera-kep"
                                        	<c:if test="${functionFilter[1] == true}">
                                        		checked
                                        	</c:if>
                                        >
                                        Camera kép
                                    </label>
                                    <label>
                                        <input type="checkbox" name="tn2" value="sac-nhanh"
                                        	<c:if test="${functionFilter[2] == true}">
                                        		checked
                                        	</c:if>
                                        >
                                        Sạc pin nhanh
                                    </label>
                                    <label>
                                        <input type="checkbox" name="tn3" value="khuon-mat"
                                        	<c:if test="${functionFilter[3] == true}">
                                        		checked
                                        	</c:if>
                                        >
                                        Bảo mật khuôn mặt
                                    </label>
                                    <label>
                                        <input type="checkbox" name="tn4" value="van-tay"
                                        	<c:if test="${functionFilter[4] == true}">
                                        		checked
                                        	</c:if>
                                        >
                                        Bảo mật vân tay
                                    </label>
                                </div>
                                <div class="col-sm-6 col-md-3 col-lg-3 filter-container">
                                    <p class="sub-filter-title">Sắp xếp</p>
                                    <label>
                                        <input type="radio" name="sx" value="tang" 
                                        	<c:if test="${sx == 'tang'}">
                                        		checked
                                        	</c:if>
                                        >
                                        Sắp xếp giá tăng dần
                                    </label>
                                    <label>
                                        <input type="radio" name="sx" value="giam" 
                                        	<c:if test="${sx == 'giam'}">
                                        		checked
                                        	</c:if>
                                        >
                                        Sắp xếp giá giảm dần
                                    </label>
                                </div>
                            </div>
                        </div>
                        <button type="submit" class="filter-btn">Xem kết quả</button>
                    </div>
                </form>
            </div>

            <div class="product">
                <div class="container-fluid">
                    <div class="row">
                    	<c:forEach var="product" items="${manuf.products}">
	                        <div class="col-sm-6 col-md-3 col-lg-3 product-container">
	                            <a class="product-href" href="${pageContext.request.contextPath}/ThongTinSanPham?productId=${product.id}">
	                                <div class="product-item">
	                                    <div class="product-info">
	                                        <img src="data:image/jpeg;base64,${product.imageBase64}" alt="" width="200" height="200">
	                                        <p class="phone-name">${product.name}</p>
	                                        <p class="phone-cost">${product.money}</p>
	                                        <a class="buy-btn" href="${pageContext.request.contextPath}/GioHang?productId=${product.id}">Mua</a>
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