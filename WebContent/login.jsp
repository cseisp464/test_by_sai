<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<%-- Cookie --%>
<%
String cookieName = "username";
Cookie[] cookies = request.getCookies(); 
Cookie myCookie = null;
if(cookies != null){
	for(int i=0;i<cookies.length; i++){
		if(cookieName.equals(cookies[i].getName())){
			myCookie = cookies[i];
			break;
		}
	}
}
%>


</head>
<body>
	<c:url value="/LoginServlet" var="LoginServletURL">
	  <c:param name="sessionId" value="${pageContext.session.id}"/>
	</c:url>
	
	<c:url value="/signup.jsp" var="signupURL">
	  <c:param name="sessionId" value="${pageContext.session.id}"/>
	</c:url>
	
	<c:url value="/BookingHistoryServlet" var="BookingHistoryServletURL">
	  <c:param name="sessionId" value="${pageContext.session.id}"/>
	</c:url>
	
	<c:url value="/LogoutServlet" var="LogoutServletURL">
	  <c:param name="sessionId" value="${pageContext.session.id}"/>
	</c:url>   
	
	<c:url value="/flightSearchQuery.jsp" var="flightSearchQueryURL">
	  <c:param name="sessionId" value="${pageContext.session.id}"/>
	</c:url> 

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
			<form action="${LoginServletURL}" method="post" class="form-horizontal">
				<div class ="row">
					<div class="col-md-6 col-md-offset-3">
						<legend><strong>Login</strong></legend>
						
						<div class="form-group">
							<label for="username">Username</label> 
							
							&nbsp;&nbsp;
							<span style="color:red; font-size:10px;">
							<% 
							if (request.getAttribute("username_error")!=null){
										out.print(request.getAttribute("username_error"));
										}		
							%>
							</span>
										
							<input 
								type="text" 
								class="form-control" 
								id="username" 
								name="username"
								
								required
								<% 
								if (request.getParameter("username")!=null){
										out.print("value=" + request.getParameter("username"));
								}
								else if(myCookie != null){
									out.print("value=" + myCookie.getValue());
								}
										
								%> 
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
						
						<div class="form-group checkbox">
            				<label><input type="checkbox" id="rememberMe" name="rememberMe"> Remember me</label>
        				</div>
						
						<br/>
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