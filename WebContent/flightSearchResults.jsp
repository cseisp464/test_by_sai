<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Flight Search Results</title>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<script src="//code.jquery.com/jquery-1.10.2.js"></script>

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
			<h2 align="center">Flight Search Results</h2> <br>

			    <table class="table table-striped">
			        <thead>
			            <tr>
			                <th>Flight No.</th>
			                <th>Flight Date</th>
			                <th>Departure Time</th>
			                <th>Arrival Time</th>
			                <th>Number of Stops</th>
			                <th>Cost</th>
			                <th>View and Book</th>
			            </tr>
			        </thead>
			        <tbody>
			            <tr>
			                <td>1</td>
			                <td>09/21/2014</td>
			                <td>13:50</td>
			                <td>03:30</td>
			                <td>5</td>
			                <td>$500</td>
			                <td><a href="viewAndBook.jsp" class="btn btn-success">View and Book</a></td>
			            </tr>
			            <tr>
			                <td>2</td>
			                <td>09/22/2014</td>
			                <td>04:30</td>
			                <td>06:30</td>
			                <td>0</td>
			                <td>$1000</td>
			                <td><a href="viewAndBook.jsp" class="btn btn-success">View and Book</a></td>
			            </tr>
			            <tr>
			                <td>3</td>
			                <td>09/22/2014</td>
			                <td>19:30</td>
			                <td>23:30</td>
			                <td>2</td>
			                <td>$1500</td>
			                <td><a href="viewAndBook.jsp" class="btn btn-success">View and Book</a></td>
			            </tr>
			        </tbody>
			    </table>
			    
			    <a href="login.jsp" class="btn btn-default pull-right">Logout</a>

		</div>
	</div>

</body>
</html>