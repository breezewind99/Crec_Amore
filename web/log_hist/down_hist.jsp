<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
	if(!Site.isPmss(out,"down_hist","")) return;
%>
<jsp:include page="/include/top.jsp" flush="false"/>
<script type="text/javascript">
	//청취/다운 사유입력 유무
	var isExistPlayDownReason = <%=Finals.isExistPlayDownReason%>;

	$(function ()
	{

		//다운로드 사유 유무에 따라 체크 - CJM(20190108)
		if(isExistPlayDownReason)
		{
			// 다운로드사유 조회
			getCommCodeToForm("LD_REASON", "search", "reason_code");
		}

		var colModel = [
			{ title: "순번", width: 60, dataIndx: "idx", sortable: false },
			{ title: "다운일시", width: 130, dataIndx: "down_datm" },
			{ title: "Division", width: 130, dataIndx: "bpart_name" },
			// { title: "중분류", width: 80, dataIndx: "mpart_name" },
			// { title: "소분류", width: 80, dataIndx: "spart_name" },
			{ title: "로그인ID", width: 80, dataIndx: "down_id" },
			{ title: "로그인명", width: 80, dataIndx: "down_name" },
			{ title: "로그인IP", width: 100, dataIndx: "down_ip" },
			{ title: "녹취일시", width: 130, dataIndx: "rec_datm" },
			{ title: "상담사ID", width: 80, dataIndx: "user_id" },
			{ title: "상담사명", width: 80, dataIndx: "user_name" },
			{ title: "녹취파일명", width: 150, dataIndx: "rec_filename" }
		];

		if(isExistPlayDownReason){
			colModel.push( { title: "다운사유", width: 100, dataIndx: "reason_code_desc", sortable: false  } );
			colModel.push( { title: "기타사유", width: 80, dataIndx: "reason_text", sortable: false  } );
		}

		var baseDataModel = "";
		var dataModel = $.extend({}, baseDataModel, {
			//sortIndx: "down_datm",
			sortDir: "down",
		});

		// 페이지 id, 페이징 사용여부, 엑셀다운로드 사용여부, 신규등록 사용여부, 수정 사용여부
		var baseObj = getBaseGridOption("down_hist", "Y", "N", "N", "N");
		var obj = $.extend({}, baseObj, {
			colModel: colModel,
			dataModel: dataModel,
			scrollModel: { autoFit: true },
		});

		$grid = $("#grid").pqGrid(obj);

		$("button[name=btn_search]").click(function()
		{
			Search();
		});

		// 녹취 조회 기능 - CJM(20190107)
		var Search = function()
		{

			if(!baseGridChk)
			{

				if(!fnValidation("<%=page_id%>"))	return;

				baseDataModel = getBaseGridDM("<%=page_id%>");

				dataModel = $.extend({}, baseDataModel, {
					//sortIndx: "rec_datm",
					sortDir: "down",
				});

				obj = $.extend({}, baseObj, {
					colModel: colModel,
					dataModel: dataModel,
					//flexWidth: true,
					//scrollModel: { autoFit: true },
					//scrollModel: { pace:"fast",horizontal:true, lastColumn:"auto",autoFit: false,theme:true},
					//scrollModel: {horizontal:true, autoFit: true},
					//selectionModel: { type: "cell", mode: "block"}
					selectionModel: { type: "none", subtype:"incr", cbHeader:true, cbAll:true}
				});

				$grid = $("#grid").pqGrid(obj);
				$grid.pqGrid("refreshDataAndView");	//타이틀 체크박스가 안나타 나서 추가함 : 조회가 두번 호출 되는게 아닌가? (체크 필요)
			}
		};
	});

</script>

<!--title 영역 -->
<div class="row titleBar border-bottom2">
	<div style="float:left;"><h4>다운로드 이력</h4></div>
	<ol class="breadcrumb" style="float:right;">
		<li><a href="#none"><i class="fa fa-home"></i> 이력</a></li>
		<li class="active"><strong>다운로드 이력</strong>	</li>
	</ol>
</div>
<!--title 영역 끝 -->

<!--wrapper-content영역-->
<div class="wrapper-content">

	<!--ibox 시작-->
	<div class="ibox">
		<form id="search">
			<!--검색조건 영역-->
			<div class="ibox-content-util-buttons">
				<div class="ibox-content contentRadius1 conSize">
					<!--1행 시작-->
					<div class="SearchDiv">
						<div class="labelDiv">
							<label class="simple_tag">다운일자</label>
							<!-- 달력 팝업 위치 시작-->
							<div class="input-group" style="display:inline-block;">
								<input type="text" name="down_date1" class="form-control search_date datepicker" value="<%=DateUtil.getToday("")%>" maxlength="10">
								<div class="input-group-btn">
									<button class="btn btn-default btn-datepicker" type="button"><i class="fa fa-calendar"></i></button>
								</div>
							</div>
							<!-- 달력 팝업 위치 끝-->
							<div class="input-group" style="display:inline-block;"><span class="form-control" style="padding: 3px 0px;border: 0px">~</span></div>
							<!-- 달력 팝업 위치 시작-->
							<div class="input-group" style="display:inline-block;">
								<input type="text" name="down_date2" class="form-control search_date datepicker" value="<%=DateUtil.getToday("")%>" maxlength="10">
								<div class="input-group-btn">
									<button class="btn btn-default btn-datepicker" type="button"><i class="fa fa-calendar"></i></button>
								</div>
							</div>
							<!-- 달력 팝업 위치 끝-->
						</div>
					</div>

					<div class="SearchDiv">
						<div class="labelDiv">
							<label class="simple_tag">로그인ID</label><input type="text" name="login_id" class="form-control search_input" placeholder="">
						</div>
					</div>

					<div class="SearchDiv">
						<div class="labelDiv">
							<label class="simple_tag">로그인명</label><input type="text" name="login_name" class="form-control search_input" placeholder="">
						</div>
					</div>
					<!--1행 끝-->

					<!--2행 시작-->
					<div class="SearchDiv">
						<div class="labelDiv">
							<label class="simple_tag">녹취일자</label>
							<!-- 달력 팝업 위치 시작-->
							<div class="input-group" style="display:inline-block;">
								<input type="text" name="rec_date1" class="form-control search_date datepicker" value="">
								<div class="input-group-btn">
									<button class="btn btn-default btn-datepicker" type="button"><i class="fa fa-calendar"></i></button>
								</div>
							</div>
							<!-- 달력 팝업 위치 끝-->
							<div class="input-group" style="display:inline-block;"><span class="form-control" style="padding: 3px 0px;border: 0px">~</span></div>
							<!-- 달력 팝업 위치 시작-->
							<div class="input-group" style="display:inline-block;">
								<input type="text" name="rec_date2" class="form-control search_date datepicker" value="">
								<div class="input-group-btn">
									<button class="btn btn-default btn-datepicker" type="button"><i class="fa fa-calendar"></i></button>
								</div>
							</div>
							<!-- 달력 팝업 위치 끝-->
						</div>
					</div>

					<div class="SearchDiv">
						<div class="labelDiv">
							<label class="simple_tag">상담사ID</label><input type="text" name="user_id" class="form-control search_input" placeholder="">
						</div>
					</div>

					<div class="SearchDiv">
						<div class="labelDiv">
							<label class="simple_tag">상담사명</label><input type="text" name="user_name" class="form-control search_input" placeholder="">
						</div>
					</div>
					<!--1행 끝-->

					<!--3행 시작-->
					<%
						//다운로드 사유 유무에 따라 체크 - CJM(20190108)
						if(Finals.isExistPlayDownReason)
						{
					%>

					<div class="SearchDiv">
						<div class="labelDiv">
							<label class="simple_tag">다운사유</label>
							<select class="form-control search_combo_range_2" name="reason_code">
							</select>
						</div>
					</div>
					<%
						}

						//외부에 다운로드시 다운로드 이력 요청시 필요 - CJM(20190108)
						if(Finals.isTa)
						{
					%>
					<div id="logDiv2">
						<div class="labelDiv">
							<label class="simple_tag">TA유무</label>
							<select class="form-control rec_form5" name="down_src">
								<option value="Y" selected="selected">포함</option>
								<option value="N">미포함</option>
							</select>
						</div>
					</div>
					<%
						}
					%>
				</div>
				<!--검색조건 영역 끝-->

				<!--유틸리티 버튼 영역-->
				<div class="contentRadius2 conSize">
					<!--ibox 접히기, 설정버튼 영역 (사용안함)-->
					<div class="ibox-tools blank">
						<!--<a class="collapse-link">
							<button type="button" class="btn btn-default"><i class="fa fa-chevron-up"></i></button>
						</a>-->
					</div>
					<!--ibox 접히기, 설정버튼 영역 끝-->
					<div style="float:right">
						<button type="button" name="btn_search" class="btn btn-primary btn-sm"><i class="fa fa-search"></i> 조회</button>
						<button type="button" name="btn_cancel" class="btn btn-default btn-sm"><i class="fa fa-times"></i> 취소</button>
					</div>
				</div>
				<!--유틸리티 버튼 영역 끝-->
			</div>

			<!--ibox 접히기, 설정버튼 영역2-->
			<div class="ibox-tools2">
				<a class="collapse-link2">
					<div class="ibox-tools2-btn"><i class="fa fa-caret-up"></i></div>
				</a>
			</div>
			<!--ibox 접히기, 설정버튼 영역2 끝-->
		</form>
	</div>
	<!--ibox 끝-->

	<!--Data table 영역-->
	<div class="contentArea">
		<!--grid 영역-->
		<div id="grid"></div>
		<!--grid 영역 끝-->
	</div>
	<!--Data table 영역 끝-->
</div>
<!--wrapper-content영역 끝-->

<jsp:include page="/include/bottom.jsp"/>
