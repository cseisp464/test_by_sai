package com.cseisp464.servlets;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Random;

public class Bookings {
	private int booking_id;
	private Date date_of_booking;
	private int number_of_seats;
	private long account_id;
	private int flight_id;
	private String user_id;
	private double total_cost;
	
	private String operator;
	private String source;
	private String destination;
	private Date departure_time;
	private Date arrival_time;

	private JDBCHelper db;
	
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public String getDestination() {
		return destination;
	}
	public void setDestination(String destination) {
		this.destination = destination;
	}
	public Date getDeparture_time() {
		return departure_time;
	}
	public void setDeparture_time(Date departure_time) {
		this.departure_time = departure_time;
	}
	public Date getArrival_time() {
		return arrival_time;
	}
	public void setArrival_time(Date arrival_time) {
		this.arrival_time = arrival_time;
	}
	public int getBooking_id() {
		return booking_id;
	}
	public void setBooking_id(int booking_id) {
		this.booking_id = booking_id;
	}
	public Date getDate_of_booking() {
		return date_of_booking;
	}
	public void setDate_of_booking(Date date_of_booking) {
		this.date_of_booking = date_of_booking;
	}
	public int getNumber_of_seats() {
		return number_of_seats;
	}
	public void setNumber_of_seats(int number_of_seats) {
		this.number_of_seats = number_of_seats;
	}
	public long getAccount_id() {
		return account_id;
	}
	public void setAccount_id(long account_id) {
		this.account_id = account_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getFlight_id() {
		return flight_id;
	}
	public void setFlight_id(int flight_id) {
		this.flight_id = flight_id;
	}
	public double getTotal_cost() {
		return total_cost;
	}
	public void setTotal_cost(double total_cost) {
		this.total_cost = total_cost;
	}
	
	public int addingBookingDetails(int seats,
									 long account_no, 
									 String username, 
									 double total_cost) throws SQLException{
		
		Timestamp currentTimestamp = new java.sql.Timestamp(Calendar.getInstance().getTime().getTime());
		System.out.println(currentTimestamp);
		
		int booking_id = validateBookingID();
		
		ArrayList<Object> param =  new ArrayList<Object>();
		param.add(booking_id);
		param.add(currentTimestamp);
		param.add(seats);
		param.add(account_no);
		param.add(username);
		param.add(total_cost);
		
		String query_string = "INSERT INTO bookings values (default,?, ?, ?, ?, ?, ?)";
		connectDB();
		
		int result = db.updateDB(query_string, param);
		
		if(result>0){
			System.out.println("Successfully added the Booking Info");
		}else{
			System.out.println("oops! something went wrong with the booking table");
		}
		
		setAccount_id(account_no);
		setBooking_id(booking_id);
		setDate_of_booking(currentTimestamp);
		setNumber_of_seats(seats);
		setUser_id(username);
		setTotal_cost(total_cost);
		
		closeDB();
		
		return booking_id;
		
	}
	
	private void connectDB(){
		// Testing Database Connection using the JDBC Helper class
		db = new JDBCHelper("cse.unl.edu", "spalusa", "spalusa", "Test@464");
	}
	
	private void closeDB(){
		db.closeDBConnection();
	}
	
	
	// this function adds entries into the booking_flights table
	public void addEntriesInBookingFlightsTable(int booking_id, int flight_id){
		ArrayList<Object> param =  new ArrayList<Object>();
		param.add(booking_id);
		param.add(flight_id);
		
		String query_string = "INSERT INTO booking_flights values (default,?, ?)";
		connectDB();
		int result = db.updateDB(query_string, param);
		if(result>0){
			System.out.println("Successfully added entries into the booking_flights table");
		}else{
			System.out.println("oops! something went wrong updating the booking_flights table");
		}
		
		setFlight_id(flight_id);
		closeDB();
		
	}
	
	// this function randomly generates integer
	private int generateBookingID(){
		Random r = new Random();
		// let max = 11111111, min = 111
		int id = r.nextInt((11111111 - 111)+1) + 111 ;
		return id;
	}
	
	// this function checks if the booking id is already used in the database
	private int validateBookingID() throws SQLException{
		int booking_id = generateBookingID();
		ArrayList<Object> param =  new ArrayList<Object>();
		param.add(booking_id);
		String query_string = "SELECT * FROM bookings"
				+ " WHERE booking_id = ? ";
		connectDB();
		ResultSet rs1 = db.queryDB(query_string, param);
		// If records exist then booking id is already taken
		if(!rs1.next()){
			closeDB();
			return booking_id;
		}else{// kinda recursive!
			validateBookingID();
			return booking_id;
		}
	}
	
	// Function to fetch booking history results
	public List<Bookings> getBookingHistory(String username) throws SQLException{
		
		/*
		 * SQL query (a big one)
		 * select x.booking_id, x.date_of_booking, x.flight_id, y.operator, y.source, y.destination, y.departure, y.arrival, x.number_of_seats, x.total_cost 

			FROM
			
			(select bf.booking_id, bf.flight_id,  b.date_of_booking , b.number_of_seats, b.total_cost
			FROM spalusa.booking_flights as bf 
			JOIN spalusa.bookings as b
			ON bf.booking_id = b.booking_id where b.user_id='username') as x
			
			JOIN
			
			(select bf.booking_id, f.operator, f.source, f.destination, f.departure, f.arrival
			FROM spalusa.booking_flights as bf 
			JOIN cse464.flights as f
			ON bf.flight_id = f.id) as y
			
			ON x.booking_id = y.booking_id;
		 * 
		 */
		ArrayList<Object> param =  new ArrayList<Object>();
		param.add(username);
		
		String query_string = "select x.booking_id, x.date_of_booking, x.flight_id, y.operator, y.source, y.destination, y.departure, y.arrival, x.number_of_seats, x.total_cost"
				+ " FROM "
				+ "(select bf.booking_id, bf.flight_id,  b.date_of_booking , b.number_of_seats, b.total_cost"
				+ " FROM spalusa.booking_flights as bf "
				+ " JOIN spalusa.bookings as b "
				+ " ON bf.booking_id = b.booking_id where b.user_id= ?) as x "
				+ " JOIN "
				+ " (select bf.booking_id, f.operator, f.source, f.destination, f.departure, f.arrival "
				+ " FROM spalusa.booking_flights as bf "
				+ " JOIN cse464.flights as f "
				+ " ON bf.flight_id = f.id) as y "
				+ " ON x.booking_id = y.booking_id  ORDER BY x.date_of_booking DESC";
		
		connectDB();
		ResultSet rs1 = db.queryDB(query_string, param);
		
		System.out.println(rs1.getStatement());
		
		List<Bookings> booking_list = new ArrayList<Bookings>();
		
		if(rs1!=null){
			while(rs1.next()){
				Bookings b = new Bookings();
				b.setBooking_id(rs1.getInt("booking_id"));
				b.setFlight_id(rs1.getInt("flight_id"));
				b.setDate_of_booking(new Date(rs1.getTimestamp("date_of_booking").getTime()));
				b.setOperator(rs1.getString("operator"));
				b.setSource(rs1.getString("source"));
				b.setDestination(rs1.getString("destination"));
				b.setDeparture_time(new Date(rs1.getTimestamp("departure").getTime()));
				b.setArrival_time(new Date(rs1.getTimestamp("arrival").getTime()));
				b.setNumber_of_seats(rs1.getInt("number_of_seats"));
				b.setTotal_cost(rs1.getDouble("total_cost"));
				
				booking_list.add(b);
			}
		}
		
		closeDB();
		return booking_list;
	}
	

}
