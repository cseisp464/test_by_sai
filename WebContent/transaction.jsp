<%@page import="com.cseisp464.servlets.Flights"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Transaction Page</title>

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

<script type="text/javascript">
$(document).ready(function(){
	
	$('#submit').click(function(event){
		if($('#routing_number').val().length!=9){
			alert("Routing number should be of 9-digts");
			event.preventDefault();
		}
		
		if($('#account_number').val().length!=10){
			alert("Account number should be of 10-digts");
			event.preventDefault();
		}	
	});
	
	
	
});


</script>

</head>
<body>
<%@ page errorPage="/WEB-INF/transactionErrors.jsp" %>
<%@ include file="/WEB-INF/header.jsp" %>
<%
	// checking if session exists, if not then redirect to login page
		if(session.getAttribute("username") == null){
			response.sendRedirect("login.jsp");
		}
	
	%>


	<div class="container">
		<div class="jumbotron">
			<h2 align="center">Purchase Your Flight Ticket</h2> <br>
			
			<form action="TransactionConfirmationServlet" method="post" class="form-horizontal">
				<div class ="row">
					<div class="col-md-6 col-md-offset-3">
					
					<%
						Flights f = (Flights)session.getAttribute("flight_information_object");
					 %>
					
	
						<table class="table table-striped">
					        <tbody>
					            <tr>
					            	<th>Plane No.</th>
					                <td><%= session.getAttribute("plane_number") %></td>
					            </tr>
					        </tbody>
					        
					        <tbody>
					            <tr>
					            	<th>Departure Time</th>
					                <td><%= session.getAttribute("deptTime") %></td>
					            </tr>
					        </tbody>
					        
					        <tbody>
					            <tr>
					            	<th>Arrival Time</th>
					                <td><%= session.getAttribute("arrTime") %></td>
					            </tr>
					        </tbody>
					        
					        <tbody>
					            <tr>
					            	<th>Number of Stops</th>
					                <td><%= session.getAttribute("stops") %> </td>
					            </tr>
					        </tbody>
					        
					        <tbody>
					            <tr>
					            	<th>Type of Jet</th>
					                <td>Airbus -780</td>
					            </tr>
					        </tbody>
					        
					        <tbody>
					            <tr>
					            	<th>Total Duration</th>
					                <td><%= session.getAttribute("duration") %> </td>
					            </tr>
					        </tbody>
					        
					        <tbody>
					            <tr>
					            	<th>Number of Seats</th>
					                <td><%= session.getAttribute("confirmed_number_of_seats") %> </td>
								</tr>					        
					        </tbody>
					        
					         <tbody>
						            <tr>
						            	<th>Ticket Class</th>
						                <td><%= session.getAttribute("ticket_class") %></td>
						            </tr>
						        </tbody>
					        
					       <tbody>
					       		<tr>
					       			<th>Cost</th>
					       			<td>$ <%= session.getAttribute("total_cost") %></td>
					       		</tr>
					       </tbody>
					       
					       <div class="form-group">
							<label for="account_holder_name">Account Holder Name</label> 		
							<input 
								type="text" 
								class="form-control" 
								id="account_holder_name" 
								name="account_holder_name"
								required> 
						</div>
						
						
						<div class="form-group">
							<label for="routing_number">Routing Number</label> 		
							<input 
								type="text" 
								class="form-control" 
								id="routing_number" 
								name="routing_number"
								required> 
						</div>
						
						<div class="form-group">
							<label for="account_number">Account Number</label> 		
							<input 
								type="text" 
								class="form-control" 
								id="account_number" 
								name="account_number"
								required> 
						</div>
				</table>
				
				<button type="submit" id="submit" class="btn btn-primary">Confirm Transaction</button>
						&nbsp;&nbsp;
						<a href="flightSearchQuery.jsp" class="btn btn-success">Cancel</a>
						&nbsp;&nbsp;
						
						<a href="login.jsp" class="btn btn-default pull-right">Logout</a>

					</div>
				</div>
			</form>
			
			<br>
		</div>
	</div>

</body>
</html>