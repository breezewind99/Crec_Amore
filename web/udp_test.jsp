<%@page import="com.cnet.CnetCrypto.CNCrypto"%>
<%@page import="java.net.DatagramPacket"%>
<%@page import="java.net.InetAddress"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.net.DatagramSocket"%>
<%


	DatagramSocket ds = null;
	String systemIp = "192.168.0.115";
	int port = 20005;

	// UDP 통신 수신 전문
	ds = new DatagramSocket();

	// send data 설정
	InetAddress address = InetAddress.getByName(systemIp);
	String header = "PART#20230112#13#10#40#20230112131105_7167.wav#test#01#";

	System.out.println("address : "+address);
	System.out.println("header : "+header);

	//String header = "NON";
	byte[] buf = header.getBytes();

	// send
	DatagramPacket packet = new DatagramPacket(buf, buf.length, address, port);
	ds.send(packet);

%>	