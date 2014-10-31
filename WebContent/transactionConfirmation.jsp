<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Transaction Confirmation</title>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<script src="//code.jquery.com/jquery-1.10.2.js"></script>

<style>

.sourceFont{

color:Red;
font-size: 24px;
line-height: 40px;
}

.destinationFont{
color: Green;
font-size: 24px;
line-height: 40px;
}
</style>

</head>
<body>

<%@ include file="/WEB-INF/header.jsp" %>
<%@ page errorPage="/WEB-INF/transactionErrors.jsp" %>
<%
	// checking if session exists, if not then redirect to login page
		if(session.getAttribute("username") == null){
			response.sendRedirect("login.jsp");
		}
	
	%>
	

	
	<div class="container">
		<div class="jumbotron">
		<% 
			if (request.getAttribute("error_message")!=null){ %>
				<h2 align="center">Transaction was  not successful!</h2>
				<br/>
				<br/>
				<center>
					<h5> Error(s):</h5>
					<strong> <%= request.getAttribute("error_message")%></strong>
					
					<br/><br/>
					<a href="transaction.jsp" class="btn btn-warning">Back to Transaction Page</a>
				</center>
				
				
				
				<%}
			else{
		%>
		
		
			<h2 align="center">Your purchase has been confirmed!</h2> <br>
			
			
				<div class ="row">
					<div class="col-md-12">
						<legend><strong>Transaction Details</strong></legend>
						
						<strong> From: <span class="sourceFont"><%= session.getAttribute("source") %></span><br/>
						To: <span class="destinationFont"> <%= session.getAttribute("destination") %> </span></strong>
						
						<table class="table table-striped">
					       
					       <tbody>
					       	<tr>
					       		<th>Flight No.</th>
					       		<th>Plane No.</th>
					       		<th>Departure Time</th>
					       		<th>Arrival Time</th>
					       		<th>Number of Stops</th>
					       		<th>Total Duration</th>
					       		<th>Number of seats</th>
					       		<th>Total Cost</th>
					       	</tr>
					       </tbody>
					       
					       <tbody>
					       	<tr>
					       		<td><%= session.getAttribute("flight_number") %></td>
					       		<td><%= session.getAttribute("plane_number") %></td>
					       		<td><%= session.getAttribute("deptTime") %></td>
					       		<td><%= session.getAttribute("arrTime") %></td>
					       		<td><%= session.getAttribute("stops") %> </td>
					       		<td><%= session.getAttribute("duration") %></td>
					       		<td><%= session.getAttribute("confirmed_number_of_seats") %></td>
					       		<td>$<%= session.getAttribute("total_cost") %></td>
					       	</tr>
					       </tbody>
					       
					       

					   </table>
					       
					       
					   </div>
				</div>
			<form action="PrintingServlet" method="post" class="form-horizontal">
				<div class ="row">
					<div class="col-md-12">
						<legend><strong>Passenger Details</strong></legend>
					</div>
					<div  class="col-md-3">
						<div class="form-group">
							<label for="firstname">First Name</label>
							<input 
								type="text" 
								class="form-control" 
								id="firstname" 
								name="firstname"   
								required autofocus>
							</div>
						</div>
						<div  class="col-md-3">
						<div class="form-group">
							<label for="lastname">Last Name</label>
							<input 
								type="text" 
								class="form-control" 
								id="lastname" 
								name="lastname"   
								required autofocus>
							</div>
						</div>
						<div  class="col-md-3">
						<div class="form-group">
							<label for="age">Age</label>
							<input 
								type="text" 
								class="form-control" 
								id="age" 
								name="age"   
								required autofocus>
								</div>
						</div>
						<div  class="col-md-3">
							<div class="form-group">
							<label for="gender">Gender</label>
							<input 
								type="text" 
								class="form-control" 
								id="gender" 
								name="gender"   
								required autofocus>
								</div>
						</div>

					    <center><button type="submit" class="btn btn-default">Print</a></center>

			
			</form>
			<%}%>
			
			<br>
		</div>
	</div>

</body>
</html>