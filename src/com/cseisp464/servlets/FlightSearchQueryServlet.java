package com.cseisp464.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Formatter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import sun.util.locale.provider.AvailableLanguageTags;


/**
 * Servlet implementation class FlightSearchQueryServlet
 */
@WebServlet("/FlightSearchQueryServlet")
public class FlightSearchQueryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FlightSearchQueryServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(false);
		if(session == null){
			response.sendRedirect("login.jsp");
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		out.println("<html><body>");
		
		// Retrieving the user's info form the POST data.
		String source = request.getParameter("source");
		String destination = request.getParameter("destination");
		String departure_date = request.getParameter("travelDepartingDate");
		String arrival_date = request.getParameter("travelReturningDate");
		String number_of_passengers = request.getParameter("number_of_passengers");
		String ticket_class = request.getParameter("ticket_class");

		// Session
		HttpSession session = request.getSession();
		session.setAttribute("source", source);
		session.setAttribute("destination", destination);
		session.setAttribute("departure_date", departure_date);
		session.setAttribute("ticket_class", ticket_class);
		
		// Testing Database Connection using the JDBC Helper class
		JDBCHelper db = new JDBCHelper("cse.unl.edu", "cse464", "spalusa", "Test@464");
		
		// Handling or Formatting Post data before querying the DB
		source = formatSourceOrDestination(source);
		destination = formatSourceOrDestination(destination);
		String[] deptdate = formatDate(departure_date);
		String[] arrdate = formatDate(arrival_date); 
		

		List<Flights> flights_list = new ArrayList<Flights>();
		
		// Query for Departure
		ResultSet rs1 = getResults(source, destination, deptdate, db);
		
		try {
			if (rs1 != null){
				rs1.beforeFirst();
				String operator_name="";
				int fc_available_seats, bc_available_seats, ec_available_seats;
				int number_of_requested_seats = Integer.parseInt(number_of_passengers);
				
				while (rs1.next()){
					fc_available_seats = 0;
					bc_available_seats = 0;
					ec_available_seats = 0;
					Flights flight = new Flights();
					
					// First check if the number of available seats are >= number of seats requested. If yes, only then store in the bean class else ignore
					// Query for results from planes table
					ResultSet rs2 =  getPlaneResults(rs1.getString("plane"), db);
					if (rs2 != null){
						rs2.next();
						
						// calculating the number of available seats in each Ticket class
						ec_available_seats = rs2.getInt("business_capacity") - rs1.getInt("business_reserved");
						fc_available_seats = rs2.getInt("first_class_capacity") - rs1.getInt("first_class_reserved");
						bc_available_seats = rs2.getInt("economy_capacity") - rs1.getInt("economy_reserved");
						
						switch (ticket_class) {
						case "Economy":
							// skip this iteration (because we are not storing the flight results in the bean as there the number of seats requested are more than what are available)
							if(ec_available_seats < number_of_requested_seats)
								continue;
							break;
						case "Business":
							if(bc_available_seats < number_of_requested_seats)
								continue;						
							break;
						case "First":
							if(fc_available_seats < number_of_requested_seats)
								continue;						
							break;
						default:
							break;
						}
											
						flight.setPlane_number(rs2.getString("plane_number"));
						flight.setBusinessclass_available(bc_available_seats);
						flight.setEconomy_available(ec_available_seats);
						flight.setFirstclass_available(fc_available_seats);
						
					}

					//flight.setFlight_number(rs1.getString("plane"));
					flight.setFlight_number(rs1.getString("id"));
					
					operator_name = rs1.getString("operator");
					switch (operator_name) {
					case "AA":
						flight.setOperator_name("American Airlines");
						break;
					case "UA":
						flight.setOperator_name("United Airlines");
						break;
					case "WN":
						flight.setOperator_name("Southwest Airlines");
						break;
					case "B6":
						flight.setOperator_name("JetBlue Airlines");
						break;
					case "AS":
						flight.setOperator_name("Alaska Airlines");
						break;
					case "NK":
						flight.setOperator_name("Spirit Airlines");
						break;
					case "F9":
						flight.setOperator_name("Frontier Airlines");
						break;
					case "DL":
						flight.setOperator_name("Delta Air Lines");
						break;
					default:
						flight.setOperator_name(operator_name);
						break;
					}
					
					
					flight.setSource(rs1.getString("source"));
					flight.setDestination(rs1.getString("destination"));
					flight.setDeparture_time(rs1.getTimestamp("departure").getTime());
					flight.setArrival_time(rs1.getTimestamp("arrival").getTime());
					
					flights_list.add(flight);
					System.out.println("Start Printing values");
					System.out.println(rs1.getString("plane") + " " + rs1.getString("operator") + " " + rs1.getString("source") + " " + rs1.getString("destination") + " " + rs1.getTimestamp("departure") + " " + rs1.getTimestamp("arrival"));
					System.out.println("End Printing values");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		// if the value of list is 0, then redirect to a no results page
		if(flights_list.size() == 0){
			response.sendRedirect("noFlightSearchResults.jsp");
		}
		
		session.setAttribute("flightsBean", flights_list);
		RequestDispatcher rd = request.getRequestDispatcher("flightSearchResults.jsp") ;
		rd.include(request, response);
		disconnectDatabase(db);
	}

	private ResultSet getResults(String source, String destination,
			String[] deptdate, JDBCHelper db) {
		// TODO Auto-generated method stub
		ArrayList<Object> param =  new ArrayList<Object>();
		param.add(source);
		param.add(destination);
		param.add(Integer.parseInt(deptdate[1]));
		param.add(Integer.parseInt(deptdate[0]));
		param.add(Integer.parseInt(deptdate[2]));
		
		String query_string = "SELECT * FROM flights"
				+ " WHERE source = ? "
				+ " AND destination = ? "
				+ " AND DAY(departure) = ? "
				+ " AND MONTH(departure) = ? "
				+ " AND YEAR(departure) = ? ";
		ResultSet rs1 = db.queryDB(query_string, param);
		
		try {
			System.out.println(rs1.getStatement());
			/*if (rs1 != null){
				while (rs1.next()){
					System.out.println(rs1.getString("plane") + " " + rs1.getString("operator") + " " + rs1.getString("source") + " " + rs1.getString("destination") + " " + rs1.getTimestamp("departure") + " " + rs1.getTimestamp("arrival"));
				}
			}*/
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs1;
		
	}
	
	private ResultSet getPlaneResults(String flight_number, JDBCHelper db) {
		// TODO Auto-generated method stub
		ArrayList<Object> param =  new ArrayList<Object>();
		param.add(flight_number);
		
		String query_string = "SELECT * FROM planes"
				+ " WHERE id = ? ";
		
		
		ResultSet rs2 = db.queryDB(query_string, param);
		
		try {
			System.out.println(rs2.getStatement());
			/*if (rs1 != null){
				while (rs1.next()){
					System.out.println(rs1.getString("plane") + " " + rs1.getString("operator") + " " + rs1.getString("source") + " " + rs1.getString("destination") + " " + rs1.getTimestamp("departure") + " " + rs1.getTimestamp("arrival"));
				}
			}*/
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs2;
		
	}

	private String formatSourceOrDestination(String source) {
		// TODO Auto-generated method stub
		String[] buffer = source.split("-");
		return buffer[0];
	}
	
	private String[] formatDate(String departure_date) {
		// TODO Auto-generated method stub
		String[] buffer = departure_date.split("/");
		return buffer;
	}
	
	private void disconnectDatabase(JDBCHelper db) {
		// TODO Auto-generated method stub
		try {
			db.conn.close();
			System.out.println("Database Connection Closed");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
/* Extra Code (Could use it later)
	private String formatDate2(String unformatted_date) {
		// TODO Auto-generated method stub
		Date date = null;
		SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
		try {
			date = sdf.parse(unformatted_date);
			System.out.println(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// Returning a string date in the mysql date format
		return new SimpleDateFormat("yyyy-MM-dd").format(date);
	}
	
	private void disconnectDatabase(JDBCHelper db) {
		// TODO Auto-generated method stub
		try {
			db.conn.close();
			System.out.println("Database Connection Closed");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
*/
	

}
