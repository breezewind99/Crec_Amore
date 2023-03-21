<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
	if(!Site.isPmss(out,"pcip_mgmt","json")) return;

	Db db = null;

	try
	{
		db = new Db(true);


		String pc_ip = CommonUtil.getParameter("pcip", "");
		String use_yn = CommonUtil.getParameter("use_yn", "");
		String local_no = CommonUtil.getParameter("local_no", "");
		String bigo = CommonUtil.getParameter("bigo", "");


		JSONObject json = new JSONObject();

		Map<String, Object> argMap = new HashMap<String, Object>();

		argMap.put("pc_ip", pc_ip);
		argMap.put("use_yn", use_yn);
		argMap.put("local_no", local_no);
		argMap.put("bigo", bigo);

		List<Map<String, Object>> list = db.selectList("pcip.selectList", argMap);

		json.put("totalRecords", list.size());

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