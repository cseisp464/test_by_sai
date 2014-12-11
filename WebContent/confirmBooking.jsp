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
<title>Confirm Booking</title>

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

<script type="text/javascript">
$(document).ready(function(){
	
	
	$('#transactionconfirmation').hide();
	$('#TransactionSuccessful').hide();
	$("#NoFunds").hide();
	$("#NoAccount").hide();
	$("#NoRouting").hide();
	$("#wrongPassword").hide();
	
	
	$('#submit').click(function(event){
		
		//alert("acc no: " +  $("#account_number").val());
		
		if($('#routing_number').val().length!=9){
			alert("Routing number should be of 9-digts");
			event.preventDefault();
		}
		
		else if($('#password1').val().length!=3){
			alert("Pin should be of 3-digts");
			event.preventDefault();
		}
		
		else if($('#account_number').val().length!=10){
			alert("Account number should be of 10-digts");
			event.preventDefault();
		}
		else{
				var return_status = "";
		    	var account_number =  $("#account_number").val();
		    	var routing_number = $("#routing_number").val();
		    	var total_cost= $("#total_cost").val();
		    	var password = $("#password1").val();
		    	var url = $("#url").val();
		    	console.log(url);
		    	
		    	//alert("acc no: " + account_number + "  routing no: " + routing_number + "  cost: " + total_cost);
		    	
		    	console.log(total_cost);
				
		    	//alert("Before Post");
		    	
			   	$.post("/Banking/BankServlet",
			   			  {
			   		  		account_number: account_number,
			   		  		routing_number: routing_number,
			   		  		total_cost: total_cost,
			   		  		password:password,
			   		  		  		  	    			    
			   			  },
			   			  function(data,status){
			   				console.log(data);
			   			    //alert("Data: " + data + "\nStatus: " + status);
			   			    if(data == "success"){
			   			    	console.log(data);
			   			    	$("#TransactionSuccessful").slideDown(500)
			                    .delay(5000)
			                    .slideUp(500);
			   			    	$('#transaction').hide();
			   			    	$('#transactionconfirmation').show();
			   			    	
			   			    	//alert("Updating bookings");
			   			    	return_status = data;
			   			    	updateBookingHistory(url);
			   			    	
			   			    }
			   			 	else if(data=="Entered Password is wrong <br/>"){
			   			    	console.log(data);
			   			    	$("#wrongPassword").slideDown(500)
			                    .delay(5000)
			                    .slideUp(500);
			  			    	
			   			    }
			   			    else if(data=="Insufficient Balance <br/>"){
			   			    	console.log(data);
			   			    	$("#NoFunds").slideDown(500)
			                    .delay(5000)
			                    .slideUp(500);
			  			    	
			   			    }
			   			    else if(data=="Routing Number is Wrong <br/>"){
			   			    	console.log(data);
			   			    	$("#NoAccount").slideDown(500)
			                    .delay(5000)
			                    .slideUp(500);
			  			    	
			   			    }
			   			    else{
			   			    	console.log(data);
			   			    	$("#NoAccount").slideDown(500)
			                    .delay(5000)
			                    .slideUp(500);
			   			    	
			   			    }
			    });
			   	
		}
	});
	
	$("#print").click(function(){
		
		if( $("#age").val()=="" || $("#gender").val()=="" || $("#firstname").val()=="" || $("#lastname").val()=="" ){
			alert("Enter your details correctly");
		}
		else{
			window.print();
		}
		
	});
	
});

function updateBookingHistory(url){
	
	var account_number =  $("#account_number").val();
	console.log(account_number);
	//alert("in update");
	
	$.post(url,
   			  {
   		  		account_number: account_number,
   		  		  		  	    			    
   			  },
   			  function(data,status){
   				console.log(data);
   			    //alert("Data: " + data + "\nStatus: " + status);
   			    if(data == "success"){
   			    	console.log(data);
   			    	//code for updating the bookings
   			    }
   			    else{
   			    	alert("Failed");
   			    	console.log(data);
   			    	
   			    }
    });
}


</script>

<script type="text/javascript">
      
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
	
	<c:url value="/login.jsp" var="loginURL">
	  <c:param name="sessionId" value="${pageContext.session.id}"/>
	</c:url>
	
	<c:url value="/UpdateBookingHistoryServlet" var="UpdateBookingHistoryServletURL">
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
		
			<div id="NoAccount">
  			<h3 align="center">Sorry, Invalid Account!</h3>
  			<p align="center">The account number you have entered is invalid (or) the account no. and routing no. combination is wrong , please try again.</p>
  			</div> 
  			
  			<div id="wrongPassword">
  			<h3 align="center">Sorry, Wrong Password! Try Again</h3>
  			</div>
  			
  			  
  			
  			<div id="NoRouting">
  			<h3 align="center">Sorry, Invalid Routing Number!</h3>
  			</div>    
        
        
	        <div id="NoFunds">
  			<h3 align="center">Sorry, Insufficient Funds!</h3>
  			<p align="center">Please enter another account with sufficient funds to make the purchase.</p>
  			</div>      

	        <div id="TransactionSuccessful">
	  			<h2 align="center">Transaction Successful !</h2>     
	        </div>
        
        <%
	
					@SuppressWarnings("unchecked")
					List<ShoppingCart> cart = (List<ShoppingCart>) session.getAttribute("cart");
				
					// checking if session exists, if not then redirect to login page
					if(session.getAttribute("username") == null){
						response.sendRedirect("login.jsp");
					}
				
				%>
        
        	<div id="transaction"> 
				<h2 align="center">Transactions Page</h2> <br>
				
				
				
				
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
								   			<c:out value="${flight.flight_id}"/>
								   			<c:set var="fid" value="${flight.flight_id}" />
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
								   			<c:out value="${flight.numberOfTickets}"/>
								   			
								   		</td>
								   		<td>
								   			$ <c:out value="${flight.total_cost}"/>
								   			<c:set var="sum" value="${sum + flight.total_cost}" />
								   		</td>
								   	
									 	
								   	</tr>  
	   	
								</c:forEach>
								<c:set var="total_purchaseCost" value="${sum}" scope="session"  />
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
							
							<div class="form-group">
							<label for="password1">3-digit Banking Pin</label>
							<input 
								type="password" 
								class="form-control" 
								id="password1" 
								name="password1" 
								required>
							</div>
							
							<input type="hidden" id="total_cost" value="<%= session.getAttribute("total_purchaseCost") %>" />
							
				    </table>
				    <input type="hidden" name="url" id="url" value="${UpdateBookingHistoryServletURL}" />
				    <button id="submit"  class="btn btn-primary">Confirm Transaction</button>
					&nbsp;&nbsp;
					<a href="${flightSearchQueryURL}" class="btn btn-success">Cancel</a>
					&nbsp;&nbsp;
					<a href="login.jsp" class="btn btn-default pull-right">Logout</a>
			</div>
			
			<div id="transactionconfirmation">
				<h2 align="center">Your purchase has been confirmed!</h2> <br>
				
				
					<div class ="row">
						<div class="col-md-12">
							<legend><strong>Transaction Details</strong></legend>
							
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
								   			<c:out value="${flight.flight_id}"/>
								   			<c:set var="fid" value="${flight.flight_id}" />
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
								   			<c:out value="${flight.numberOfTickets}"/>
								   			
								   		</td>
								   		<td>
								   			$ <c:out value="${flight.total_cost}"/>
								   			<c:set var="sum" value="${sum + flight.total_cost}" />
								   		</td>
								   	
									 	
								   	</tr>  
	   	
								</c:forEach>
								<c:set var="total_purchaseCost" value="${sum}" scope="session"  />
	         			</tbody>
	         			</table>
	         			
	         			      
					</div>
				</div>
				<!-- <form action="PrintingServlet" method="post" class="form-horizontal"> -->
					<div class ="row">
						<div class="col-md-12">
							<legend><strong>Passenger Details</strong></legend>
						</div>
						<div  class="col-md-3">
							<div class="form-group">
								<label for="firstname">First Name</label>
								<input 
									type="text" 
									class="form-control" 
									id="firstname" 
									name="firstname"   
									required autofocus>
								</div>
							</div>
							<div  class="col-md-3">
							<div class="form-group">
								<label for="lastname">Last Name</label>
								<input 
									type="text" 
									class="form-control" 
									id="lastname" 
									name="lastname"   
									required autofocus>
								</div>
							</div>
							<div  class="col-md-3">
							<div class="form-group">
								<label for="age">Age</label>
								<input 
									type="text" 
									class="form-control" 
									id="age" 
									name="age"   
									required autofocus>
									</div>
							</div>
							<div  class="col-md-3">
								<div class="form-group">
								<label for="gender">Gender</label>
								<input 
									type="text" 
									class="form-control" 
									id="gender" 
									name="gender"   
									required autofocus>
									</div>
							</div>
							
							<input type="hidden" id="total_cost" value="<%= session.getAttribute("total_purchaseCost") %>" />
	
						    <center><button id="print" class="btn btn-default">Print</a></center>
	
			
			
			</div>
			
			
	</div>
	</div>

</body>
</html>