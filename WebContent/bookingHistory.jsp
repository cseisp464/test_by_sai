<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Booking History</title>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="//code.jquery.com/ui/1.11.1/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
<script src="//code.jquery.com/ui/1.11.1/jquery-ui.js"></script>
<link rel="stylesheet" href="/resources/demos/style.css">

<script>
//script for date
$(document).ready(function(){
	$( "#travelDate" ).datepicker();
});

</script>

</head>
<body>
<%@ include file="/WEB-INF/header.jsp" %>
<%
	// checking if session exists, if not then redirect to login page
		if(session.getAttribute("username") == null){
			response.sendRedirect("login.jsp");
		}
	
	%>
	
	<div class="container">
		<div class="jumbotron">
			<h2 align="center">Booking History</h2> <br>
			
			<form action="flightSearchResults.jsp" method="post" class="form-horizontal">
				<div class ="row">
					<div class="col-md-6 col-md-offset-3">
					
					<table class="table table-striped">
						<thead>
							<tr>
								<th>Flight No.</th>
								<th>Ticket No.</th>
								<th>Date</th>
							</tr>
						</thead>
						
						<tbody>
							<tr>
								<td>1</td>
								<td>27</td>
								<td>9/1/2014</td>
							</tr>
							
							<tr>
								<td>2</td>
								<td>36</td>
								<td>9/14/2014</td>
							</tr>
							
							<tr>
								<td>3</td>
								<td>16</td>
								<td>10/14/2014</td>
							</tr>
						</tbody>
					</table>
										
					<a href="flightSearchQuery.jsp" class="btn btn-success">Home</a>
					
					<a href="login.jsp" class="btn btn-default pull-right">Logout</a>

       </div>
				</div>
			</form>
			
			<br>
		</div>
	</div>

</body>
</html>