<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.cseisp464.servlets.Bookings"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<%@ page errorPage="/WEB-INF/noValuesInlistError.jsp" %>
<%@ include file="/WEB-INF/header.jsp" %>

	<c:choose>
		<c:when test="${sessionScope.username==null}">
			<c:redirect url="login.jsp" />
		</c:when>
		<c:otherwise>
			<c:set var="username" value="${sessionScope.username}" />
		</c:otherwise>
	</c:choose>

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
			<h2 align="center">Booking History</h2> <br>
			<table class="table table-striped">
			        <thead>
			            <tr>
			            	<th>S.No</th>
			                <th>Booking #</th>
			                <th>Date of Booking</th>
			                <!-- <th>Flight #</th> -->
			                <th>Operator</th>
			                <th>Source</th>
			                <th>Destination</th>
			                <th>Departure</th>
			                <th>Arrival</th>
			                <th>Number of Seats</th>
			                <th>Total Cost</th>
			            </tr>
			        </thead>
			        <tbody>
			
					<%
						List<Bookings> l =(ArrayList<Bookings>) session.getAttribute("booking_list");
						
						for(int i=0;i<l.size();i++){ 
						
					%>
			
			
					<tr>
						<td><%= i+1 %></td>
						<td><%= l.get(i).getBooking_id() %></td>
						<td><%= l.get(i).getDate_of_booking() %></td>
						<!-- <td> <%=l.get(i).getFlight_id() %></td>  -->
						<td> <%= l.get(i).getOperator() %></td>
						<td><%= l.get(i).getSource() %></td>
						<td><%=l.get(i).getDestination() %></td>
						<td><%=l.get(i).getDeparture_time() %></td>
						<td><%=l.get(i).getArrival_time() %></td>
						<td><%=l.get(i).getNumber_of_seats() %></td>
						<td>$<%=l.get(i).getTotal_cost() %></td>
					</tr>
					<%
					
						} 
					
					%>
			 	</tbody>
			</table>
			
								       
					       <center><a href="${flightSearchQueryURL}" class="btn btn-warning">Home</a></center>
		</div>
	</div>
	</div>
</div>

</body>
</html>