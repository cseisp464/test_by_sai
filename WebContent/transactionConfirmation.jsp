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
			<h2 align="center">Your purchase has been confirmed!</h2> <br>
			
			<form action="transactionConfirmation.jsp" method="post" class="form-horizontal">
				<div class ="row">
					<div class="col-md-6 col-md-offset-3">
						<legend><strong>Flight Details</strong></legend>
						
						<strong> <span class="sourceFont">Lincoln</span> - Omaha - Kansas - Chicago - <span class="destinationFont"> Florida </span></strong>
						
						<table class="table table-striped">
					       
					       <tbody>
					       	<tr>
					       		<th>First Name</th>
					       		<td>Place</td>
					       	</tr>
					       </tbody>
					       
					       <tbody>
					       	<tr>
					       		<th>Last Name</th>
					       		<td>Holder</td>
					       	</tr>
					       </tbody>
					       
					       <tbody>
					       	<tr>
					       		<th>Ticket No.</th>
					       		<td>56</td>
					       	</tr>
					       </tbody>
					       
					        <tbody>
					            <tr>
					            	<th>Flight No.</th>
					                <td>1</td>
					            </tr>
					        </tbody>
					        
					        <tbody>
					            <tr>
					            	<th>Flight Date</th>
					                <td>09/21/2014</td>
					            </tr>
					        </tbody>
					        
					        <tbody>
					            <tr>
					            	<th>Departure Time</th>
					                <td>13:30</td>
					            </tr>
					        </tbody>
					        
					        <tbody>
					            <tr>
					            	<th>Arrival Time</th>
					                <td>20:30</td>
					            </tr>
					        </tbody>
					        
					        <tbody>
					            <tr>
					            	<th>Number of Stops</th>
					                <td>3  
					                <br>   Lincoln (13:30) - Omaha (14:00)
					                <br>   Omaha (14:30) - Kansas (16:30) 
					                <br>   Kansas (17:00) - Chicago (20:30)</td>
					            </tr>
					        </tbody>
					        
					        <tbody>
					            <tr>
					            	<th>Cost</th>
					                <td>$500</td>
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
					                <td>7 Hours 0 Min </td>
					            </tr>
					        </tbody>
					        
					        <tbody>
					            <tr>
					            	<th>Number of Seats</th>
					                <td>1</td>
								</tr>					        
					        </tbody>

					   </table>
					       
					       <a href="flightSearchQuery.jsp" class="btn btn-warning">Home</a>
					       
					       </div>
				</div>
			</form>
			
			<br>
		</div>
	</div>

</body>
</html>