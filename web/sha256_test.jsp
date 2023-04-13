<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%@ include file="/common/function.jsp" %>
<%

	out.print("Login Sha512 PW Check" +"<br>");
	out.print("+==============================================================+" +"<br>");
	out.print("|" +"<br>");
	out.print("| Login Pw : hnsedu!01, sha512 pw : " + encryptSHA512("hnsedu!01") +"<br>");
	out.print("| Login Pw : hnsedu!02, sha512 pw : " + encryptSHA512("hnsedu!02") +"<br>");
	out.print("| Login Pw : hnsedu!03, sha512 pw : " + encryptSHA512("hnsedu!03") +"<br>");
	out.print("| Login Pw : hnsedu!04, sha512 pw : " + encryptSHA512("hnsedu!04") +"<br>");
	out.print("| Login Pw : hnsedu!05, sha512 pw : " + encryptSHA512("hnsedu!05") +"<br>");
	out.print("| Login Pw : hnsedu!06, sha512 pw : " + encryptSHA512("hnsedu!06") +"<br>");
	out.print("| Login Pw : hnsedu!07, sha512 pw : " + encryptSHA512("hnsedu!07") +"<br>");
	out.print("| Login Pw : hnsedu!08, sha512 pw : " + encryptSHA512("hnsedu!08") +"<br>");
	out.print("| Login Pw : hnsedu!09, sha512 pw : " + encryptSHA512("hnsedu!09") +"<br>");
	out.print("| Login Pw : hnsedu!10, sha512 pw : " + encryptSHA512("hnsedu!10") +"<br>");
	out.print("| Login Pw : hnsedu!11, sha512 pw : " + encryptSHA512("hnsedu!11") +"<br>");
	out.print("| Login Pw : hnsedu!12, sha512 pw : " + encryptSHA512("hnsedu!12") +"<br>");
	out.print("| Login Pw : hnsedu!13, sha512 pw : " + encryptSHA512("hnsedu!13") +"<br>");
	out.print("| Login Pw : hnsedu!14, sha512 pw : " + encryptSHA512("hnsedu!14") +"<br>");
	out.print("| Login Pw : hnsedu!15, sha512 pw : " + encryptSHA512("hnsedu!15") +"<br>");
	out.print("| Login Pw : hnsedu!16, sha512 pw : " + encryptSHA512("hnsedu!16") +"<br>");
	out.print("| Login Pw : hnsedu!17, sha512 pw : " + encryptSHA512("hnsedu!17") +"<br>");
	out.print("| Login Pw : hnsedu!18, sha512 pw : " + encryptSHA512("hnsedu!18") +"<br>");
	out.print("| Login Pw : hnsedu!19, sha512 pw : " + encryptSHA512("hnsedu!19") +"<br>");
	out.print("| Login Pw : hnsedu!20, sha512 pw : " + encryptSHA512("hnsedu!20") +"<br>");
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