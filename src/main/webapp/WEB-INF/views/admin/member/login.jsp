<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>

<%@include file="/WEB-INF/views/admin/include/nav.jsp" %>

<div role="main" class="container">

    <!-- Content Wrapper. Contains page content -->
		<div class="wrapper">
			<%-- Main content  로그인 UI --%>
			<section class="content container-fluid">
				<div class="container" style="width: 450px; height:620px; background-color: white; margin-top:30px;">
					<form id="loginForm" class="form-signin" action="/admin/loginPost" method="post" style="padding:50px 30px;">
						<h2 class="form-signin-heading">Admin Login</h2>
						<br><br>
						<label for="inputId" class="sr-only">Id</label> 
						<input type="text" id="admin_id" name="admin_id" class="form-control" style="margin-bottom: 15px"
							placeholder="Id" required autofocus> 
						<label for="inputPassword" class="sr-only">Password</label> 
						<input type="password" id="admin_pw" name="admin_pw" class="form-control"
							placeholder="Password" required>
						<br><br>
						<div class="checkbox">
							<label> <input type="checkbox" name="useCookie" />
								Remember me
							</label>
						</div>
						<button id="btn_login" class="btn btn-lg btn-primary btn-block" 
								type="submit"  >
							Sign in
						</button>
					</form>
					<div>
						<a class="btn btn-link" href="#">ID Search</a>
						<a class="btn btn-link" href="#">PW Search</a>
					</div>
				</div>
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->
  </div>

</body>
</html>