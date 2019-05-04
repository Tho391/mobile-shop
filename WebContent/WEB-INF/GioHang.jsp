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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/cart.css">
    
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
            <form action="${pageContext.request.contextPath}/GioHang" method="post" accept-charset="UTF-8">
                <div class="container-item left-container">
                    <div class="products section-item">
                    	<c:forEach var="orderDetail" items="${order.orderDetails}" varStatus="loop">
	                        <div class="product">
	                        	<input type="hidden" name="product${loop.index}Id" value="${orderDetail.product.id}">
	                            <div class="img-container">
	                                <img src="data:image/jpeg;base64,${orderDetail.product.imageBase64}" alt="${orderDetail.product.name}" width="100px" height="100">
	                            </div>
	                            <div class="product-option">
	                                <h5>
	                                    <a class="product-name" href="${pageContext.request.contextPath}/ThongTinSanPham?productId=${orderDetail.product.id}">
	                                        <strong>${orderDetail.product.name}</strong>
	                                    </a>
	                                </h5>
	                                <h5 class="product-cost"><strong>${orderDetail.product.money}</strong></h5>
	                                <span>Màu sắc</span>
	                                <select name="product${loop.index}Color">
	                                   	<c:forEach var="color" items="${orderDetail.product.colors}">
	                                   		<option value="${color}"
	                                   			<c:if test="${orderDetail.color == color}">
	                                   				selected
	                                   			</c:if>
	                                   		>${color}</option>
	                                   	</c:forEach>
	                                </select>
	                                <br>
	                                <span>Số lượng</span>
	                                <div class="amount-container">
	                                    <button type="button" class="dec" onclick="dec(${loop.index})">-</button>
	                                    <input type="text" class="product-amount" name="product${loop.index}Amount"
	                                        value="${orderDetail.amountProduct}" required readonly>
	                                    <button type="button" class="inc" onclick="inc(${loop.index})">+</button>
	                                </div>
	                                <input type="hidden" name="product${loop.index}Price" value="${orderDetail.product.price}">
	                                <button class="del-prod" onclick="delProduct('${orderDetail.product.id}')">Xóa</button>
	                            </div>
	                        </div>
	                        <hr>
                        </c:forEach>
                        
                        <button class="del-prod" onclick="delCart()">Xóa giỏ hàng</button>
                        <span>Tổng tiền:</span>
                        <span id="sum"><strong>${order.money}</strong></span>
                        
                    </div>

                </div>
                <div class="container-item right-container">
                    <div class="emp-info section-item">
                        <h4>Thông tin khách hàng</h4>
                        <h5 class="sub-title">Họ tên</h5>
                        <input type="text" name="name" required autocomplete="off">
                        <h5 class="sub-title">Số điện thoại</h5>
                        <input type="text" name="phone" required autocomplete="off">
                        <h5 class="sub-title">Giới tính</h5>
                        <label>
                            <input type="radio" name="sex" value="male" checked>
                            Anh
                        </label>
                        <label>
                            <input type="radio" name="sex" value="female">
                            Chị
                        </label>
                        
                        <hr>
                        <h4>Địa chỉ giao hàng</h4>
                        <input type="text" name="address" required autocomplete="off">
                       
                       
                        <a class="nav-btn cont-buy-href" href="${pageContext.request.contextPath}/SanPham">Tiếp tục mua hàng</a>
                        <input class="nav-btn accept-btn" type="submit" value="Xác nhận">
                    </div>
                </div>
            </form>
        </div>
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
    
    <c:if test="${insertOrderError == true}">
	    <script>
	        $(document).ready(function () {
	            setTimeout(function () {
	                window.alert("Đã có lỗi xảy ra");
	            }, 100);
	        });
	    </script>
    </c:if>

	<script>
        function delProduct(productId) {
            if (window.confirm("Bạn chắc chắn muốn xóa?")) {
                window.location = "${pageContext.request.contextPath}/XoaSanPhamTrongGioHang?productId=" + productId;
            }
        }
    </script>
    
    <script>
        function delCart() {
            if (window.confirm("Bạn chắc chắn muốn xóa?")) {
                window.location = "${pageContext.request.contextPath}/XoaGioHang";
            }
        }
    </script>

	<script>
        function inc(n) {
            var text = document.getElementsByName("product" + n + "Amount")[0];
            if (text.value < 10) {
                text.value++;
            }
            changeValueOfCart();
        }

        function dec(n) {
            var text = document.getElementsByName("product" + n + "Amount")[0];
            if (text.value > 1) {
                text.value--;
            }
            changeValueOfCart();
        }

        function changeValueOfCart() {
//             var sum = document.getElementById("sum");
//             sum.innerHTML = "<strong>1000<strong>";
        }
    </script>
</body>

</html>