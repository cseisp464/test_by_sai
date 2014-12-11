package com.cseisp464.servlets;

public class Clients {
	private Users user;
	private Organizations org;
	
	public Clients(Users user, Organizations org){
		setOrg(org);
		setUser(user);
	}

	public Users getUser() {
		return user;
	}

	public void setUser(Users user) {
		this.user = user;
	}

	public Organizations getOrg() {
		return org;
	}

	public void setOrg(Organizations org) {
		this.org = org;
	}
}
