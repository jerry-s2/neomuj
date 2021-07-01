<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.80.0">
    <meta name="theme-color" content="#563d7c">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>Study Neomuj - Bootstrap v4.6</title>
	<style>
		.bd-placeholder-img {
			font-size: 1.125rem;
			text-anchor: middle;
			-webkit-user-select: none;
			-moz-user-select: none;
			-ms-user-select: none;
			user-select: none;
		}
		
		@media ( min-width : 768px) {
			.bd-placeholder-img-lg {
				font-size: 3.5rem;
			}
		}
				.icon-bar {
			width: auto;
			background-color: white;
			overflow: auto;
		}
		
		.icon-bar a {
			float: left;
			width: 20%;
			text-align: center;
			padding: 12px 0;
			transition: all 0.3s ease;
			color: #708090;
			font-size: 36px;
		}
		
		.icon-bar a:hover {
			background-color: white;
		}
		
		.active2 {
			background-color: white;
		}

</style>

	<%@include file="/WEB-INF/views/common/config.jsp" %>
	<script src="/js/member/mypage.js"></script>

  </head>
  <body>

	<!-- nav.jsp -->
	<%@include file="/WEB-INF/views/common/nav.jsp"%>

	<main role="main" class=".container-fluid">

		<div class="row">
			<div class="col-2">
				<%@include file="/WEB-INF/views/common/category_list.jsp"%>
			</div>

			<div class="col-10">
				<h3>My Page</h3>
				<hr>
				<div class="icon-bar">
					<a class="active2" href="/member/mypage/mypage"><i class="fa fa-user"></i></a> 
					<a class="active2" href="/member/mypage/mypage_orderList"><i class="fa fa-truck"></i></a>
					<a href="#"><i class="fa fa-pencil"></i></a>
				</div>
				<hr>
				<div>
<!-- 상품리스트 -->
	<div class="row">
	  	<div class="col-lg-10">
	  		<div class="panel panel-default">

	  			
	  			<div class="panel-body">
	  			 <!-- 리스트 -->
	  			 <table class="table table-striped">
			  <thead>
			    <tr>
			      <th scope="col">선택</th>
			      <th scope="col">번호</th>
			      <th scope="col">주문일시</th>
			      <th scope="col">주문번호</th>
			      <th scope="col">주문자</th>
			      <th scope="col">금액</th>
			    </tr>
			  </thead>
			  <tbody>
			  											<!-- varStatus : 상태변수 -->
			  <c:forEach items="${order_list }" var="orderVO" varStatus="status">
			    <tr>
			      <th scope="row"><input type="checkbox" value="${orderVO.odr_code }"></th>
				<td>
				 	${(cri.pageNum - 1) * cri.amount + status.count}
				</td>
				
				  <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${orderVO.odr_date }"/></td>
				  <td>
				   	${orderVO.odr_code }
				  	<button type="button" name="btn_order_detail" data-odr_code="${orderVO.odr_code }" class="btn btn-link" >
				  	주문상세</button>	
				  </td>

			      <td>
					${orderVO.odr_name}
			      </td>
			      <td>
			      	 <fmt:formatNumber type="currency" value="${orderVO.odr_total_price }"/>
			      </td>
			    </tr>
			   </c:forEach>
			   </tbody>
			</table>
	  			</div>
	  		</div>
	  	</div>
	  </div>
    
    <div class="row">
    	<div class="col-lg-12">
    	<!-- 페이징 표시 -->
    			<div class="panel-footer">
    			   <ul class="pagination">
    			   <c:if test="${pageMaker.prev }">
					    <li class="page-item">
					      <a href="${pageMaker.startPage - 1 }" class="page-link" href="#" tabindex="-1">Prev</a>
					    </li>
				    </c:if>
				    <c:forEach begin="${pageMaker.startPage }" end="${ pageMaker.endPage}" var="num">
				    	<li class="page-item ${pageMaker.cri.pageNum == num ? "active" : ""}">
				    		<a href="${num }" class="page-link" href="#">${num }</a>
				    	</li>
				    </c:forEach>
				    <c:if test="${pageMaker.next }">
					    <li class="page-item">
					      <a href="${pageMaker.endPage + 1 }" class="page-link" href="#">Next</a>
					    </li>
				    </c:if>
				  </ul>
		
		    				<hr>
		    				${pageMaker }
    			</div>
    	</div>
    </div>

    <!-- 페이지번호클릭시, 수정클릭시 상품코드정보추가, 삭제클릭시 상품코드정보추가 -->
    <form id="actionForm" action="/member/mypage/mypage_orderList" method="get">
		<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum }" />'>
		<input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount }" />'>
		<input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type }" />'>
		<input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword }" />'>
	</form>

			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

		<!-- Main Footer -->
	
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

<script>

	$(document).ready(function(){

		$("button[name='btn_order_detail']").on("click", function(){
			console.log("상품상세");
			

			var odr_code = $(this).attr("data-odr_code");
			
			var current_tr = $(this).parents("tr"); // orderCodeTarget 선택했던 행 (tr)

			
			$.ajax({
				
				url : "/member/mypage/mypage_order_detail_list",
				type : 'get',
				dataType : "json",
				data : {odr_code : odr_code},
				success : function(data){ 

					
					// 함수 호출 orderDetailView
					orderDetailView(data, current_tr, $("#orderDetailTemplate"));
						
				}
			});
			


		});

	});

</script>


								<!-- orderDetailData 	-->
<script>						// 주문상세 데이터 		// 선택했던 tr	// orderDetailTemplate		
	var orderDetailView = function(orderDetailData, orderDetailTarget, orderDetailTemplate){
								var detailTemplate = Handlebars.compile(orderDetailTemplate.html());
								var details = detailTemplate(orderDetailData);
	
	console.log(details);
								
	 $(".dy_order_detail").remove(); //기존 details 제거
	 orderDetailTarget.after(details); // 새로운 2차카테고리 option태그 추가
	}
</script>

<!-- 주문상세 데이터와 결합될 태그를 구성 / 카테고리를 생각하자 ! -->
<!-- td 의 개수를 주문 목록 td 개수와 맞춰야 한다. -->
<!-- 마지막 th 에 집어넣을 게 없으면 colspan 으로 처리 -->
<script id="orderDetailTemplate" type="text/x-handlebars-template">

	<tr class="dy_order_detail"><td colspan="8">주문 상세 내역</td></tr>
	<tr class="dy_order_detail">
		<th></th><th></th><th>상품명</th><th>수량</th><th>상품가격</th><th>처리상태</th>
	</tr>
	{{#each .}}
	<tr class="dy_order_detail">>
		<td>
			
		</td>
		<td>
		
		</td>
		<td>
			{{pdt_name}}
		</td>
		<td>
			{{odr_amount}}
		</td>
		<td>
			{{odr_price}}
		</td>
		<td>
			결제완료
		</td>
	{{/each}}
</script>

<script>
// 핸들바의 사용자 정의 함수4

Handlebars.registerHelper("total_price", function(odr_price, odr_amount){
	
	return odr_price * odr_amount;
}); 

</script>


<script>
	
	$(document).ready(function(){

		var actionForm = $("#actionForm");
		
		// 페이지 번호 클릭
		$(".page-item a").on("click", function(e){
			e.preventDefault();

			console.log("click");

			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();


	});
	
	

</script>
				</div>

	</main>
	<!-- /.container -->
	
	

</body>
</html>