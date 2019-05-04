<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/product_info.css">
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
            
            <div class="container-item left-container">
                <div class="product-img section-item">
                    <h3 class="product-name">${product.name}</h3>
                    <img src="data:image/jpeg;base64,${product.imageBase64}" alt="${product.name}" width="300px" height="300px">
                    <a class="buy-btn" href="${pageContext.request.contextPath}/GioHang?productId=${product.id}"><strong>Mua</strong></a>
                </div>
            </div>
            <div class="container-item right-container">
                <div class="product-info section-item">
                    <h3 class="product-cost"><strong>${product.money}</strong></h3>
                    <h4 class="figure">Thông số kỹ thuật</h4>
                    <table class="info-table">
                        <tbody>
                            <tr>
                                <th>Màn hình</th>
                                <td>${product.screenSize}  ${product.screenTechnology}</td>
                            </tr>
                            <tr>
                                <th>Hệ điều hành</th>
                                <td>${product.os}</td>
                            </tr>
                            <tr>
                                <th>Camera trước</th>
                                <td>${product.frontCamera}</td>
                            </tr>
                            <tr>
                                <th>Camera sau</th>
                                <td>${product.posteriorCamera}</td>
                            </tr>
                            <tr>
                                <th>CPU</th>
                                <td>${product.cpu}</td>
                            </tr>
                            <tr>
                                <th>RAM</th>
                                <td>${product.ram}</td>
                            </tr>
                            <tr>
                                <th>Bộ nhớ trong</th>
                                <td>${product.internalMemory}</td>
                            </tr>
                            <tr>
                                <th>Thẻ nhớ</th>
                                <td>${product.memoryStick}</td>
                            </tr>
                            <tr>
                                <th>Thẻ sim</th>
                                <td>${product.sim}</td>
                            </tr>
                            <tr>
                                <th>Dung lượng pin</th>
                                <td>${product.pin}</td>
                            </tr>
                            <tr>
                                <th>Chống nước</th>
                                <td>
                                	<c:choose>
                                		<c:when test="${product.waterproof == true}">
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
                                		<c:when test="${product.dualCamera == true}">
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
                                		<c:when test="${product.fastCharging == true}">
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
                                		<c:when test="${product.faceSecurity == true}">
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
                                		<c:when test="${product.fingerprintSecurity == true}">
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
                                <td>${product.colorsString}</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="container-item left-container">
                <div class="comp-container section-item">
                	<c:forEach var="cproduct" items="${comparisonProducts}">
	                    <div class="comp-item">
	                        <img src="data:image/jpeg;base64,${cproduct.imageBase64}" alt="${cproduct.name}" width="100" height="100">
	                        <a href="${pageContext.request.contextPath}/ThongTinSanPham?productId=${cproduct.id}" class="comp-prod-name">${cproduct.name}</a>
	                        <p class="comp-prod-cost">${cproduct.money}</p>
	                        <a href="${pageContext.request.contextPath}/SoSanh?product1Id=${product.id}&product2Id=${cproduct.id}" class="comp-href">So sánh</a>
	                    </div>
                    </c:forEach>
                </div>
            </div>
            <div class="container-item left-container">
                <div class="enter-comment section-item">
                    <h4>Bình luận</h4>
                    <form action="${pageContext.request.contextPath}/ThemBinhLuanNguoiDung" method="get">
                    	<input type="hidden" name="productId" value="${product.id}">
                        <textarea name="comment" placeholder="Mời bạn nhập bình luận" required></textarea>
                        <hr>
                        <input type="text" name="name" required placeholder="Họ tên">
                        <label>
                            <input type="radio" name="sex" value="male" checked>
                            Anh
                        </label>
                        <label>
                            <input type="radio" name="sex" value="female">
                            Chị
                        </label>
                        <hr>
                        <input type="submit" value="Gửi">
                    </form>
                </div>
            </div>
            <div class="container-item left-container">
                <div class="comment section-item">
                	<c:forEach var="comment" items="${comments}">
	                    <div class="media">
	                        <div class="media-left">
	                        	<c:if test="${comment.personSex == true}">
	                            	<img src="${pageContext.request.contextPath}/images/man.png" class="media-object" style="width:45px">
	                            </c:if>
	                            <c:if test="${comment.personSex == false}">
	                            	<img src="${pageContext.request.contextPath}/images/woman.png" class="media-object" style="width:45px">
	                            </c:if>	
	                        </div>
	                        <div class="media-body">
	                            <h5 class="media-heading">
	                            	${comment.personName}
	                            	<small><i><fmt:formatDate pattern="dd-MM-yyyy HH:mm:ss" value="${comment.time}"/></i></small>
                            	</h5>
	                            <p>${comment.content}</p>
	                            <button class="answer-btn" id="${comment.id}" onclick="answer(this)">Trả lời</button>
	                            
	                            <!-- Nested media object -->
	                            <c:forEach var="comment1" items="${comment.comments}">
		                            <div class="media">
		                                <div class="media-left">
		                                    <c:if test="${comment1.personSex == true || (comment1.answerAccount != null && comment1.answerAccount.sex == true)}">
				                            	<img src="${pageContext.request.contextPath}/images/man.png" class="media-object" style="width:45px">
				                            </c:if>
				                            <c:if test="${comment1.personSex == false || (comment1.answerAccount != null && comment1.answerAccount.sex == false)}">
				                            	<img src="${pageContext.request.contextPath}/images/woman.png" class="media-object" style="width:45px">
				                            </c:if>	
		                                </div>
		                                <div class="media-body">
		                                    <h5 class="media-heading">
		                                    	${comment1.personName}
		                                    	<c:if test="${comment1.answerAccount != null}">
		                                    		${comment1.answerAccount.displayName} <mark>Quản trị viên</mark>
		                                    	</c:if>
		                                    	<small><i><fmt:formatDate pattern="dd-MM-yyyy HH:mm:ss" value="${comment1.time}"/></i></small>
	                                    	</h5>
		                                    <p>${comment1.content}</p>
		                                    <button class="answer-btn" id="${comment.id}" onclick="answer(this)">Trả lời</button>
		                                </div>
		                            </div>
		                            
		                            <c:forEach var="comment2" items="${comment1.comments}">
			                            <div class="media">
			                                <div class="media-left">
			                                    <c:if test="${comment2.answerAccount.sex == true}">
					                            	<img src="${pageContext.request.contextPath}/images/man.png" class="media-object" style="width:45px">
					                            </c:if>
					                            <c:if test="${comment2.answerAccount.sex == false}">
					                            	<img src="${pageContext.request.contextPath}/images/woman.png" class="media-object" style="width:45px">
					                            </c:if>	
			                                </div>
			                                <div class="media-body">
			                                    <h5 class="media-heading">
			                                    	${comment2.answerAccount.displayName} <mark>Quản trị viên</mark>
			                                    	<small><i><fmt:formatDate pattern="dd-MM-yyyy HH:mm:ss" value="${comment2.time}"/></i></small>
		                                    	</h5>
			                                    <p>${comment2.content}</p>
			                                    <button class="answer-btn" id="${comment.id}" onclick="answer(this)">Trả lời</button>
			                                </div>
			                            </div>
			                        </c:forEach> 
		                        </c:forEach> 
	                            
	                            <div class="answer-form" id="af${comment.id}">
	                                <div class="enter-comment">
	                                    <form action="${pageContext.request.contextPath}/ThemBinhLuanNguoiDung" method="get">
					                    	<input type="hidden" name="productId" value="${product.id}">
					                    	<input type="hidden" name="answerCommentId" value="${comment.id}">
					                        <textarea name="comment" placeholder="Mời bạn nhập bình luận" required></textarea>
					                        <hr>
					                        <input type="text" name="name" required placeholder="Họ tên">
					                        <label>
					                            <input type="radio" name="sex" value="male" checked>
					                            Anh
					                        </label>
					                        <label>
					                            <input type="radio" name="sex" value="female">
					                            Chị
					                        </label>
					                        <hr>
					                        <input type="submit" value="Gửi">
					                    </form>
	                                </div>
	                            </div>
	                            
	                        </div>
	                    </div>
	                    <hr>
                   	</c:forEach>
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

	<script>
        function answer(button) {
            var af_id = "af" + button.id;
            var answer_form = document.getElementById(af_id);
            answer_form.style.display = "block";
            answer_form.getElementsByTagName("textarea").focus();
        }
    </script>
</body>

</html>