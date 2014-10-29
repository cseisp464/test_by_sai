package com.cseisp464.servlets;

public class Flights {
	
	private String flight_number;
	private String operator_name;
	private String source;
	private String destination;
	private long departure_time;
	private long arrival_time;
	private String plane_number;
	private int firstclass_available;
	private int businessclass_available;
	private int economy_available;
	
	public String getPlane_number() {
		return plane_number;
	}
	public void setPlane_number(String plane_number) {
		this.plane_number = plane_number;
	}
	public int getFirstclass_available() {
		return firstclass_available;
	}
	public void setFirstclass_available(int firstclass_available) {
		this.firstclass_available = firstclass_available;
	}
	public int getBusinessclass_available() {
		return businessclass_available;
	}
	public void setBusinessclass_available(int businessclass_available) {
		this.businessclass_available = businessclass_available;
	}
	public int getEconomy_available() {
		return economy_available;
	}
	public void setEconomy_available(int economy_available) {
		this.economy_available = economy_available;
	}
	public String getFlight_number() {
		return flight_number;
	}
	public void setFlight_number(String flight_number) {
		this.flight_number = flight_number;
	}
	public String getOperator_name() {
		return operator_name;
	}
	public void setOperator_name(String operator_name) {
		this.operator_name = operator_name;
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
	public long getDeparture_time() {
		return departure_time;
	}
	public void setDeparture_time(long departure_time) {
		this.departure_time = departure_time;
	}
	public long getArrival_time() {
		return arrival_time;
	}
	public void setArrival_time(long arrival_time) {
		this.arrival_time = arrival_time;
	}
	
}
