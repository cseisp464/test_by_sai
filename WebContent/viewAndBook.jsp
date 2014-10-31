<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View and Book</title>

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

}

.destinationFont{
color: Green;

}
</style>

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
			<h2 align="center">View and Book your Flight</h2> <br>
			
			<form action="ViewAndBookServlet" method="post" class="form-horizontal">
				<div class ="row">
					<div class="col-md-6 col-md-offset-3">
						<legend><strong>Flight Details</strong></legend>
						
						<strong> From: <span class="sourceFont"><%= session.getAttribute("source") %></span><br/>
						To: <span class="destinationFont"> <%= session.getAttribute("destination") %> </span></strong>
						
						
							<table class="table table-striped">
						        <tbody>
						            <tr>
						            	<th>Flight # / Plane No.</th>
						                <td><%= session.getAttribute("flight_number") %> / <%= session.getAttribute("plane_number") %></td>
						                <input type="hidden" name="plane_number" value="<%= session.getAttribute("plane_number")%>" />
						            </tr>
						        </tbody>
						        
						        <tbody>
						            <tr>
						            	<th>Departure Time</th>
						                <td><%= session.getAttribute("deptTime") %> </td>
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
						                <td><%= session.getAttribute("stops") %>  
						                </td>
						            </tr>
						        </tbody>
						        
						        <tbody>
						            <tr>
						            	<th>Cost</th>
						                <td>$<%= session.getAttribute("cost") %></td>
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
						                <td>	
																	
											<select id="number_of_seats" name="number_of_seats" class="form-control">
				 
											  <option value="1">1</option>
											 
											  <option value="2">2</option>
											 
											  <option value="3">3</option>
											  
											  <option value="4">4</option>
											 
											  <option value="5">5</option>
											 
											  <option value="6">6</option>
											  
											  <option value="7">7</option>
											 
											  <option value="8">8</option>
											 
											  <option value="9">9</option>
											  
											  <option value="10">10</option>
											  
											</select>
						                </td>
						            </tr>
						        </tbody>  
					    </table>
						<button type="submit" class="btn btn-primary">Select</button>
									
						
						
						&nbsp;&nbsp;
						<a href="flightSearchResults.jsp" class="btn btn-success">Back</a>
						&nbsp;&nbsp;
						<a href="flightSearchQuery.jsp" class="btn btn-warning">Home</a>
						
						<a href="underConstruction.jsp" class="btn btn-info pull-right">Add More Flights</a>

					</div>
				</div>
			</form>
			
			<br>
		</div>
	</div>

</body>
</html>