<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
	if(!Site.isPmss(out,"rec_search","json")) return;

	Db db = null;

	try 
	{
		db = new Db();

		// get parameter
		String step = CommonUtil.getParameter("step");

		Map<String, Object> argMap = new HashMap<String, Object>();

		// 사용권한 체크
		argMap.put("conf_field","memo");
		argMap.put("user_id",_LOGIN_ID);
		argMap.put("user_level",_LOGIN_LEVEL);

		if("insert".equals(step)) 
		{
			// get parameter
			String rec_datm = CommonUtil.getParameter("rec_datm");
			String rec_date = rec_datm.substring(0,8);
			String rec_filename = CommonUtil.getParameter("rec_filename");
			String eval_rate_code = CommonUtil.getParameter("eval_rate_code");
			String client_ip = request.getRemoteAddr();

			// 파라미터 체크
			if(!CommonUtil.hasText(rec_datm) || !CommonUtil.hasText(rec_filename)) 
			{
				Site.writeJsonResult(out, false, CommonUtil.getErrorMsg("NO_PARAM"));
				return;
			}


			//베스트/워스트 추가기능(20211021)
			argMap.clear();
			argMap.put("rec_date", rec_date);
			argMap.put("eval_rate_code",eval_rate_code);
			argMap.put("rec_filename",rec_filename);
			int upd_cnt_record = db.update("rec_memo.updateBestWorst", argMap);
		} 
		
		else 
		{
			Site.writeJsonResult(out, false, CommonUtil.getErrorMsg("NO_PARAM"));
			return;
		}

		// commit
		db.commit();

		Site.writeJsonResult(out,true);
	} 
	catch(Exception e) 
	{
		// rollback
		if(db != null)	db.rollback();

		logger.error(e.getMessage());
	} 
	finally 
	{
		if(db != null)	db.close();
	}
%>