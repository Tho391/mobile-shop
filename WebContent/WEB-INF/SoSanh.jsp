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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/compare.css">
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
                    <input type="text" class="search-box" name="phoneName" placeholder="Tìm kiếm điện thoại" required>
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
            
            <div class="comparison">
                <h3 class="title">SO SÁNH</h3>
                <div class="comparison-container">
                    <table class="comparison-table">
                        <tr>
                            <th></th>
                            <td>
                                <div class="product">
                                    <img src="data:image/jpeg;base64,${product1.imageBase64}" alt="${product1.name}" width="200" height="200">
                                    <h4>
                                        <a class="product-name" href="${pageContext.request.contextPath}/ThongTinSanPham?productId=${product1.id}">${product1.name}</a>
                                    </h4>
                                    <h4 class="product-cost">${product1.money}</h4>
                                </div>
                            </td>
                            <td>
                                <div class="product">
                                    <img src="data:image/jpeg;base64,${product2.imageBase64}" alt="${product2.name}" width="200" height="200">
                                    <h4>
                                        <a class="product-name" href="${pageContext.request.contextPath}/ThongTinSanPham?productId=${product2.id}">${product2.name}</a>
                                    </h4>
                                    <h4 class="product-cost">${product2.money}</h4>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <th>Màn hình</th>
                            <td>${product1.screenSize}  ${product1.screenTechnology}</td>
                            <td>${product2.screenSize}  ${product2.screenTechnology}</td>
                        </tr>
                        <tr>
                            <th>Hệ điều hành</th>
                            <td>${product1.os}</td>
                            <td>${product2.os}</td>
                        </tr>
                        <tr>
                            <th>Camera trước</th>
                            <td>${product1.frontCamera}</td>
                            <td>${product2.frontCamera}</td>
                        </tr>
                        <tr>
                            <th>Camera sau</th>
                            <td>${product1.posteriorCamera}</td>
                            <td>${product2.posteriorCamera}</td>
                        </tr>
                        <tr>
                            <th>CPU</th>
                            <td>${product1.cpu}</td>
                            <td>${product2.cpu}</td>
                        </tr>
                        <tr>
                            <th>RAM</th>
                            <td>${product1.ram}</td>
                            <td>${product2.ram}</td>
                        </tr>
                        <tr>
                            <th>Bộ nhớ trong</th>
                            <td>${product1.internalMemory}</td>
                            <td>${product2.internalMemory}</td>
                        </tr>
                        <tr>
                            <th>Thẻ nhớ</th>
                            <td>${product1.memoryStick}</td>
                            <td>${product2.memoryStick}</td>
                        </tr>
                        <tr>
                            <th>Thẻ sim</th>
                            <td>${product1.sim}</td>
                            <td>${product2.sim}</td>
                        </tr>
                        <tr>
                            <th>Dung lượng pin</th>
                            <td>${product1.pin}</td>
                            <td>${product2.sim}</td>
                        </tr>
                        <tr>
                            <th>Chống nước</th>
                            <td>
	                           	<c:choose>
	                           		<c:when test="${product1.waterproof == true}">
	                           			Có
	                           		</c:when>
	                           		<c:otherwise>
	                           			Không
	                           		</c:otherwise>
	                           	</c:choose>
                            </td>
                            <td>
	                           	<c:choose>
	                           		<c:when test="${product2.waterproof == true}">
	                           			Có
	                           		</c:when>
	                           		<c:otherwise>
	                           			Không
	                           		</c:otherwise>
	                           	</c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>Camera kép</th>
                            <td>
                               	<c:choose>
                               		<c:when test="${product1.dualCamera == true}">
                               			Có
                               		</c:when>
                               		<c:otherwise>
                               			Không
                               		</c:otherwise>
                               	</c:choose>
                            </td>
                            <td>
                               	<c:choose>
                               		<c:when test="${product2.dualCamera == true}">
                               			Có
                               		</c:when>
                               		<c:otherwise>
                               			Không
                               		</c:otherwise>
                               	</c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>Sạc nhanh</th>
                            <td>
                               	<c:choose>
                               		<c:when test="${product1.fastCharging == true}">
                               			Có
                               		</c:when>
                               		<c:otherwise>
                               			Không
                               		</c:otherwise>
                               	</c:choose>
                            </td>
                            <td>
                               	<c:choose>
                               		<c:when test="${product2.fastCharging == true}">
                               			Có
                               		</c:when>
                               		<c:otherwise>
                               			Không
                               		</c:otherwise>
                               	</c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>Bảo mật khuôn mặt</th>
                            <td>
                               	<c:choose>
                               		<c:when test="${product1.faceSecurity == true}">
                               			Có
                               		</c:when>
                               		<c:otherwise>
                               			Không
                               		</c:otherwise>
                               	</c:choose>
                            </td>
                            <td>
                               	<c:choose>
                               		<c:when test="${product2.faceSecurity == true}">
                               			Có
                               		</c:when>
                               		<c:otherwise>
                               			Không
                               		</c:otherwise>
                               	</c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>Bảo mật vân tay</th>
                            <td>
                               	<c:choose>
                               		<c:when test="${product1.fingerprintSecurity == true}">
                               			Có
                               		</c:when>
                               		<c:otherwise>
                               			Không
                               		</c:otherwise>
                               	</c:choose>
                            </td>
                            <td>
                               	<c:choose>
                               		<c:when test="${product2.fingerprintSecurity == true}">
                               			Có
                               		</c:when>
                               		<c:otherwise>
                               			Không
                               		</c:otherwise>
                               	</c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th>Màu sắc</th>
                            <td>${product1.colorsString}</td>
                            <td>${product2.colorsString}</td>
                        </tr>
                    </table>
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