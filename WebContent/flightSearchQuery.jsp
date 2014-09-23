<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Flight Search Query</title>

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
			<h2 align="center">Search your Flight!</h2> <br>
			
			<form action="flightSearchResults.jsp" method="post" class="form-horizontal">
				<div class ="row">
					<div class="col-md-6 col-md-offset-3">
					
						<div class="form-group">
							<label for="source">Source</label> 		
							<input 
								type="text" 
								class="form-control" 
								id="source" 
								name="source"
								required> 
						</div>
						
						<div class="form-group">
							<label for="destination">Destination</label> 		
							<input
								type="text" 
								class="form-control" 
								id="source" 
								name="source"
								required>  
						</div>
						
						<div class="form-group">
							<label for="travelDate">Date of Travel</label> 		
							<input
								type="text" 
								class="form-control" 
								id="travelDate" 
								name="travelDate"
								required>  
						</div>
						
						
						<div class="form-group">
							<label for="no_of_seats">Number of Seats</label> 		
							<input
								type="text" 
								class="form-control" 
								id="no_of_seats" 
								name="no_of_seats"
								required>  
						</div>
						
						<div class="form-group">
							<label for="ticketClass">Class</label> 		
															
							<select class="form-control">
 
							  <option value="Economy">Economy</option>
							 
							  <option value="First">First</option>
							 
							  <option value="Business">Business</option>
							  
							</select>	
								  
						</div>
											
						<button type="submit" id="search" class="btn btn-primary">Search</button>
						
						<a href="bookingHistory.jsp" class="btn btn-success">View my Booking History</a>

					</div>
				</div>
			</form>
			
			<br>
		</div>
	</div>

</body>
</html>