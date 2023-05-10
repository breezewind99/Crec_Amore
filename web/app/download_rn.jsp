<%@ page import="java.io.BufferedReader" %>
<%@ page import="org.json.JSONObject" %>
<%@ page import="org.json.JSONArray" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
	Db db = null;
	try
	{
		db = new Db(true);


		String download_id = CommonUtil.getParameter("download_id");
		String rec_seq = CommonUtil.getParameter("rec_seq");

		if(!CommonUtil.hasText(rec_seq) || !CommonUtil.hasText(download_id))
		{
			Site.writeJsonResult(out, false, "등록에 실패했습니다.");
			return;
		}

		Map<String, Object> argMap = new HashMap<String, Object>();
		argMap.put("rec_seq",rec_seq);
		argMap.put("download_id",download_id);
		// 값 출력
		int ins_cnt = db.insert("rec_search_download.insertDownload", argMap);
		if(ins_cnt < 1)
		{
			Site.writeJsonResult(out, false, "등록에 실패했습니다.");
			return;
		}

		Site.writeJsonResult(out, true, "등록에 성공하였습니다.");

	} catch(NullPointerException e) {
		//out.print(CommonUtil.getPopupMsg("등록에 실패했습니다.","",""));
		Site.writeJsonResult(out, false, "등록에 실패했습니다.");
		logger.error(e.getMessage());
	} catch(Exception e) {
		//out.print(CommonUtil.getPopupMsg("등록에 실패했습니다.","",""));
		Site.writeJsonResult(out, false, "등록에 실패했습니다.");
		logger.error(e.getMessage());
	} finally {
		if(db != null)	db.close();
	}
%>