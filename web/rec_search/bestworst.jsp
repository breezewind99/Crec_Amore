<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%@ page import="com.cnet.CnetCrypto.CNCrypto"%>
<%
	if(!Site.isPmss(out,"rec_search","close")) return;

	Db db = null;

	try 
	{
		db = new Db(true);

		// get parameter
		String rec_datm = CommonUtil.ifNull(request.getParameter("rec_datm"));
		String rec_filename = CommonUtil.ifNull(request.getParameter("rec_filename"));
		
		// 파라미터 체크
		if(!CommonUtil.hasText(rec_filename) || !CommonUtil.hasText(rec_datm)) 
		{
			out.print(CommonUtil.getPopupMsg(CommonUtil.getErrorMsg("NO_PARAM"),"","close"));
			return;
		}


%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Best/Worst</title>
<link href="../css/bootstrap.css" rel="stylesheet">
<link href="../css/font-awesome.css" rel="stylesheet">
<link href="../css/animate.css" rel="stylesheet">
<link href="../css/style.css" rel="stylesheet">

<script type="text/javascript" src="../js/site.js"></script>
<script type="text/javascript" src="../js/jquery-1.11.0.min.js"></script>
<script type="text/javascript">
	$(function () {
		// 메모 저장
		$("#regi button[name=btn_regi]").click(function() {
	
			$.ajax({
				type: "POST",
				url: "remote_bestworst_proc.jsp", 
				async: false,
				data: "step=insert&"+$("#regi").serialize(),
				dataType: "json",
				success:function(dataJSON){
					if(dataJSON.code == "OK") 
					{
						alert("정상적으로 등록되었습니다.");
						self.close();
					} 
					else 
					{
						alert(dataJSON.msg);
						return false;
					}
				},
				error:function(req,status,err){
					alertJsonErr(req,status,err);
					return false;
				}
			});
		});
	});

</script>
</head>

<body class="white-bg">
	<div class="memo-body">
		<!--메모 등록 영역-->
		<div class="memo-post tableSize2">
			<form id="regi">
				<input type="hidden" name="rec_datm" value="<%=rec_datm%>"/>
				<input type="hidden" name="rec_filename" value="<%=rec_filename%>"/>
					<td style="width:12%;" class="table-td t-left">베스트/워스트</td>
						<td class="t-left">
						<select class="form-control eva_form2" name="eval_rate_code">
						<option value="1">베스트</option>
						<option value="2">워스트</option>
						</select>
						<span id="txt_eval_rate_code" class="hidden"></span>
					</td>
				<span class="colRight"><button type="button" name="btn_regi" class="btn btn-done btn-sm" >저장</button></span>
				
			</form>
		</div>
		<!--메모 등록 영역 끝-->

		<!--메모 리스트 영역-->
		<div class="memo-discussion tableSize3">

		</div>
		<!--메모 리스트 영역 끝-->

	</div>
</body>
</html>
<%
	} 
	catch(Exception e) 
	{
		logger.error(e.getMessage());
	} 
	finally 
	{
		if(db != null)	db.close();
	}
%>