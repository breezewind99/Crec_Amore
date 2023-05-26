<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
	if(!Site.isPmss(out,"rec_search","close")) return;

	try
	{
		// get parameter
		String info = CommonUtil.getParameter("info");

		// 파라미터 체크
		if(!CommonUtil.hasText(info))
		{
			out.print(CommonUtil.getPopupMsg(CommonUtil.getErrorMsg("NO_PARAM"),"","close"));
			return;
		}
%>
<jsp:include page="/include/popup.jsp" flush="false"/>
<title>다운로드 사유 등록</title>
<style>
	.spinner {
		width: 100%;
		height: 100%;
		display: flex;
		justify-content: center;
		align-items: center;
		z-index: 999;
	}
</style>
<script type="text/javascript">
	$(function(){
		// 등록 버튼 클릭
		$("button[name=modal_regi]").click(function(){
			if(reasonFormChk())
			{
				$("#modalReasonForm").modal("toggle");
				var fileUrl = "download2.jsp"
				var params = {
					info:$('#reason_regi input[name="info"]').val(),
					reason_code:$("#modalReasonForm select[name=reason_code]").val(),
					reason_text:$("#modalReasonForm input[name=reason_text]").val()};
				var param = "info=" + encodeURIComponent($('#reason_regi input[name="info"]').val());
				param += "&reason_code="+$("#modalReasonForm select[name=reason_code]").val();
				param += "&reason_text="+$("#modalReasonForm input[name=reason_text]").val();
				downloadFile(fileUrl, param);

			}
		});
	});

	function downloadFile(url, params) {
		fetch(url, {
			method: 'POST',
			body: params,
			headers: {
				'Content-Type':'application/x-www-form-urlencoded'
			}
		})
				.then(response => {
					if (response.ok) {
						var fileName = getFileNameFromResponse(response);
						return response.blob();
					} else {
						throw new Error('Failed to download file');
					}
				})
				.then(blob => {
					if (blob.type=="text/html") {

						var reader = new FileReader();
						reader.onloadend = function() {
							var text = reader.result;
							// 텍스트 값을 사용하는 로직을 이곳에 작성합니다.
							console.log(text);
							alert('다운로드중 오류가 발생되었습니다.');
						};
						reader.readAsText(blob);


					} else {
						var link = document.createElement('a');
						link.href = window.URL.createObjectURL(blob);
						link.download = "MultiFile";
						link.click();
						alert('다운로드가 완료되었습니다.');
					}

					$("#modalReasonForm").modal("toggle");
				})
				.catch(error => {
					console.error(error);
					$("#modalReasonForm").modal("toggle");
				});
	}

	function getFileNameFromResponse(response) {
		var disposition = response.headers.get('Content-Disposition');
		if (disposition && disposition.indexOf('attachment') !== -1) {
			var filenameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
			var matches = filenameRegex.exec(disposition);
			if (matches != null && matches[1]) {
				return matches[1].replace(/['"]/g, '');
			}
		}
		return 'file';
	}
</script>
</head>

<body class="white-bg">
<div id="container" style="width: 556px">
	<div class="memo-body">
		<form id="reason_regi" method="post">
			<input type="hidden" name="info" value="<%=info %>"/>
			<input type="hidden" name="reason_code" value="">
			<input type="hidden" name="reason_text" value="">
			<jsp:include page="/include/reason_inc.jsp" flush="false"/>
		</form>
	</div>
</div>
<iframe name="hiddenFrame" id="hiddenFrame" style="display: none;"></iframe>
</body>
<div style="width: 100%;height: 100%;text-align: center">
	<div class="loadingio-spinner-pulse-opnyrwgbtjd"><div class="ldio-84mxqmdh29p">
		<div></div><div></div><div></div>
	</div></div>
</div>
<style type="text/css">
	@keyframes ldio-84mxqmdh29p-1 {
		0% { top: 35.46px; height: 126.08px }
		50% { top: 59.1px; height: 78.8px }
		100% { top: 59.1px; height: 78.8px }
	}
	@keyframes ldio-84mxqmdh29p-2 {
		0% { top: 41.36999999999999px; height: 114.26000000000002px }
		50% { top: 59.1px; height: 78.8px }
		100% { top: 59.1px; height: 78.8px }
	}
	@keyframes ldio-84mxqmdh29p-3 {
		0% { top: 47.28px; height: 102.44px }
		50% { top: 59.1px; height: 78.8px }
		100% { top: 59.1px; height: 78.8px }
	}
	.ldio-84mxqmdh29p div { position: absolute; width: 19.7px }.ldio-84mxqmdh29p div:nth-child(1) {
																   left: 39.4px;
																   background: #93dbe9;
																   animation: ldio-84mxqmdh29p-1 1s cubic-bezier(0,0.5,0.5,1) infinite;
																   animation-delay: -0.2s
															   }
	.ldio-84mxqmdh29p div:nth-child(2) {
		left: 88.65px;
		background: #689cc5;
		animation: ldio-84mxqmdh29p-2 1s cubic-bezier(0,0.5,0.5,1) infinite;
		animation-delay: -0.1s
	}
	.ldio-84mxqmdh29p div:nth-child(3) {
		left: 137.9px;
		background: #5e6fa3;
		animation: ldio-84mxqmdh29p-3 1s cubic-bezier(0,0.5,0.5,1) infinite;
		animation-delay: undefineds
	}

	.loadingio-spinner-pulse-opnyrwgbtjd {
		width: 197px;
		height: 197px;
		display: inline-block;
		overflow: hidden;
		background: #ffffff;
	}
	.ldio-84mxqmdh29p {
		width: 100%;
		height: 100%;
		position: relative;
		transform: translateZ(0) scale(1);
		backface-visibility: hidden;
		transform-origin: 0 0; /* see note above */
	}
	.ldio-84mxqmdh29p div { box-sizing: content-box; }
	/* generated by https://loading.io/ */
</style>
</html>
<%
	} catch(NullPointerException e) {
		logger.error(e.getMessage());
	} catch(Exception e) {
		logger.error(e.getMessage());
	} finally {

	}
%>