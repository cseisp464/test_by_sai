package com.cseisp464.servlets;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;

public class Bookings {
	private int booking_id;
	private Date date_of_booking;
	private int flight_id;
	private int number_of_seats;
	private long account_id;
	private String user_id;
	private double total_cost;
	private JDBCHelper db;
	
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
	public int getFlight_id() {
		return flight_id;
	}
	public void setFlight_id(int flight_id) {
		this.flight_id = flight_id;
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
	public double getTotal_cost() {
		return total_cost;
	}
	public void setTotal_cost(double total_cost) {
		this.total_cost = total_cost;
	}
	
	public void addingBookingDetails(int flight_number,
									 int seats,
									 long account_no, 
									 String username, 
									 double total_cost) throws SQLException{
		
		Timestamp currentTimestamp = new java.sql.Timestamp(Calendar.getInstance().getTime().getTime());
		System.out.println(currentTimestamp);
		
		int booking_id = validateBookingID();
		
		ArrayList<Object> param =  new ArrayList<Object>();
		param.add(booking_id);
		param.add(currentTimestamp);
		param.add(flight_number);
		param.add(seats);
		param.add(account_no);
		param.add(username);
		param.add(total_cost);
		
		String query_string = "INSERT INTO bookings values (default,?, ?, ?, ?, ?, ?, ?)";
		connectDB();
		
		int result = db.updateDB(query_string, param);
		
		if(result>0){
			System.out.println("Successfully added the Booking Info");
		}else{
			System.out.println("oops! something went wrong");
		}
		
		setAccount_id(account_no);
		setBooking_id(booking_id);
		setDate_of_booking(currentTimestamp);
		setFlight_id(flight_number);
		setNumber_of_seats(seats);
		setUser_id(username);
		setTotal_cost(total_cost);
		
		closeDB();
		
	}
	
	private void connectDB(){
		// Testing Database Connection using the JDBC Helper class
		db = new JDBCHelper("cse.unl.edu", "spalusa", "spalusa", "Test@464");
	}
	
	private void closeDB(){
		db.closeDBConnection();
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
	

}
