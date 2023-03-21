<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
	// cross domain 설정
	//response.addHeader("Access-Control-Allow-Origin", "*");
	//response.setHeader("Access-Control-Allow-Headers", "origin, x-requested-with, content-type, accept");

	//if(!Site.isPmss(out,"","json")) return;

	Db db = null;

	try 
	{
		db = new Db(true);
		
		// get parameter
		String perm_check = CommonUtil.getParameter("perm_check");
		String business_code = CommonUtil.getParameter("business_code", _BUSINESS_CODE);
		String work_bpart_code = CommonUtil.getParameter("work_bpart_code");
		String work_mpart_code = CommonUtil.getParameter("work_mpart_code");
		String work_spart_code = CommonUtil.getParameter("work_spart_code");
		String work_part_depth = CommonUtil.getParameter("work_part_depth");
		
		if(!"0".equals(perm_check))		if(!Site.isPmss(out,"","json")) return;
		
		// 파라미터 체크
		if(!CommonUtil.hasText(business_code) || !CommonUtil.hasText(work_part_depth))
		{
			Site.writeJsonResult(out, false, CommonUtil.getErrorMsg("NO_PARAM"));
			return;
		}

		JSONObject json = new JSONObject();

		Map<String,Object> argMap = new HashMap();
		argMap.put("business_code",business_code);
		argMap.put("work_bpart_code",work_bpart_code);
		argMap.put("work_mpart_code",work_mpart_code);
		argMap.put("work_part_depth",work_part_depth);
		argMap.put("use_yn","1");

		List<Map<String,Object>> list = db.selectList("work_group.selectList", argMap);

		json.put("data", list);
		out.print(json.toJSONString());
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