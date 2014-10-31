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

<script type="text/javascript">

$(document).ready(function(){
	
	window.print();
	
});


</script>

<title>Print Page</title>

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
		<div class ="row">
			<div class="col-md-12">
						<legend><strong>Ticket & Passenger Details</strong></legend>
						
						<strong> From: <span class="sourceFont"><%= session.getAttribute("source") %></span><br/>
						To: <span class="destinationFont"> <%= session.getAttribute("destination") %> </span></strong>
						
						<table class="table table-striped">
					       
					       <tbody>
					       	<tr>
					       		<th>Name</th>
					       		<td><%= session.getAttribute("name") %></td>
					       	</tr>
					       </tbody>
					       
					       <tbody>
					       	<tr>
					       		<th>Age</th>
					       		<td><%= session.getAttribute("age") %></td>
					       	</tr>
					       </tbody>
					       
					       <tbody>
					       	<tr>
					       		<th>Gender</th>
					       		<td><%= session.getAttribute("gender") %></td>
					       	</tr>
					       </tbody>
					       
					       <tbody>
					       	<tr>
					       		<th>Source</th>
					       		<td><%= session.getAttribute("source") %></td>
					       	</tr>
					       </tbody>
					       
					       <tbody>
					       	<tr>
					       		<th>Destination</th>
					       		<td><%= session.getAttribute("destination") %></td>
					       	</tr>
					       </tbody>

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
					       		<th>Total Duration</th>
					       		<td><%= session.getAttribute("duration") %></td>
					       	</tr>
					       	</tbody>
					       <tbody>
					       	<tr>
					       		<th>Number of seats</th>
					       		<td><%= session.getAttribute("confirmed_number_of_seats") %></td>
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
					       		<th>Total Cost</th>
					       		<td>$<%= session.getAttribute("total_cost") %></td>
					       	</tr>
					       	</tbody>

					   </table>

					   </div>
				</div>
		

</body>
</html>