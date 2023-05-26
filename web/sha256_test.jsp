<%@ page import="com.cnet.crec.util.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.io.File" %>
<%@ page import="java.nio.file.Path" %>
<%@ page import="java.nio.file.Files" %>
<%@ page import="java.nio.file.StandardCopyOption" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%@ include file="/common/function.jsp" %>
<%

	out.print("Login Sha512 PW Check" +"<br>");
	out.print("+==============================================================+" +"<br>");
	out.print("|" +"<br>");
	out.print("| Login Pw : 1111, sha512 pw : " + encryptSHA512("1111") +"<br>");
	out.print("| Login Pw : cnet2580!, sha512 pw : " + encryptSHA512("cnet2580!") +"<br>");
	out.print("|" +"<br>");
	out.print("+==============================================================+" +"<br>");

	String login_ip = "1.1.1.1";
	String dbIpAddr = "1.1.1.1 ";
	String tmpIpAddr = dbIpAddr.trim();
	if (! login_ip.trim().equals(tmpIpAddr.trim()) && dbIpAddr.trim().length() > 0) {
		out.print("login ip : " + login_ip + ", dbIpAddr : " + dbIpAddr);
		logger.info ("login ip : " + login_ip + ", dbIpAddr : " + dbIpAddr);
	}

	String sourceURL = "https://prod-apne2-recording-playback.s3.ap-northeast-2.amazonaws.com/MediaCache/84d69cc8-c0c9-4fc8-956d-4239f5ae6806/cfb00176-83bd-40a8-a369-667e5a9ae189/isDownloading%3Atrue_format%3AWAV_variableWidth%3Atrue_color%3A2719929_version%3Av2_expandAttachments%3Atrue/AUDIO_SGAXDAMDTFU4TEMRTGM3TEMBTGY4DKNBXG43C4MBQOM%3D%3D%3D%3D%3D%3D.WAV?response-content-disposition=attachment%3Bfilename%3D%22MediaCache%2F84d69cc8-c0c9-4fc8-956d-4239f5ae6806%2Fcfb00176-83bd-40a8-a369-667e5a9ae189%2FisDownloading%3Atrue_format%3AWAV_variableWidth%3Atrue_color%3A2719929_version%3Av2_expandAttachments%3Atrue%2FAUDIO_SGAXDAMDTFU4TEMRTGM3TEMBTGY4DKNBXG43C4MBQOM%3D%3D%3D%3D%3D%3D.WAV%22&X-Amz-Security-Token=IQoJb3JpZ2luX2VjEEoaDmFwLW5vcnRoZWFzdC0yIkcwRQIhALfFm9EJ8HqYp%2Fmt4Jw9QgjcfpVzzLotVNJUpFjXf19RAiB%2BOupZF0YknwzN2sJ%2BbunqaBCaOZYGw43HcFLgt%2BGQkyrMBQhyEAAaDDc2NTYyODk4NTQ3MSIMw91h5w%2BJd2EE3V%2BjKqkF16ze8My3%2F192ix09jyuQk94IEj1dgKkWl1LQOZ87A%2BOrcU%2B5njBR%2Fa6yEAFpcun6BcaPVZb6jvEbBdKwa4X%2FC5YGcjUHC9wypLB9ElSUZpT50as3O9h1P8BvPol3IN%2Faowt%2BQifbMMLNt4zJRxh0vYy0yYt%2BdtHzZqhAXIDnhN7smoo%2FC08RJtTCNDvuHZeHNcPi8ZViDFoNG9MwkvMNy%2FHNURfcyVM5ocygaOr9ONMr14Xf8cCXKoQNG4a6pMdWVWew7fGzUFZpKopHeCCWblgl%2FUBOA09iUxKgYhWaWKumfM6u8BRMmLfD248dD%2FQJxnQECuHT4Y%2Fuxsd0A7NnKHMioyZAydKqiH%2FPjNtb10jfTuTUegbRngW4qKZ7B%2FReYFYDTSQ050kAByCRMbSfPt3iq8LCcbpeU0uOSQ5fqcgdAzCAp0k6vFki54ZOzXKvTUyLmNQbccH6VMO3%2FhGQUMt4KzRo1ZI1AoGcDBa%2FpxmBy42WWIZqiyvU6%2FN22ewda36v1Una%2BWMbFEd2FrKCwhARWGEGlltZmuUgZw%2Bag1iUB1jWQDbir0D8%2FS9j7vEUflzA8tJ84rza%2BOgqhJTuMBJ9q9ZiDXCXPa5UXL%2BMMdG%2BoQnPsTmnmeTwl3xWt8eXeyvvOdclpM1OfwsuSkPEXjxjNlT4vtzfSCi%2FaS0ZwZgHS13lwgXTdWwL7pu6jgqpe8TjgNIbKQxkYykspcOZjLtrmHgMPKZ4wOsPe3f4VYspkLQ2BNOK6SVRBJ9S9%2BBIhxvIoQMhmGlhs%2BVDXU3Scd3TPnEQJ3nGDFQaLiWBQQOA%2ByPqDN0VFJ02m93SUCcz85d2QppA4sgvXfItscwM5BvM7W9gM90zDj77YVZkw4gypDoj7gZWe5pe6%2BQ9S6Qw4Sfj585AVa7uML%2BJnaMGOrEBXxKvVwRvUhaAKYznDttvYY1UCpDlw5Y5JBFnTfDp0PsMYkROTzRZfRlhBdWjCxvbWoS97mQHqqNcrhU0gahnk7A0yXrL%2BEfTEe2hdXFRcoDv%2FIDbftjgOA0xIJthaFeWSHDoioCmTKrKQljlodbvDLUplD01heZaAj9Lbv2LG6U4vXCpdHWB0nFO0xT13Z83Xcv4eg7BbseCaq80W3iPdAWRtC65fKsPvPzITBePkAMt&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230519T101613Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIA3EQYLGB73N4ROEOO%2F20230519%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Signature=5917ca72e7cc511defadd7e244e02820faa10fb014737ad32a232dd6e1f31499";
	try {
		URL url = new URL(sourceURL);
		String fileName = "test_test";
		Path targetPath = new File("c:\\project\\test.wav").toPath();
		Files.copy(url.openStream(), targetPath, StandardCopyOption.REPLACE_EXISTING);
	} catch (Exception e) {
		System.err.println("Exception when downloading the recording to a file." + e.getMessage());
		e.printStackTrace();
	}
	//AecEncryption.decryptFile("c:\\project\\test.zip.enc","c:\\project\\test.zip.decweb");
%>
<script type="text/javascript" src="./js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="./js/jquery-ui-1.10.4.custom.min.js"></script>
<script type="text/javascript" src="./js/jquery.cookie.js"></script>
<script type="text/javascript" src="./js/plugins/metisMenu/metisMenu.js"></script>
<script type="text/javascript" src="./js/bootstrap.js"></script>
<script type="text/javascript" src="./js/site.js"></script>
<script type="text/javascript" src="./js/common.js"></script>
<script>
	function openwindows(myname, w, h, scroll, pos){


		var pop_title = "popupOpener" ;

		if(pos == 'center'){LeftPosition=(screen.width)?(screen.width-w)/2:100;TopPosition=(screen.height)?(screen.height-h-100)/2:100;}
		else if((pos!='center' && pos!='random') || pos == null){LeftPosition = 0;TopPosition = 0;}
		settings = 'width='+w+',height='+h+',top='+TopPosition+',left='+LeftPosition+',scrollbars='+scroll+',location=no,directories=no,status=no,menubar=no,toolbar=no,resizable=no';
		window.open("", pop_title, settings) ;

		var frmData = document.frmData ;
		frmData.target = myname ;
		frmData.action = "https://cs-record-prd.amorepacific.com/app/player_rn.jsp" ;

		frmData.submit() ;


	}
</script>
<input type="button" value="test" onclick="openPopup('https://cs-record-prd.amorepacific.com/app/player_rn.jsp?rec_datm=2023-05-10&conv_id=dc28e817-e1cb-4518-b154-f5b809405857&user_id=test@email&download=1','_player','556','376','yes','center');">
<input type="button" value="test" onclick="openwindows('_player','556','376','yes','center');">

<form name="frmData" id="frmData" method="post">
	<input type="text" name="rec_datm" id="rec_datm" value="2023-05-10" />
	<input type="text" name="conv_id" id="conv_id" value="dc28e817-e1cb-4518-b154-f5b809405857" />
	<input type="text" name="user_id" id="user_id" value="test@email" />
	<input type="text" name="download" id="download" value="1" />
</form>