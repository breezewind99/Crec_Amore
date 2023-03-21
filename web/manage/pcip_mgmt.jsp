<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
	if(!Site.isPmss(out,"pcip_mgmt","")) return;

	Db db = null;

	try
	{
		db = new Db(true);
%>
<jsp:include page="../include/top.jsp" flush="false"/>
<script type="text/javascript">
	$(function ()
	{
		var colModel = [
			{ title: "사용자 PC IP", width: 100, dataIndx: "pc_ip",
				validations: [
					{ type: "minLen", value: "1", msg: "필수입력 사항입니다." },
				],
			},
			{ title: "기존 사용자 PC IP", dataIndx: "ori_pc_ip", hidden: true },
			{ title: "접근 허용 가능여부", width: 100, dataIndx: "use_yn",
				editor: {
					type: 'select',
					options: [{'y':'접근 허용'}, {'n':'접근 불가'}]
				},
				render: function(ui) {

					var options = ui.column.editor.options,
							cellData = ui.cellData;
					for(var i = 0; i < options.length; i++)
					{
						var option = options[i];
						if(option[cellData])
						{
							return option[cellData];
						}
					}

				},
			},
			{ title: "내선번호", width: 100, dataIndx: "local_no" },
			{ title: "비고", width: 300, dataIndx: "bigo" },
			{ title: "삭제", width: 40, editable: false, sortable: false, render: function (ui) {
					return "<img src='../img/icon/ico_delete.png' class='btn_delete'/>";
				}
			}
		];

		var baseDataModel = getBaseGridDM("<%=page_id%>");
		var dataModel = $.extend({}, baseDataModel, {
			sorting:"local",
			//sortIndx: "system_code",
			//sortDir: "up",
			recIndx: "pc_ip"
		});

		// 페이지 id, 페이징 사용여부, 엑셀다운로드 사용여부, 신규등록 사용여부, 수정 사용여부
		var baseObj = getBaseGridOption("pcip_mgmt", "N", "N", "Y", "Y");
		var obj = $.extend({}, baseObj, {
			colModel: colModel,
			dataModel: dataModel,
			scrollModel: { autoFit: true },
			numberCell:{resizable:true, title:"#"},
		});

		$grid = $("#grid").pqGrid(obj);

		// PC-IP 등록 저장
		$("#regi button[name=modal_regi]").click(function() {
			if(!$("input[name=pc_ip]").val().trim())
			{
				alert("PC IP를 입력해 주십시오.");
				$("input[name=pc_ip]").focus();
				return false;
			}

			$.ajax({
				type: "POST",
				url: "remote_pcip_mgmt_proc.jsp",
				async: false,
				data: "step=insert&"+$("#regi").serialize(),
				dataType: "json",
				success:function(dataJSON){
					if(dataJSON.code == "OK")
					{
						alert("정상적으로 등록되었습니다.");
						$("#modalRegiForm").modal("hide");
						$grid.pqGrid("refreshDataAndView");
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

<!--title 영역 -->
<div class="row titleBar border-bottom2">
	<div style="float:left;"><h4>사용자PC IP 관리</h4></div>
	<ol class="breadcrumb" style="float:right;">
		<li><a href="#none"><i class="fa fa-home"></i> 관리</a></li>
		<li class="active"><strong>사용자PC IP 관리</strong></li>
	</ol>
</div>
<!--title 영역 끝 -->

<!--wrapper-content영역-->
<div class="wrapper-content">
	<!--ibox 시작-->
	<div class="ibox">
		<form id="search">
			<!--검색조건 영역-->
			<div class="ibox-content contentRadius1 conSize">
				<div class="evaDiv2">
					<div id="labelDiv">
						<label class="simple_tag">사용자PC IP</label><input type="text" name="pcip" class="form-control eva_form2" id="" placeholder="">
					</div>
				</div>
				<div id="deptDiv1">
					<div id="label_div">
						<label class="simple_tag">가능여부</label>
						<select class="form-control dept_form2" name="use_yn">
							<option value="">전체</option>
							<option value="y">접근 허용</option>
							<option value="n">접근 불가</option>
						</select>
					</div>
				</div>
				<div class="evaDiv3">
					<div id="label_Div">
						<label class="simple_tag">내선번호</label><input type="text" name="local_no" class="form-control eva_form3" id="" placeholder="">
					</div>
				</div>
				<div class="evaDiv3">
					<div id="label_Div">
						<label class="simple_tag">비고</label><input type="text" name="bigo" class="form-control eva_form3" id="" placeholder="">
					</div>
				</div>
			</div>
			<!--검색조건 영역 끝-->

			<!--유틸리티 버튼 영역-->
			<div class="contentRadius2 conSize">
				<!--ibox 접히기, 설정버튼 영역-->
				<div class="ibox-tools">
					<a class="collapse-link">
						<button type="button" class="btn btn-default"><i class="fa fa-chevron-up"></i></button>
					</a>
				</div>
				<!--ibox 접히기, 설정버튼 영역 끝-->
				<div style="float:right">
					<button type="button" name="btn_search" class="btn btn-primary btn-sm"><i class="fa fa-search"></i> 조회</button>
					<button type="button" name="btn_cancel" class="btn btn-default btn-sm"><i class="fa fa-times"></i> 취소</button>
				</div>
			</div>
			<!--유틸리티 버튼 영역 끝-->
		</form>
	</div>
	<!--ibox 끝-->
	<!--Data table 영역-->
	<div class="contentArea" style="padding-top: 10px;">
		<!--grid 영역-->
		<div id="grid"></div>
		<!--grid 영역 끝-->
		<!--팝업창 띠우기-->
		<div class="modal inmodal" id="modalRegiForm" tabindex="-1" role="dialog"  aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content animated fadeIn">
					<form id="regi">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
							<h4 class="modal-title">사용자PC IP 등록</h4>
						</div>
						<div class="modal-body">
							<!--시스템 영역 table-->
							<table class="table top-line1 table-bordered2">
								<thead>
								<tr>
									<td style="width:40%;" class="table-td">PC-IP<span class="required">*</span></td>
									<td style="width:60%;">
										<input type="text" name="pc_ip" class="form-control" id="" placeholder="">
									</td>
								</tr>
								</thead>
								<tr>
									<td class="table-td">허용구분 <span class="required">*</span></td>
									<td>
										<select class="form-control" name="use_yn">
											<option value="y">접근 허용</option>
											<option value="n">접근 불가</option>
										</select>
									</td>
								</tr>
								<tr>
									<td class="table-td">내선번호</td>
									<td><input type="text" class="form-control" name="local_no" placeholder=""></td>
								</tr>
								<tr>
									<td class="table-td">비고</td>
									<td><input type="text" class="form-control" name="bigo" placeholder=""></td>
								</tr>
							</table>
							<!--메뉴 코드 영역 table 끝-->
						</div>
						<div class="modal-footer">
							<button type="button" name="modal_regi" class="btn btn-primary btn-sm"><i class="fa fa-pencil"></i> 등록</button>
							<button type="button" name="modal_cancel" class="btn btn-default btn-sm" data-dismiss="modal"><i class="fa fa-times"></i> 취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<!--팝업창 띠우기 끝-->
	</div>
	<!--Data table 영역 끝-->
</div>
<!--wrapper-content영역 끝-->

<%@ include file="../include/bottom.jsp" %>
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
