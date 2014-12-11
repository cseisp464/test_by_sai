<%@page import="com.cseisp464.servlets.Flights"%>
<%@page import="com.cseisp464.servlets.ShoppingCart"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<title>Shopping Cart</title>

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">

<!-- Latest compiled and minified JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<script src="//code.jquery.com/jquery-1.10.2.js"></script>

<script>

function editSeats(x,y,z,url){
	//alert("plane no: " + x + " Ticket class " + y + "Flight id: " +z);
	
	$.get("${ViewAndBookServletURL}?plane_number="+x+"&ticket_class="+y,function(data,status){
	    //alert("Data: " + data + "\nStatus: " + status);

	    var ticketsAvailable = parseInt(data);
	    console.log(ticketsAvailable);
	      
	     // var ticketsAvailableList = new Array();
	     if(ticketsAvailable <10){
	      for (var i=1;i<=ticketsAvailable;i++){
	    	  //$('#newnumberoftickets'+x).append("<option value="+i+">"+i).append("</option>");
	    	  
	    	  if(i==$('#oldnumberoftickets'+x).val()){
	    		  $('#newnumberoftickets'+x).append("<option selected='selected' value="+i+" >"+i).append("</option>");
	    		  
	    	  }else{
	    		  $('#newnumberoftickets'+x).append("<option value="+i+">"+i).append("</option>");
	    	  }
	    	  
	    	  
	      }
	      }
	     else {
	    	 for (var i=1;i<=10;i++){
				if(i==$('#oldnumberoftickets'+x).val()){
	    			 
	    			 $('#newnumberoftickets'+x).append($('<option selected="selected"></option>').val(i).html(i));
	    			 
	    		 }else{
	    			 
	    			 $('#newnumberoftickets'+x).append($('<option></option>').val(i).html(i));
	    		 }
	        	 
	          }
	     }
	     
	    });
	
	$('#newnumberoftickets'+x).show();
	
	
	$('#newnumberoftickets'+x).change(function(){
		  //alert("the value is  "+ $('#newnumberoftickets'+x).val() + "  cost  "+$('#oldtotal_cost'+x).val() + " old number of seats " + $('#oldnumberoftickets'+x).val());
		  
		  var plane_number = x;
		  var flight_number = z;
		  var ticket_class = y;
	      var old_total_ticket_cost = $('#oldtotal_cost'+x).val();
	      var old_number_of_seats =  $('#oldnumberoftickets'+x).val();
	      var new_number_of_seats =  $('#newnumberoftickets'+x).val();
		  
		  
		  $.post(url, 
			        {
			        	plane_number: plane_number,
			        	flight_number: flight_number,
			            ticket_class: ticket_class,
			            old_number_of_seats: old_number_of_seats,
			            new_number_of_seats: new_number_of_seats,
			            old_total_ticket_cost: old_total_ticket_cost,            
			        }, function(data,status) {
			            console.log(data);
			            //alert("Data: " + data + "\nStatus: " + status);
			            if (data =="updated cart") {
			            	//alert("WOW UPDATED");
			            	location.reload();
			            }
			});
		  
		  
		  
		  
	});

	
	//alert("hi");
	
}

$(document).ready(function(){
	
	$(".donotshow").hide();

});

</script>


<style>

.sourceFont{

color:Red;

}

.destinationFont{
color: Green;

}

.inactive{
   display:none;
}
</style>
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
	
	<c:url value="/confirmBooking.jsp" var="confirmBookingURL">
	  <c:param name="sessionId" value="${pageContext.session.id}"/>
	</c:url>
	
	<c:url value="/ViewAndBookServlet" var="ViewAndBookServletURL">
	  <c:param name="sessionId" value="${pageContext.session.id}"/>
	</c:url>
	
	<c:url value="/UpdateCartServlet" var="UpdateCartServletURL">
	  <c:param name="sessionId" value="${pageContext.session.id}"/>
	</c:url>
	
	<c:url value="/EditCartServlet" var="EditCartServletURL">
	  <c:param name="sessionId" value="${pageContext.session.id}"/>
	</c:url>
	
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
	
	<div class="container">
		<div class="jumbotron">
			<h2 align="center">My Cart Page</h2> <br>
			
			
			<%

				@SuppressWarnings("unchecked")
				List<ShoppingCart> cart = (List<ShoppingCart>) session.getAttribute("cart");
				List<Flights> flight_list =(List<Flights>) session.getAttribute("flightsBean");
				
			
				// checking if session exists, if not then redirect to login page
				if(session.getAttribute("username") == null){
					response.sendRedirect("login.jsp");
				}
			
			%>
			
			<legend><strong>Added Flights</strong>
			 </legend>
				<table class="table table-striped">
			        <thead>
			            <tr>
			                <th>Flight Number</th>
			                  <th>Operator</th>
			                  <th>Source</th>
			                  <th>Destination</th>
			                  <th>Departure</th>
			                  <th>Arrival</th>
			                  <th>Duration</th>
			                  <th>Class</th>
			                  <th>Number of Tickets</th>
			                  <th>Cost</th>
			            </tr>
			        </thead>
			        <tbody>
						    <c:set var="sum" value="${0}"/>
								<c:forEach items="${cart}" var="flight" varStatus="loop">
								
									 <tr>
								   		<td>
								   		<form action="${EditCartServletURL}" method="post">
								   			<c:out value="${flight.flight_id}"/>
								   			<c:set var="fid" value="${flight.flight_id}" /> <br/><br/>
								   			<button type="button" onclick="editSeats('${flight.plane_number}','${flight.flight_class}','${flight.flight_id}','${UpdateCartServletURL}')" id="edit" class="btn btn-info">Edit</button><br/><br/>
								   			<button type="submit" id="remove" class="btn btn-danger" value="${flight.flight_id}">Remove</button>
								   			<input type="hidden" name="flight_number" id="flight_number" value="${flight.flight_id}" />
								   			<input type="hidden" name="total_cost" id="total_cost" value="${flight.total_cost}" />
								   		
								   		</form>
								   		</td>
								   		
								   		<td>
								   			<c:out value="${flight.operator}"/>
								   		</td>
								   		
								   		<td>
								   			<c:out value="${flight.source}"/>
								   		</td>
								   		
								   		<td>
								   			<c:out value="${flight.destination}"/>
								   		</td>
								   		
								   		<td>
								   			<c:out value="${flight.departure_time}"/>
								   		</td>
								   		
								   		<td>
								   			<c:out value="${flight.arrival_time}"/>
								   		</td>
								   		
								   		<td>
								   			<c:out value="${flight.duration}"/>
								   		</td>

								   		<td>
								   			<c:out value="${flight.flight_class}"/>
								   		</td>
								   		<td>
								   			<c:out value="${flight.numberOfTickets}"/> &nbsp;&nbsp; 
								   			<input type="hidden" id="oldnumberoftickets${flight.plane_number}" value="${flight.numberOfTickets}" />
								   			<select class="donotshow" id="newnumberoftickets${flight.plane_number}" name="number_of_seats" class="form-control">
  					
											</select> 
								   			
								   		</td>
								   		<td>
								   			$ <c:out value="${flight.total_cost}"/>
								   			<input type="hidden" id="oldtotal_cost${flight.plane_number}" value="${flight.total_cost}" />
								   			<c:set var="sum" value="${sum + flight.total_cost}" />
								   		</td>
								   	
									 	
								   	</tr>  
	   	
								</c:forEach>
							<c:set var="total_purchaseCost" value="${sum}" scope="session"  />
         			</tbody>
			    </table>
			    <a href="${confirmBookingURL}">
			    	<button type="button" id="book" class="btn btn-primary btn-lg btn-block">Check Out</button>
			    </a>
		</div>
	</div>

</body>
</html>