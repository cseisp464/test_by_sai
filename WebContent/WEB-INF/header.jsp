<script>
$(document).ready(function(){

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

<nav role="navigation" class="navbar navbar-default navbar-inverse navbar-fixed-top">
	<div class="container">
        <div class="navbar-header">
				<a class="navbar-brand" href="#">Airline Reservation System</a>
		</div>
        <!-- Collection of nav links, forms, and other content for toggling -->
        
        <c:url value="/BookingHistoryServlet" var="BookingHistoryServletURL">
	  		<c:param name="sessionId" value="${pageContext.session.id}"/>
		</c:url>
		
		<c:url value="/flightSearchQuery.jsp" var="flightSearchQueryURL">
	  		<c:param name="sessionId" value="${pageContext.session.id}"/>
		</c:url>  
		
		<c:url value="/LogoutServlet" var="LogoutServletURL">
	  		<c:param name="sessionId" value="${pageContext.session.id}"/>
		</c:url> 
	
	
        <div id="navbarCollapse" class="collapse navbar-collapse">
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a data-toggle="dropdown" class="dropdown-toggle" href="#">Welcome <c:out value="${sessionScope.client.user.fname}" /> 
                    <c:out value="${sessionScope.client.user.lname}" />, <c:out value="${sessionScope.client.org.organization_name}" /> 
                    <b class="caret"></b></a>
                    <ul role="menu" class="dropdown-menu">
                        <li><a href="signup.jsp">Register</a></li>
                        <li><a href="${flightSearchQueryURL}">Search Flights</a></li>
                        <li><a href="${BookingHistoryServletURL}">Booking History</a></li>
                        <li class="divider"></li>
                        <li><a href="${LogoutServletURL}">Logout</a></li>
                        
                        
                        <!-- <li><a href="${signupURL}">Register</a></li>
                        <li><a href="${flightSearchQueryURL}">Search Flights</a></li>
                        <li><a href="${BookingHistoryServletURL}">Booking History</a></li>
                        <li class="divider"></li>
                        <li><a href="${LogoutServletURL}">Logout</a></li> -->
                        
                        
                    </ul>
                </li>
            </ul>
        </div>
     </div>
</nav>




