<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.80.0">
    <title>Study Neomuj - Bootstrap v4.6</title>

<%@include file="/WEB-INF/views/common/config.jsp" %>
   
<meta name="theme-color" content="#563d7c">

    <style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        -ms-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
    </style>

  </head>
  <body>
    
<!-- nav.jsp -->
<%@include file="/WEB-INF/views/common/nav.jsp" %>

<main role="main" class=".container-fluid">

  <div class="row">
    <div class="col-2">
		<%@include file="/WEB-INF/views/common/category_list.jsp" %>
    </div>
    
    <div class="col-8">
 		<h3>주문하기</h3>
 		<div class="panel panel-default">
					<div class="panel-heading text-right">
						<!-- <button id="regBtn" type="button" class="btn btn-primary pull-right">글쓰기</button> -->
					</div>
					<div class="panel-body">
						<!-- 리스트 -->
						<table class="table table-striped">
							<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">사진</th>
									<th scope="col">상품명</th>
									<th scope="col">수량</th>
									<th scope="col">금액</th>
								</tr>
							</thead>
							<tbody>
								<%-- 데이터가 존재하지 않을 경우 --%>
								<c:if test="${empty cartVOList }">
									<tr>
										<td colspan="5">
											<p style="color: red;">장바구니가 비어있습니다.</p>
										</td>
									</tr>
								</c:if>
								<c:set var="i" value="1"></c:set>
								<c:set var="price" value="0"></c:set>
								<c:forEach items="${cartVOList }" var="cartList">
									<%-- <c:set var="price" value="${ cartList.pdt_price * cartList.cart_amount}"></c:set> --%>
									<c:set var="price"
										value="${cartList.pdt_price * cartList.cart_amount }"></c:set>
									<tr>
										<th scope="row">${i }</th>
										<td><img
											src="/cart/displayFile?fileName=${cartList.pdt_img }">
										</td>
										<td><c:out value="${cartList.pdt_name }"></c:out></td>
										<td><c:out value='${cartList.cart_amount }'></c:out>EA</td>
										<td><fmt:formatNumber type="currency" value="${price }"></fmt:formatNumber>
										</td>
									</tr>
									<c:set var="i" value="${i+1 }"></c:set>
									<c:set var="sum" value="${sum + price }"></c:set>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div id="sum_price" class="panel-body">
						<table class="table table=striped">
							<tr>
								<td>총 금액</td>
								<td>
									<fmt:formatNumber type="currency" value="${sum }"></fmt:formatNumber>
									<%-- <input type="text" name="odr_total_price" value="${sum }" /> --%>
								</td>
							</tr>
						</table>
					</div>

				</div>

				<!-- 주문 입력 정보 -->
				<div class="panel panel-default">
					<div class="panel-body">
						<form id="orderForm" action="#" method="post">
						<h3>주문자 정보</h3>
							
							<div class="form-group">
								<label for="inputName">* 이름</label> <input type="text"
									class="form-control" id="mem_name" name="mem_name" value="${sessionScope.loginStatus.mem_name }"
									placeholder="이름을 입력해 주세요" style="max-width: 630px;">
								<%-- <input type="hidden" name="type" value="${type} "> --%>
							</div>
							<div class="form-group">
								<label for="inputAddr">* 주소</label> <br />
								
								<input type="text" id="sample2_postcode" name="mem_zipcode" class="form-control" value="${sessionScope.loginStatus.mem_zipcode }"
									style="max-width: 510px; width:calc(100% - 128px); margin-right: 5px; display: inline-block;" placeholder="우편번호">
								<input type="button" onclick="sample2_execDaumPostcode()" id="btn_postCode" class="btn btn-default" value="우편번호 찾기"><br>
								<input type="text" id="sample2_address" name="mem_addr" value="${sessionScope.loginStatus.mem_addr }" class="form-control" 
									placeholder="주소" style="max-width: 630px; margin:3px 0px;" >
								<input type="text" id="sample2_detailAddress" name="mem_addr_d" class="form-control" value="${sessionScope.loginStatus.mem_addr_d }"
									placeholder="상세주소" style="max-width: 630px;">
								<input type="hidden" id="sample2_extraAddress" class="form-control" 
									placeholder="참고항목">
								
								 <!-- 
								<input type="text" id="sample2_postcode" name="" class="form-control" placeholder="우편번호" readonly>
								<input type="button" onclick="sample2_execDaumPostcode()" name="" class="form-control" value="우편번호 찾기"><br>
								<input type="text" id="sample2_address" name="" class="form-control" placeholder="주소"><br>
								<input type="text" id="sample2_detailAddress" name="" class="form-control" placeholder="상세주소">
								<input type="hidden" id="sample2_extraAddress" placeholder="참고항목">
								 -->
							</div>
							<div class="form-group">
								<label for="inputMobile">* 휴대폰 번호</label> <input type="tel"
									class="form-control" id="mem_phone" name="mem_phone" value="${sessionScope.loginStatus.mem_phone }"
									placeholder="휴대폰 번호를 입력해 주세요" style="max-width: 630px;">
							</div>
							<!-- 
							<div class="form-group">
								<label for="InputEmail">* 이메일 주소</label><br /> <input type="email"
									class="form-control" id="mem_email" name="mem_email"
									placeholder="이메일 주소를 입력해주세요"
									style="max-width: 526px; width:calc(100% - 115px); margin-right: 5px; display: inline-block;">
								<button id="btn_sendAuthCode" class="btn btn-default" type="button" >이메일 인증</button>
								<p id="authcode_status" style="color: red;"></p>
							</div>
							-->
							</form>
							<h3>배송정보</h3>
							
							<div class="form-check">
								  <input class="form-check-input" type="checkbox" value="" id="defaultCheck1">
								  <label class="form-check-label" for="defaultCheck1">
								    주문 고객과 동일
								 </label>
							</div>
							<form id="orderForm" action="/order/order_buy" method="post">
							<!-- 즉시 구매시 사용할 상품 상세 정보 -->							
							<input type="hidden" name="pdt_num" value="${pdt_num }">
							<input type="hidden" name="odr_amount" value="${odr_amount }">
							<input type="hidden" name="odr_price" value="${odr_price }">
							
							<div class="form-group">
								<label for="inputName">* 이름</label> <input type="text"
									class="form-control" id="odr_name" name="odr_name" value="${sessionScope.loginStatus.mem_name }"
									placeholder="이름을 입력해 주세요" style="max-width: 900px;">
									<input type="hidden" name="type" value="${type} ">
							</div>
							<div class="form-group">
								<label for="inputAddr">* 주소</label> <br />
								
								<input type="text" id="sample2_postcode" name="odr_zipcode" class="form-control"  value="${sessionScope.loginStatus.mem_zipcode }"
									style="max-width: 510px; width:calc(100% - 128px); margin-right: 5px; display: inline-block;" placeholder="우편번호" readonly>
								<input type="button" onclick="sample2_execDaumPostcode()" id="btn_postCode" class="btn btn-default" value="우편번호 찾기"><br>
								<input type="text" id="sample2_address" name="odr_addr" value="${sessionScope.loginStatus.mem_addr }" class="form-control" 
									placeholder="주소" style="max-width: 630px; margin:3px 0px;" readonly>
								<input type="text" id="sample2_detailAddress" name="odr_addr_d" value="${sessionScope.loginStatus.mem_addr_d }" class="form-control" 
									placeholder="상세주소" style="max-width: 630px;">
								<input type="hidden" id="sample2_extraAddress" class="form-control" 
									placeholder="참고항목">
								
								 <!-- 
								<input type="text" id="sample2_postcode" name="" class="form-control" placeholder="우편번호" readonly>
								<input type="button" onclick="sample2_execDaumPostcode()" name="" class="form-control" value="우편번호 찾기"><br>
								<input type="text" id="sample2_address" name="" class="form-control" placeholder="주소"><br>
								<input type="text" id="sample2_detailAddress" name="" class="form-control" placeholder="상세주소">
								<input type="hidden" id="sample2_extraAddress" placeholder="참고항목">
								 -->
							</div>
							<div class="form-group">
								<label for="inputMobile">* 휴대폰 번호</label> <input type="tel"
									class="form-control" id="odr_phone" name="odr_phone" value="${sessionScope.loginStatus.mem_phone }"
									placeholder="휴대폰 번호를 입력해 주세요" style="max-width: 630px;">
									<input type="hidden" name="odr_total_price" value="${sum }" />
							</div>
							<!--
							<div class="form-group">
							
								<label for="InputEmail">* 이메일 주소</label><br /> <input type="email"
									class="form-control" id="mem_email" name="mem_email"
									placeholder="이메일 주소를 입력해주세요"
									style="max-width: 526px; width:calc(100% - 115px); margin-right: 5px; display: inline-block;">
								<button id="btn_sendAuthCode" class="btn btn-default" type="button" >이메일 인증</button>
								<p id="authcode_status" style="color: red;"></p>
							</div>
							-->
							<div class="form-group text-center">
							<button type="submit" id="btn_submit" class="btn btn-primary">
								구매하기 <i class="fa fa-check spaceLeft"></i>
							</button>
							<button type="button" id="btn_cancel" class="btn btn-warning">
								구매취소 <i class="fa fa-times spaceLeft"></i>
							</button>
						</div>
							
						
						</form>
				<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
				<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
				<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
				</div>
				
				<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
				<script src="/js/member/postCode.js"></script>
					
					</div>

				</div>
			</div>
</div>
</main><!-- /.container -->

<script>
$(document).ready(function(){

    $("#btn_cancel").on("click", function(){
		
		var result = confirm("구매를 취소하시겠습니까?");
		if(result){
			location.href="/"; 
		} else{}
	});

});

</script>
  </body>
</html>