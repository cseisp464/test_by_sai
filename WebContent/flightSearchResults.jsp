<%@page import="com.cseisp464.servlets.Flights"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
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
<%@ page errorPage="/WEB-INF/noValuesInlistError.jsp" %>
	<%@ include file="/WEB-INF/header.jsp" %>
	
	<%
	// checking if session exists, if not then redirect to login page
		if(session.getAttribute("username") == null){
			response.sendRedirect("login.jsp");
		}
	
	%>
	
	<div class="container">
		<div class="jumbotron">
			<h2 align="center">Flight Search Results</h2> <br>
			
			<legend><strong>From: <span class="sourceFont"><%= session.getAttribute("source") %></span> <br/>
			 				To: <span class="destinationFont"><%= session.getAttribute("destination") %></span></strong>
			 </legend>
				<table class="table table-striped">
			        <thead>
			            <tr>
			                <th>Price</th>
			                <th>Departure</th>
			                <th>Arrival</th>
			                <th>Stops</th>
			                <th>Duration</th>
			                <th>Airline</th>
			            </tr>
			        </thead>
			        <tbody>
			        	
						<%
						List<Flights> l =(ArrayList<Flights>) session.getAttribute("flightsBean");
						
						for(int i=0;i<l.size();i++){ %>
						
						
						<tr>
						<%
						String flight_number = l.get(i).getFlight_number();
						String plane_number = l.get(i).getPlane_number();
						long diff = l.get(i).getArrival_time() - l.get(i).getDeparture_time() ;
						long diffSeconds = diff / 1000 % 60;
						long diffMinutes = diff / (60 * 1000) % 60;
						long diffHours = diff / (60 * 60 * 1000) % 24;
						long diffDays = diff / (24 * 60 * 60 * 1000);
						String duration = diffHours + "hr " + diffMinutes + "min " ;					
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy MMM dd, hh:mm a");
						String dept_time = sdf.format(new java.util.Date(l.get(i).getDeparture_time()));
						String arvl_time = sdf.format(new java.util.Date(l.get(i).getArrival_time()));
						int cost = l.get(i).getFlight_ticketPrice();
						%>
						<% int stops = 0; %>
						<td>$<%=cost %> <br/> 
							<form action="FlightSearchResultsServlet" method="post">
								<input type="hidden" name="flight_number" value="<%=flight_number%>" />
								<input type="hidden" name="plane_number" value="<%=plane_number%>" />
								<input type="hidden" name="stops" value="<%=stops%>" />
								<input type="hidden" name="cost" value="<%=cost%>" />
								<input type="hidden" name="deptTime" value="<%=dept_time%>" />
								<input type="hidden" name="arrTime" value="<%=arvl_time%>" />
								<input type="hidden" name="duration" value="<%=duration%>" />
								<button type="submit" class="btn btn-success">View and Book</button>
							</form></td>
						<td><%= dept_time %></td>
						<td><%= arvl_time %></td>
						<td> <%=stops %></td>
						<td> <%=duration %></td>
						<td><%=l.get(i).getOperator_name() %></td>
						</tr>
						
						
						<%} %>
						

			        </tbody>
			    </table>
		</div>
	</div>

</body>
</html>