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
		StringBuffer jb = new StringBuffer();
		String line = null;

		try {
			BufferedReader reader = request.getReader();
			while ((line = reader.readLine()) != null) {
				jb.append(line);
			}
		} catch (Exception e) { /* error handling */ }

		if(!CommonUtil.hasText(jb.toString()))
		{
			out.print(CommonUtil.getPopupMsg(CommonUtil.getErrorMsg("NO_PARAM"),"","close"));
			return;
		}

		JSONObject jsonObject = new JSONObject(jb.toString());
		JSONArray detailArray = jsonObject.getJSONArray("detail");

		for (Object obj : detailArray) {
			JSONObject detailObject = (JSONObject) obj;
			String rec_datm = detailObject.getString("rec_datm");
			String conv_id = detailObject.getString("conv_id");
			String user_id = detailObject.getString("user_id");
			Map<String, Object> argMap = new HashMap<String, Object>();
			argMap.put("rec_keycode",conv_id);
			argMap.put("rec_date",rec_datm);
//			argMap.put("user_id",user_id);
			// 값 출력
			int ins_cnt = db.insert("rec_search_download.insertDownload", argMap);
			if(ins_cnt < 1)
			{
				Site.writeJsonResult(out, false, "등록에 실패했습니다.");
				return;
			}
//			out.println("rec_datm: " + rec_datm);
//			out.println("conv_id: " + conv_id);
//			out.println("user_id: " + user_id);
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