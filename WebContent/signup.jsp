<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Registration page</title>
</head>
<body>

<h2 align="center">Registration Page!</h2> <br>

<form action="RegistrationServlet" method="get">

	<fieldset style="width: 300px">
		<legend>Enter Your Info</legend>
		<table>
			<tr>
				<td>First Name</td>
				<td><input type="text" name="firstname"/> </td>
			</tr>
			<tr>
				<td>Last Name</td>
				<td><input type="text" name="lastname" /> </td>
			</tr>
			
			<tr>
				<td>Username</td>
				<td><input type="text" name="username"/> </td>
			</tr>
			
			<tr>
				<td>Password</td>
				<td><input type="password" name="password1" /> </td>
			</tr>
			
			<tr>
				<td>Retype Password</td>
				<td><input type="password" name="password2" /> </td>
			</tr>
			
			<tr>
				<td>Email</td>
				<td><input type="text" name="email" /> </td>
			</tr>
			
			<tr>
				<td><input type="submit" value="signup" /></td>
			</tr>
			
		</table>
	</fieldset>



</form>

</body>
</html>