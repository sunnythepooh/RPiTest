<%@page import="com.pi4j.io.gpio.PinPullResistance"%>
<%@page import="com.pi4j.io.gpio.PinState"%>
<%@page import="com.pi4j.io.gpio.RaspiPin"%>
<%@page import="com.pi4j.io.gpio.GpioPinDigitalOutput"%>
<%@page import="com.pi4j.io.gpio.GpioFactory"%>
<%@page import="com.pi4j.io.gpio.GpioController"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%!
	public void jspInit() {
	    GpioController gpio = GpioFactory.getInstance();
		GpioPinDigitalOutput led0 = gpio.provisionDigitalOutputPin(RaspiPin.GPIO_00, "LED 0");	
		GpioPinDigitalOutput led1 = gpio.provisionDigitalOutputPin(RaspiPin.GPIO_01, "LED 1");
		
		getServletContext().setAttribute("LED0Pin", led0);
		getServletContext().setAttribute("LED1Pin", led1);
	}

	public void jspDestroy() {
		GpioPinDigitalOutput led0 = (GpioPinDigitalOutput) getServletContext().getAttribute("LED0Pin");
		GpioPinDigitalOutput led1 = (GpioPinDigitalOutput) getServletContext().getAttribute("LED1Pin");
		
		led0.setShutdownOptions(true, PinState.LOW, PinPullResistance.OFF);
		led1.setShutdownOptions(true, PinState.LOW, PinPullResistance.OFF);
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Testing 123 Testing</title>
</head>
<body>
<% 	
	GpioPinDigitalOutput led0 = (GpioPinDigitalOutput) getServletContext().getAttribute("LED0Pin");
	GpioPinDigitalOutput led1 = (GpioPinDigitalOutput) getServletContext().getAttribute("LED1Pin");	
%>

<%
	String toggle0 = request.getParameter("LED0");
	String toggle1 = request.getParameter("LED1");
	
	if(toggle0 != null) {
		led0.toggle();
	}
	
	if(toggle1 != null) {
		led1.toggle();
	}

%>

Today's date is <%=new Date().toString() %>

<P>Pin 0 State: <%=led0.getState() %>
<P>Pin 1 State: <%=led1.getState() %>

<form name="toggle" method="get" action="index.jsp">
	<input name="LED0" type="submit" value="Toggle LED 0">
	<input name="LED1" type="submit" value="toggle LED 1">
</form>

</body>
</html>