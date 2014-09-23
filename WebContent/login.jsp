<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login Page</title>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<script src="//code.jquery.com/jquery-1.10.2.js"></script>

<script>
// script for comparing passwords
$(document).ready(function(){
	$("#submit").click(function(event){
		if($('#password1').val()!= $('#password2').val()){
			event.preventDefault();
			alert("Passwords dont match");
		}
	    
	  });
});

</script>

<style type="text/css">
    body{
    	padding-top: 70px;
    }

</style>
</head>
<body>

	<nav id="myNavbar" class="navbar navbar-default navbar-inverse navbar-fixed-top" role="navigation">
		<!-- Brand and toggle get grouped for better mobile display -->
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="#">Airline Reservation System</a>
			</div>
		</div>
	</nav>
	
	<div class="container">
		<div class="jumbotron">
			<h2 align="center">Welcome to the Online Air Ticket Reservation System!</h2> <br>
			
			<!-- Login Form -->
			<form action="LoginServlet" method="post" class="form-horizontal">
				<div class ="row">
					<div class="col-md-6 col-md-offset-3">
						<legend><strong>Login</strong></legend>
						
						<div class="form-group">
							<label for="username">Username</label> 
							
							&nbsp;&nbsp;
							<span style="color:red; font-size:10px;">
							<% if (request.getAttribute("username_error")!=null){
										out.print(request.getAttribute("username_error"));
										}%>
							</span>
										
							<input 
								type="text" 
								class="form-control" 
								id="username" 
								name="username"
								
								required
								<% if (request.getParameter("username")!=null){
										out.print("value=" + request.getParameter("username"));
										}%> 
								 >
						</div>
						
						
						<div class="form-group">
							<label for="password1">Password</label>
							&nbsp;&nbsp;
							
							<span style="color:red; font-size:10px;">
							<% if (request.getAttribute("password_error")!=null){
										out.print(request.getAttribute("password_error"));
										}%>
							</span>
							
							<input 
								type="password" 
								class="form-control" 
								id="password1" 
								name="password1" 
								<% if (request.getParameter("password1")!=null){
										out.print("value=" + request.getParameter("password1"));
										}%>
								 required>
						</div>
						
						<button type="submit" id="login" class="btn btn-primary">Login</button>
						
						<a href="signup.jsp" class="pull-right">New User! Click here to sign up.</a>
						

					</div>
				</div>
			</form>
			
			<br>
		</div>
	</div>


</body>
</html>