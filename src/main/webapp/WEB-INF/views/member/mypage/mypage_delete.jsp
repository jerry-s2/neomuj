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
					<a class="active2" href="/member/mypage/mypage"><i
						class="fa fa-user"></i></a> <a href="#"><i class="fa fa-truck"></i></a>
					<a href="#"><i class="fa fa-pencil"></i></a>
				</div>
				<hr>
				<div>
					<button type="button" id="btnModifyInfo" class="btn btn-outline-dark">회원정보 수정</button>
					<button type="button" id="btnModifyPwd" class="btn btn-outline-dark">비밀번호 변경</button>
					<button type="button" id="btnDelete" class="btn btn-outline-dark">회원탈퇴</button>
				</div>
				 <div class="wrapper">
    <%-- Main content --%>
			<section class="content container-fluid">
				<div class="container" style="width: 70%; min-width: 900px; background-color: white; font-size: 14px;" >
					<form id="deleteForm" action="/member/mypage/mypage_delete_mem" method="post">
						<div class="container" style="width: 800px; padding: 10% 5%;">
							<h2 class="form-signin-heading">Delete your account</h2>
							<br><br>
							<div class="form-group" style="width:100%;">
								<label for="inputId">* 아이디</label> <br /> <input type="text"
									class="form-control" id="mem_id" name="mem_id" value="${sessionScope.loginStatus.mem_id }"
									readonly 
									style="max-width:630px; width:calc(100% - 100px); margin-right: 5px; display: inline-block;">
							</div>
							<div class="form-group">
								<label for="inputPassword">* 비밀번호</label> <input type="password"
									class="form-control" id="mem_pw" name="mem_pw" 
									placeholder="비밀번호를 입력해주세요" style="max-width: 630px;">
							</div>
						</div>
						<div class="form-group text-center">
							<button type="submit" id="btn_delete" class="btn btn-success">
								탈퇴하기 <i class="fa fa-check spaceLeft"></i>
							</button>
							<button type="button" id="btn_cancel" class="btn btn-secondary">
								취소하기 <i class="fa fa-times spaceLeft"></i>
							</button>
						</div>
						<br><br><br><br>
					</form>
				</div>
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->
				
			</div>
		</div>
	</main>
	<!-- /.container -->
	<script>
		$(document).ready(function(){
			
			var form = $("#deleteForm");
			
			$("#btn_delete").on("click",function(){
				
				form.submit();
				
			});
			
		});
	</script>

</body>
</html>