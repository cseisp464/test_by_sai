<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script>

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
<title>Registration page</title>
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
			<h2 align="center">Welcome to the Online Air Ticket Reservation System!</h2>
			<br>
			<form action="RegistrationServlet" method="post" class="form-horizontal">
				<div class ="row">
					<div class="col-md-6 col-md-offset-3">
						<legend><strong>Registration Form</strong></legend>
						<div class="form-group ">
							<label for="firstname">First Name</label>
							<input type="text" 
								class="form-control" 
								id="firstname" 
								name="firstname" 
								<% if (request.getParameter("firstname")!=null){
										out.print("value=" + request.getParameter("firstname"));
										}%>  
								placeholder="First Name" required autofocus>
						</div>
						<div class="form-group">
							<label for="lastname">Last Name</label>
							<input type="text" 
								class="form-control" 
								id="lastname" 
								name="lastname"
								<% if (request.getParameter("lastname")!=null){
										out.print("value=" + request.getParameter("lastname"));
										}%>
								placeholder="Last Name" required>
						</div>
						<div class="form-group">
							<label for="email">Email</label>
							<input type="email" 
								class="form-control" 
								id="email" 
								name="email"
								<% if (request.getParameter("email")!=null){
										out.print("value=" + request.getParameter("email"));
										}%> 
								placeholder="Email" required>
						</div>
						<div class="form-group">
							<label for="username">Username</label> 
							&nbsp;&nbsp;
							<% if (request.getAttribute("username_error")!=null){
										out.print(request.getAttribute("username_error"));
										}%>
							<input type="text" 
								class="form-control" 
								id="username" 
								name="username"
								placeholder="Username"
								required
								<% if (request.getParameter("username")!=null){
										out.print("value=" + request.getParameter("username"));
										}%> 
								 >
						</div>
						<div class="form-group">
							<label for="password1">Password</label>
							<input type="password" 
								class="form-control" 
								id="password1" 
								name="password1" 
								<% if (request.getParameter("password1")!=null){
										out.print("value=" + request.getParameter("password1"));
										}%>
								placeholder="Password" required>
						</div>
						<div class="form-group">
							<label for="password2">Confirm Password</label>
							<input type="password" 
								class="form-control" 
								id="password2" 
								name="password2" 
								<% if (request.getParameter("password2")!=null){
										out.print("value=" + request.getParameter("password2"));
										}%>
								placeholder="Re-type Password" required>
						</div>
						<button type="submit" id="submit" class="btn btn-primary">Sign up</button>
					</div>
				</div>
			</form>
			
		</div>
	</div>

</body>
</html>