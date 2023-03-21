<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
	if(!Site.isPmss(out,"pcip_mgmt","json")) return;

	Db db = null;

	try
	{
		db = new Db(true);

		// get parameter
		String step = CommonUtil.getParameter("step");

		Map<String, Object> argMap = new HashMap<String, Object>();

		if("insert".equals(step))
		{
			// get parameter
			String pc_ip = CommonUtil.getParameter("pc_ip");
			String use_yn = CommonUtil.getParameter("use_yn");
			String local_no = CommonUtil.getParameter("local_no");
			String bigo = CommonUtil.getParameter("bigo");

			argMap.put("pc_ip",pc_ip);
			argMap.put("use_yn",use_yn);
			argMap.put("local_no",local_no);
			argMap.put("bigo",bigo);

			// duplicate check
			argMap.put("pc_ip",pc_ip);

			String result_code = db.selectOne("pcip.selectDuplicateCheck", argMap);
			if(!"OK".equals(result_code))
			{
				Site.writeJsonResult(out, false, "중복된 IP가 존재합니다");
				return;
			}

			int ins_cnt = db.insert("pcip.insertPcip", argMap);
			if(ins_cnt < 1)
			{
				Site.writeJsonResult(out, false, "등록에 실패했습니다.");
				return;
			}
		}
		else if("update".equals(step))
		{
			// get parameter
			String data_list = CommonUtil.getParameter("data_list");

			// 파라미터 체크
			if(!CommonUtil.hasText(data_list))
			{
				Site.writeJsonResult(out, false, CommonUtil.getErrorMsg("NO_PARAM"));
				return;
			}

			// &quot; -> " 로 replace
			data_list = "{\"data_list\":" + CommonUtil.toTextJSON(data_list) + "}";

			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObj = (JSONObject) jsonParser.parse(data_list);

			JSONArray jsonArr = (JSONArray) jsonObj.get("data_list");
			Iterator<Object> iterator = jsonArr.iterator();

			int upd_cnt = 0;
			String parentCode = null;
			while(iterator.hasNext())
			{
				JSONObject jsonItem = (JSONObject) iterator.next();

				argMap.clear();
				argMap.put("pc_ip",jsonItem.get("pc_ip"));
				argMap.put("ori_pc_ip",jsonItem.get("ori_pc_ip"));
				argMap.put("use_yn",jsonItem.get("use_yn"));
				argMap.put("local_no",jsonItem.get("local_no"));
				argMap.put("bigo",jsonItem.get("bigo"));

				upd_cnt += db.update("pcip.updatePcip", argMap);
			}

			if(upd_cnt < 1)
			{
				Site.writeJsonResult(out, false, "업데이트에 실패했습니다.");
				return;
			}
		}
		else if("delete".equals(step))
		{
			// get parameter
			String pc_ip = CommonUtil.getParameter("row_id");

			// 파라미터 체크
			if(!CommonUtil.hasText(pc_ip))
			{
				Site.writeJsonResult(out, false, CommonUtil.getErrorMsg("NO_PARAM"));
				return;
			}

			int del_cnt = db.delete("pcip.deletePcip", pc_ip);
			if(del_cnt < 1)
			{
				Site.writeJsonResult(out, false, "삭제에 실패했습니다.");
				return;
			}
		}
		else
		{
			Site.writeJsonResult(out, false, CommonUtil.getErrorMsg("NO_PARAM"));
			return;
		}

		Site.writeJsonResult(out,true);
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