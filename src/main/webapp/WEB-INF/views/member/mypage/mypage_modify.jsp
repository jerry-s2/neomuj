<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
		<script src="/js/member/edit.js"></script>
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
					<button type="button" id="btnModifyInfo" class="btn btn-outline-dark">회원정보 수정</button>
					<button type="button" id="btnModifyPwd" class="btn btn-outline-dark">비밀번호 변경</button>
					<button type="button" id="btnDelete" class="btn btn-outline-dark">회원 탈퇴</button>
				</div>
				
				 <div class="wrapper">
    <%-- Main content --%>
			<section class="content container-fluid">
				<div class="container" style="width: 70%; min-width: 900px; background-color: white; font-size: 14px;" >
					<form id="modifyForm" action="/member/mypage/mypage_modify" method="post">
						<div class="container" style="width: 800px; padding: 10% 5%;">
							<h2 class="form-signin-heading">Please Modify</h2>
							<br><br>
							<div class="form-group" style="width:100%;">
								<label for="inputId">* 아이디</label> <br /> <input type="text"
									class="form-control" id="mem_id" name="mem_id" value="<c:out value="${vo.mem_id }"/>"
									placeholder="아이디를 입력해 주세요" readonly 
									style="max-width:630px; width:calc(100% - 100px); margin-right: 5px; display: inline-block;">
							</div>
							<div class="form-group">
								<label for="inputPassword">* 비밀번호</label> <input type="password"
									class="form-control" id="mem_pw" name="mem_pw" 
									placeholder="비밀번호를 입력해주세요" style="max-width: 630px;">
							</div>
							<div class="form-group">
								<label for="inputName">* 이름</label> <input type="text"
									class="form-control" id="mem_name" name="mem_name" value="<c:out value="${vo.mem_name }"/>"
									placeholder="이름을 입력해 주세요" style="max-width: 630px;">
							</div>
							<div class="form-group">
								<label for="inputNickName">* 닉네임</label> <input type="text"
									class="form-control" id="mem_nick" name="mem_nick" value="<c:out value="${vo.mem_nick }"/>"
									placeholder="사용할 닉네임을 입력해 주세요" style="max-width: 630px;">
							</div>
							<div class="form-group">
								<label for="InputEmail">* 이메일 주소</label><br /> <input type="email"
									class="form-control" id="mem_email" name="mem_email" value="<c:out value="${vo.mem_email }"/>"
									placeholder="이메일 주소를 입력해주세요"
									style="max-width: 630; width:calc(100% - 115px); margin-right: 5px; display: inline-block;">
							</div>
							<div class="form-group">
								<label for="inputMobile">* 휴대폰 번호</label> <input type="tel"
									class="form-control" id="mem_phone" name="mem_phone" value="<c:out value="${vo.mem_phone }"/>"
									placeholder="휴대폰 번호를 입력해 주세요" style="max-width: 630px;">
							</div>
							<div class="form-group">
								<label for="inputAddr">* 주소</label> <br />
								
								<input type="text" id="sample2_postcode" name="mem_zipcode" class="form-control" value="<c:out value="${vo.mem_zipcode }"/>"
									style="max-width: 630; width:calc(100% - 128px); margin-right: 5px; display: inline-block;" placeholder="우편번호" readonly>
								<input type="button" onclick="sample2_execDaumPostcode()" id="btn_postCode" class="btn btn-default" value="우편번호 찾기"><br>
								<input type="text" id="sample2_address" name="mem_addr" class="form-control" 
									placeholder="주소" style="max-width: 630px; margin:3px 0px;" value="<c:out value="${vo.mem_addr }"/>">
								<input type="text" id="sample2_detailAddress" name="mem_addr_d" class="form-control" value="<c:out value="${vo.mem_addr_d }"/>"
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
								<label>* 수신 동의</label><br /> 
								이벤트 등 프로모션 메일 알림 수신에 동의합니다.
								<label><input type="radio" name="mem_accept_e" value="Y" style="margin-left: 20px;" <c:out value="${vo.mem_accept_e == 'Y'? 'checked' : '' }"/>> 예</label>
	      						<label><input type="radio" name="mem_accept_e" value="N" style="margin-left: 20px;" <c:out value="${vo.mem_accept_e == 'N'? 'checked' : '' }"/>> 아니오</label>
							</div>
						</div>
						<div class="form-group text-center">
							<button type="button" id="btn_modify_info" class="btn btn-success">
								회원수정 <i class="fa fa-check spaceLeft"></i>
							</button>
							<button type="button" id="btn_cancel" class="btn btn-secondary">
								수정취소 <i class="fa fa-times spaceLeft"></i>
							</button>
						</div>
						<br><br><br><br>
					</form>
				</div>
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->
 
				
				<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
				<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
				<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
				</div>
				
				<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
				<script src="/js/member/postCode.js"></script>

		</div>
		</div>
	</main>
	<!-- /.container -->

</body>
</html>