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

<script>


$(document).ready(function() {
    //var numberOfTickets = $("#number_of_seats").val();
	    
     $("#AddedShoppingCart").hide();
     $("#NotAdded").hide();
    $("#add_to_cart").click(function() {
    	//alert("In ad to cart");
    	
    	var number_of_seats = $("#number_of_seats").val();
        var plane_number= $("#plane_number").val();
        var flight_number= $("#flight_number").val();
        var ticket_class =  $("#ticket_class").val();
        var source =  $("#source").val();
        var destination =  $("#destination").val();
        var deptTime =  $("#deptTime").val();
        var arrTime =  $("#arrTime").val();
        var operator = $("#operator").val();
        var duration = $("#duration").val();
               
        //console.log(numberOfTickets);
        $.post("AddToCartServlet", 
        {
        	plane_number: plane_number,
        	flight_number: flight_number,
            ticket_class: ticket_class,
            number_of_seats: number_of_seats,
            source:source,
            destination:destination,
            deptTime:deptTime,
            arrTime:arrTime,
            operator:operator,
            duration:duration,            
        }, function(data,status) {
            console.log(data);
            //alert("Data: " + data + "\nStatus: " + status);
            if (data =="Flight successfully added to cart") {
                console.log(data);
                $("#AddedShoppingCart").slideDown(500)
                .delay(5000)
                .slideUp(500);
            } else {
                console.log(data);
                $("#NotAdded").slideDown(500)
                .delay(5000)
                .slideUp(500);
            }
        });
    });
    
   

    //alert(plane_number + " ----- " + ticket_class);
    var plane_number= $("#plane_number").val();
    var ticket_class =  $("#ticket_class").val();

    $.get("ViewAndBookServlet?plane_number="+plane_number+"&ticket_class="+ticket_class,function(data,status){
    //alert("Data: " + data + "\nStatus: " + status);

    var ticketsAvailable = parseInt(data);
    console.log(ticketsAvailable);
      
     // var ticketsAvailableList = new Array();
     if(ticketsAvailable <10){
      for (var i=1;i<=ticketsAvailable;i++){
    	  $("#number_of_seats").append("<option value="+i+">"+i).append("</option>");
      }
      }
     else {
    	 for (var i=1;i<=10;i++){
        	  $("#number_of_seats").append($('<option></option>').val(i).html(i));
        	 
          }
     }
     
    });

    
    
    
});
</script>

<style>

.inactive{
   display:none;
}

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
					<div id ="AddedShoppingCart">
  						<h3 align="center" class="destinationFont">Flight Successfully added to shopping cart !</h3>
        			</div>
        
			        <div id="NotAdded">
			  			<h3 align="center"  class="sourceFont">Error! Not Added to shopping cart. Please try again</h3>
			  		</div>      
						
					<br/>
			<!-- <form action="ViewAndBookServlet" method="post" class="form-horizontal"> -->
				<div class ="row">
					<div class="col-md-6 col-md-offset-3">
						<legend><strong>Flight Details</strong></legend>
						
						<strong> From: <span class="sourceFont"><%= session.getAttribute("source") %></span><br/><input type="hidden" name="source" id="source" value="<%= session.getAttribute("source")%>" />
						To: <span class="destinationFont"> <%= session.getAttribute("destination") %> </span></strong><input type="hidden" name="destination" id="destination" value="<%= session.getAttribute("destination")%>" />
						<input type="hidden" name="operator" id="operator" value="<%= session.getAttribute("operator")%>" />
						
							<table class="table table-striped">
						        <tbody>
						            <tr>
						            	<th>Flight # / Plane No.</th>
						                <td><%= session.getAttribute("flight_number") %> / <%= session.getAttribute("plane_number") %></td>
						                <input type="hidden" name="flight_number" id="flight_number" value="<%= session.getAttribute("flight_number")%>" />
						                <input type="hidden" name="plane_number" id="plane_number" value="<%= session.getAttribute("plane_number")%>" />
						            </tr>
						        </tbody>
						        
						        <tbody>
						            <tr>
						            	<th>Departure Time</th>
						                <td><%= session.getAttribute("deptTime") %> </td>
						                <input type="hidden" name="deptTime" id="deptTime" value="<%= session.getAttribute("deptTime")%>" />
						            </tr>
						        </tbody>
						        
						        <tbody>
						            <tr>
						            	<th>Arrival Time</th>
						                <td><%= session.getAttribute("arrTime") %></td>
						                <input type="hidden" name="arrTime" id="arrTime" value="<%= session.getAttribute("arrTime")%>" />
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
						                <input type="hidden" name="ticket_class" id="ticket_class" value="<%= session.getAttribute("ticket_class")%>" />
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
						                <input type="hidden" name="duration" id="duration" value="<%= session.getAttribute("duration")%>" />
						            </tr>
						        </tbody>
						        
						        <tbody>
						            <tr>
						            	<th>Number of Seats</th>
						            	
						            	<td><select id="number_of_seats" name="number_of_seats" class="form-control">
  					
										</select> </td>
						            </tr>
						        </tbody>  
					    </table>
						<button class="btn btn-primary" name="add_to_cart" id="add_to_cart" value="add_to_cart">Add to Cart</button>
									
						
						
						&nbsp;&nbsp;
						<a href="flightSearchResults.jsp" class="btn btn-success">Back to search results</a>
						&nbsp;&nbsp;
						<a href="flightSearchQuery.jsp" class="btn btn-warning">Home</a>
						
						<a href="shoppingCart.jsp" class="btn btn-info pull-right">Shopping Cart</a>

					</div>
				</div>
			<!-- </form> -->
			
			<br>
		</div>
		
		<br /> <br /> <br />

	

	</div>

</body>
</html>