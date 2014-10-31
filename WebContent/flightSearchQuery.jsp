<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Flight Search Query</title>

<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>

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
	$( "#travelDepartingDate" ).datepicker();
	$( "#travelReturningDate" ).datepicker();
	var availableTags = [
	                     "ATL-Hartsfield-Jackson Atlanta International Airport,GA,US",
	                     "ANC-Ted Stevens Anchorage International Airport,AK,US",
	                     "AUS-Austin-Bergstrom International Airport,TX,US",
	                     "BWI-Baltimore Washington International Airport,MD,US",
	                     "BOS-Logan International Airport,MA,US",
	                     "CLT-Charlotte Douglas International Airport,NC,US",
	                     "MDW-Chicago Midway International Airport,IL,US",
	                     "ORD-Chicago O'Hare International Airport,IL,US",
	                     "CVG-Cincinnati/Northern Kentucky International Airport,KY,US",
	                     "CLE-Cleveland Hopkins International Airport,OH,US",
	                     "CMH-Port Columbus International Airport,OH,US",
	                     "DFW-Dallas/Fort Worth International Airport,TX,US",
	                     "DEN-Denver International Airport,CO,US",
	                     "DTW-Detroit Metro Wayne County Airport,MI,US",
	                     "FLL-Fort Lauderdale - Hollywood International Airport,FL,US",
	                     "RSW-SW Florida International Airport,FL,US",
	                     "BDL-Bradley International Airport,CT,US",
	                     "HNL-Honolulu International Airport,HI,US",
	                     "IAH-George Bush Intercontinental Airport,TX,US",
	                     "HOU-William P Hobby Airport,TX,US",
	                     "IND-Indianapolis International Airport,IN,US",
	                     "MCI-Kansas City International Airport,MO,US",
	                     "MCO-Orlando International Airport,FL,US",
	                     "PHL-Philadelphia International Airport,PA,US",
	                     "PHX-Phoenix Sky Harbor International Airport,AZ,US", 
	                     "PIT-Pittsburgh International Airport,PA,US", 
	                     "PDX-Portland International Airport,OR,US", 
	                     "RDU-Raleigh-Durham International Airport,NC,US", 
	                     "SMF-Sacramento International Airport,CA,US", 
	                     "SLC-Salt Lake City International Airport,UT,US", 
	                     "SAT-San Antonio International Airport,TX,US", 
	                     "SAN-San Diego International Airport,CA,US", 
	                     "SFO-San Francisco International Airport,CA,US", 
	                     "SJC-San Jose International Airport,CA,US", 
	         			 "SNA-John Wayne Airport,CA,US", 
	         			 "SEA-Seattle-Tacoma International Airport,WA,US", 
	         			 "STL-Lambert-St. Louis International Airport,MO,US", 
	         			 "TPA-Tampa International Airport,FL,US", 
	         			 "IAD-Washington Dulles International Airport,VA,US", 
	         			 "DCA-Ronald Reagan Washington National Airport,VA,US"
	                   ];
	
	//airport iata codes
	/*String[] airports = {"ATL", "ANC", "AUS", "BWI", "BOS", "CLT", "MDW", "ORD", "CVG", "CLE", 
			"CMH", "DFW", "DEN", "DTW", "FLL", "RSW", "BDL", "HNL", "IAH", "HOU", "IND", "MCI", 
			"LAS", "LAX", "MEM", "MIA", "MSP", "BNA", "MSY", "JFK", "LGA", "EWR", "OAK", "ONT", 
			"MCO", "PHL", "PHX", "PIT", "PDX", "RDU", "SMF", "SLC", "SAT", "SAN", "SFO", "SJC", 
			"SNA", "SEA", "STL", "TPA", "IAD", "DCA"}; */
	
	$( "#source" ).autocomplete({
	      source: availableTags
	    });
	$( "#destination" ).autocomplete({
	      source: availableTags
	    });
	
	// Validating 'From' and 'To' fields, Searching from and to the same city is not possible
	$("#search").click(function(event){
		if($('#source').val() == $('#destination').val()){
			event.preventDefault();
			alert("Searching from and to the same city is not possible");
		}
	    
	  });
	
	  $('.dropdown').hover(
		      function() {
		        $(this).find('.dropdown-menu').stop(true, true).delay(200).fadeIn();
		      }, 
		      function() {
		        $(this).find('.dropdown-menu').stop(true, true).delay(200).fadeOut();
		      }
		    );

});

</script>
<style>

.paddingDiv{
	padding-right:50px;
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
			<h2 align="center">Search your Flight!</h2> <br> 
			
			<form action="FlightSearchQueryServlet" method="post" class="form-horizontal"> <!--  FlightSearchQueryServlet flightSearchResults.jsp ui-widget -->
				<div class ="row">
					<div class="col-md-6 col-md-offset-3">
						
						<div class="col-md-12">
							<div class="btn-group" data-toggle="buttons">
							  <label class="active paddingDiv">
							    <input type="radio" name="roundtrip" id="roundtrip" checked> Roundtrip
							  </label>
							  <label class="paddingDiv">
							    <input type="radio" name="oneway" id="oneway"> One way
							  </label>
							  <label class="paddingDiv">
							    <input type="radio" name="multicity" id="multicity"> Multicity
							  </label>
							</div>
				        </div>
				        
				        <div class="col-md-6 paddingDiv">
							<div class="form-group">
								<label for="source">From</label> 		
								<input 
									type="text" 
									class="form-control" 
									id="source" 
									name="source"
									required> 
							</div>
						</div>
						
						
						<div class="col-md-6 paddingDiv">	
							<div class="form-group">
								<label for="destination">To</label> 		
								<input
									type="text" 
									class="form-control" 
									id="destination" 
									name="destination"
									required>  
							</div>
						</div>
						
						
						<div class="col-md-6 paddingDiv">
							<div class="form-group">
								<label for="travelDepartingDate">Departing</label> 		
								<input
									type="text" 
									class="form-control" 
									id="travelDepartingDate" 
									name="travelDepartingDate"
									required>  
							</div>
						</div>
						
						<div class="col-md-6 paddingDiv">
							<div class="form-group">
								<label for="travelReturningDate">Returning</label> 		
								<input
									type="text" 
									class="form-control" 
									id="travelReturningDate" 
									name="travelReturningDate"
									required>  
							</div>
						</div>	
							
						<div class="col-md-6 paddingDiv">	
							<div class="form-group">
								<label for="number_of_passengers">Passengers</label> 		
								<input
									type="text" 
									class="form-control" 
									id="number_of_passengers" 
									name="number_of_passengers"
									required>  
							</div>
						</div>
							
						<div class="col-md-6 paddingDiv">	
							<div class="form-group">
								<label for="ticketClass">Class</label> 		
																
								<select class="form-control" id="ticket_class" name="ticket_class">
	 
								  <option value="Economy">Economy</option>
								 
								  <option value="First">First</option>
								 
								  <option value="Business">Business</option>
								  
								</select>	
									  
							</div>
						</div>
						
						<button type="submit" id="search" class="btn btn-primary">Search</button>
						
						<!-- <a href="bookingHistory.jsp" class="btn btn-success">View my Booking History</a>
						
						 <a href="login.jsp" class="btn btn-default pull-right">Logout</a>  -->


					</div>
				</div>
			</form>
			
			<br>
		</div>
	</div>

</body>
</html>