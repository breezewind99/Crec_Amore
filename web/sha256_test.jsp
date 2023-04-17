<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%@ include file="/common/function.jsp" %>
<%

	out.print("Login Sha512 PW Check" +"<br>");
	out.print("+==============================================================+" +"<br>");
	out.print("|" +"<br>");
	out.print("| Login Pw : 1111, sha512 pw : " + encryptSHA512("1111") +"<br>");
	out.print("|" +"<br>");
	out.print("+==============================================================+" +"<br>");

	String login_ip = "1.1.1.1";
	String dbIpAddr = "1.1.1.1 ";
	String tmpIpAddr = dbIpAddr.trim();
	if (! login_ip.trim().equals(tmpIpAddr.trim()) && dbIpAddr.trim().length() > 0) {
		out.print("login ip : " + login_ip + ", dbIpAddr : " + dbIpAddr);
		logger.info ("login ip : " + login_ip + ", dbIpAddr : " + dbIpAddr);
	}
%>	