<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%@ include file="/common/function.jsp" %>
<%@ page import="java.net.URL"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.zip.ZipOutputStream" %>
<%@ page import="java.util.zip.ZipEntry" %>
<%
	// 메뉴 접근권한 체크
	if(!Site.isPmss(out,"rec_search","")) return;

	Db db = null;

	HttpURLConnection httpconn = null;
	InputStream in = null;
	ByteArrayOutputStream baos = null;
	BufferedReader rd = null;
	BufferedOutputStream os = null;
	ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
	ZipOutputStream zipOutputStream = new ZipOutputStream(byteArrayOutputStream);

	try {
		// DB Connection
		db = new Db(true);

		// get parameter
		String info = CommonUtil.getParameter("info");
		String reason_code = CommonUtil.getParameter("reason_code");
		String reason_text = CommonUtil.getParameter("reason_text");

		// 파라미터 체크
		if(!CommonUtil.hasText(info) || (Finals.isExistPlayDownReason && !CommonUtil.hasText(reason_code)) )
		{
			out.print(CommonUtil.getPopupMsg(CommonUtil.getErrorMsg("NO_PARAM"),"",""));
			return;
		}

		// 파리미터 복호화
		CNCrypto aes = new CNCrypto("AES",CommonUtil.getEncKey());
		info = aes.Decrypt(info);

		String t_arr[] = info.split("\\,");
		//logger.error("t_arr : " + t_arr.length);

		String rec_datm = "";
		String local_no = "";
		String rec_filename = "";
		String contentType = "";
		int contentLength;

		Map<String, Object> argMap = new HashMap<String, Object>();

		for( int i = 0; i < t_arr.length; i ++)
		{
			//logger.error("2 : " + t_arr.length);
			if(i < t_arr.length - 1)
			{
				//logger.info("t_arr1 : " + t_arr[i]);

				String tmp_arr[] = t_arr[i].split("\\|");

				//logger.info("tmp_arr1 size : " + tmp_arr.length);

				if(i == 0)
				{
					rec_datm = tmp_arr[1];
					local_no = tmp_arr[2];
					rec_filename = tmp_arr[3];

					// 파라미터 체크
					if(!CommonUtil.hasText(rec_datm) || !CommonUtil.hasText(local_no) || !CommonUtil.hasText(rec_filename))
					{
						out.print(CommonUtil.getPopupMsg(CommonUtil.getErrorMsg("NO_PARAM"),"",""));
						return;
					}

					// 요청일시와 현재 시간의 차이를 구함
					Date conn_datm = DateUtil.getDate(DateUtil.getDateFormatByIntVal(tmp_arr[0], "yyyy-MM-dd HH:mm:ss"), "yyyy-MM-dd HH:mm:ss");
					Date now_datm = DateUtil.getDate(DateUtil.getToday("yyyy-MM-dd HH:mm:ss"), "yyyy-MM-dd HH:mm:ss");

					int diff = DateUtil.getDateDiff(conn_datm, now_datm, "M");

					// 5분 이상 차이가 날 경우 로그인 실패 처리
					if(diff > 5)
					{
						out.print(CommonUtil.getPopupMsg("요청가능 시간이 만료되었습니다.","",""));
						return;
					}
				}
				else
				{
					rec_datm = tmp_arr[0];
					local_no = tmp_arr[1];
					rec_filename = tmp_arr[2];

					// 파라미터 체크
					if(!CommonUtil.hasText(rec_datm) || !CommonUtil.hasText(local_no) || !CommonUtil.hasText(rec_filename))
					{
						out.print(CommonUtil.getPopupMsg(CommonUtil.getErrorMsg("NO_PARAM"),"",""));
						return;
					}
				}

				// 사용권한 체크
				argMap.put("conf_field", "download");
				argMap.put("user_id", _LOGIN_ID);
				argMap.put("user_level", _LOGIN_LEVEL);

				if(!"1".equals(db.selectOne("search_config.selectResultPerm", argMap)))
				{
					out.print(CommonUtil.getPopupMsg(CommonUtil.getErrorMsg("ERR_PERM"),"",""));
					return;
				}

				// yyyyMMddHHmmssSSS -> yyyy-MM-dd HH:mm:ss.SSS
				//rec_datm = DateUtil.getDateFormatByIntVal(rec_datm, "yyyy-MM-dd HH:mm:ss.SSS");
				rec_datm = DateUtil.getDateFormatByIntVal(rec_datm, "yyyy-MM-dd HH:mm:ss");

				argMap.clear();
				argMap.put("rec_datm", rec_datm);
				//argMap.put("local_no", local_no);
				argMap.put("rec_filename", rec_filename);

				// 녹취이력 조회
				Map<String, Object> data  = db.selectOne("rec_search.selectItem", argMap);
				if(data == null)
				{
					out.print(CommonUtil.getPopupMsg(CommonUtil.getErrorMsg("NO_DATA"),"",""));
					return;
				}

				// 녹취파일 경로 조회
				String file_url = getListenURL2("DOWN", data, logger, "ADD");
				// 녹취파일 HTTP 연결
				// 운영계
				//file_url = file_url.replace("https://cs-record-prd.amorepacific.com","http://localhost");

				// 개발계
				file_url = file_url.replace("https://cs-record-dev.amorepacific.com","http://localhost");
				if(file_url==null || "".equals(file_url))
				{
					out.print(CommonUtil.getPopupMsg("녹취파일 경로를 가져 오는데 실패했습니다.","",""));
					return;
				}

				if("ERR".equals(file_url.substring(0,3)))
				{
					out.print(CommonUtil.getPopupMsg(file_url.substring(3),"",""));
					return;
				}
				argMap.put("login_id",_LOGIN_ID);
				argMap.put("login_name",_LOGIN_NAME);
				argMap.put("down_ip",request.getRemoteAddr());
				argMap.put("rec_keycode",data.get("rec_keycode").toString());
				//oracle 사용자 정보 없을 경우 null 체크 - CJM(20190624)
				argMap.put("user_id",CommonUtil.ifNull(data.get("user_id")+""));
				argMap.put("user_name",CommonUtil.ifNull(data.get("user_name")+""));

				argMap.put("reason_code",reason_code);
				argMap.put("reason_text",reason_text);
				argMap.put("down_src","");

				int ins_cnt = db.insert("hist_down.insertDownHist", argMap);
				// http 통신 관련 변수 선언
				URL url = null;

				// 루키스, 나이스 데이터인 경우 파형 확장자를 가진 URL로 2번 http 통신이 필요함
				String system_code = data.get("system_code").toString();

				// 녹취파일 HTTP 연결
				url = new URL(file_url);

				httpconn = (HttpURLConnection) url.openConnection();
				httpconn.setConnectTimeout(10000);
				//timeout으로 인한 주석 처리
				//httpconn.setReadTimeout(60000);

				if(httpconn.getResponseCode()!=HttpURLConnection.HTTP_OK)
				{
					out.print(CommonUtil.getPopupMsg("녹취파일이 존재하지 않습니다.","",""));
					return;
				}

				in = httpconn.getInputStream();
				String temp_entry_name = Integer.toString(i + 1);
				ZipEntry zipEntry = new ZipEntry(temp_entry_name);

				zipOutputStream.putNextEntry(zipEntry);
				byte[] Output = new byte[1024];
				int length;
				while ((length = in.read(Output)) > 0) {
					zipOutputStream.write(Output, 0, length);
				}
				in.close();
				zipOutputStream.closeEntry();
			}
			else
			{
				//logger.info("t_arr2 : " + t_arr[i]);
				String tmp_arr[] = t_arr[i].split("\\|");

				//logger.info("tmp_arr2 size : " + tmp_arr.length);

				if(i == 0)
				{
					rec_datm = tmp_arr[1];
					local_no = tmp_arr[2];
					rec_filename = tmp_arr[3];

					// 파라미터 체크
					if(!CommonUtil.hasText(rec_datm) || !CommonUtil.hasText(local_no) || !CommonUtil.hasText(rec_filename))
					{
						out.print(CommonUtil.getPopupMsg(CommonUtil.getErrorMsg("NO_PARAM"),"",""));
						return;
					}

					// 요청일시와 현재 시간의 차이를 구함
					Date conn_datm = DateUtil.getDate(DateUtil.getDateFormatByIntVal(tmp_arr[0], "yyyy-MM-dd HH:mm:ss"), "yyyy-MM-dd HH:mm:ss");
					Date now_datm = DateUtil.getDate(DateUtil.getToday("yyyy-MM-dd HH:mm:ss"), "yyyy-MM-dd HH:mm:ss");

					int diff = DateUtil.getDateDiff(conn_datm, now_datm, "M");

					// 5분 이상 차이가 날 경우 로그인 실패 처리
					if(diff > 5)
					{
						out.print(CommonUtil.getPopupMsg("요청가능 시간이 만료되었습니다.","",""));
						return;
					}

				}
				else
				{
					rec_datm = tmp_arr[0];
					local_no = tmp_arr[1];
					rec_filename = tmp_arr[2];
					// 파라미터 체크
					if(!CommonUtil.hasText(rec_datm) || !CommonUtil.hasText(local_no) || !CommonUtil.hasText(rec_filename)) {
						out.print(CommonUtil.getPopupMsg(CommonUtil.getErrorMsg("NO_PARAM"),"",""));
						return;
					}
				}

				// 사용권한 체크
				argMap.put("conf_field","download");
				argMap.put("user_id",_LOGIN_ID);
				argMap.put("user_level",_LOGIN_LEVEL);

				if(!"1".equals(db.selectOne("search_config.selectResultPerm", argMap)))
				{
					out.print(CommonUtil.getPopupMsg(CommonUtil.getErrorMsg("ERR_PERM"),"",""));
					return;
				}

				// yyyyMMddHHmmssSSS -> yyyy-MM-dd HH:mm:ss.SSS
				//rec_datm = DateUtil.getDateFormatByIntVal(rec_datm, "yyyy-MM-dd HH:mm:ss.SSS");
				rec_datm = DateUtil.getDateFormatByIntVal(rec_datm, "yyyy-MM-dd HH:mm:ss");

				argMap.clear();
				argMap.put("rec_datm",rec_datm);
//				argMap.put("local_no",local_no);
				argMap.put("rec_filename",rec_filename);

				// 녹취이력 조회
				Map<String, Object> data  = db.selectOne("rec_search.selectItem", argMap);
				if(data == null)
				{
					out.print(CommonUtil.getPopupMsg(CommonUtil.getErrorMsg("NO_DATA"),"",""));
					return;
				}

				argMap.put("login_id",_LOGIN_ID);
				argMap.put("login_name",_LOGIN_NAME);
				argMap.put("down_ip",request.getRemoteAddr());
				argMap.put("rec_keycode",data.get("rec_keycode").toString());
				//oracle 사용자 정보 없을 경우 null 체크 - CJM(20190624)
				argMap.put("user_id",CommonUtil.ifNull(data.get("user_id")+""));
				argMap.put("user_name",CommonUtil.ifNull(data.get("user_name")+""));

				argMap.put("reason_code",reason_code);
				argMap.put("reason_text",reason_text);
				argMap.put("down_src","");

				int ins_cnt = db.insert("hist_down.insertDownHist", argMap);
				// 녹취파일 경로 조회
				String file_url = getListenURL2("DOWN", data, logger, "END");
				// 녹취파일 HTTP 연결
				// 운영계
				//file_url = file_url.replace("https://cs-record-prd.amorepacific.com","http://localhost");

				// 개발계
				file_url = file_url.replace("https://cs-record-dev.amorepacific.com","http://localhost");
				logger.info("file_url  : " + file_url );
				if(file_url == null || "".equals(file_url))
				{
					out.print(CommonUtil.getPopupMsg("녹취파일 경로를 가져 오는데 실패했습니다.","",""));
					return;
				}

				if("ERR".equals(file_url.substring(0,3)))
				{
					out.print(CommonUtil.getPopupMsg(file_url.substring(3),"",""));
					return;
				}

				// http 통신 관련 변수 선언
				URL url = null;

				// 루키스, 나이스 데이터인 경우 파형 확장자를 가진 URL로 2번 http 통신이 필요함
				String system_code = data.get("system_code").toString();

				// 녹취파일 HTTP 연결
				url = new URL(file_url);
				logger.info("1");
				httpconn = (HttpURLConnection) url.openConnection();
				httpconn.setConnectTimeout(10000);
				//timeout으로 인한 주석 처리
				//httpconn.setReadTimeout(60000);
				logger.info("1-3");
				if(httpconn.getResponseCode()!=HttpURLConnection.HTTP_OK)
				{
					out.print(CommonUtil.getPopupMsg("녹취파일이 존재하지 않습니다.","",""));
					return;
				}
				logger.info("1-4");
				in = httpconn.getInputStream();

				String temp_entry_name = Integer.toString(i + 1);
				ZipEntry zipEntry = new ZipEntry(temp_entry_name);
				zipOutputStream.putNextEntry(zipEntry);
				byte[] Output = new byte[1024];
				int length;
				while ((length = in.read(Output)) > 0) {
					zipOutputStream.write(Output, 0, length);
				}
				zipOutputStream.closeEntry();
				in.close();


				logger.info("1-2");
			}
		}
		logger.info("2");
		String zipFileName = "MultiDownload.zip";

		zipOutputStream.close();
		byteArrayOutputStream.close();
		logger.info("3");
		byte[] bytes = byteArrayOutputStream.toByteArray();
		response.setContentType("application/zip");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + zipFileName + "\"");
		response.setContentLength(bytes.length);

		OutputStream outputStream = response.getOutputStream();
		outputStream.write(bytes);
		outputStream.flush();
		outputStream.close();
		logger.info("4");
		// resource close
		os.close();
		rd.close();
		baos.close();
		in.close();
		httpconn.disconnect();



	} catch(NullPointerException e) {
		logger.error(e.getMessage());
	} catch(Exception e) {
		logger.error(e.getMessage());
	} finally
	{
		if(httpconn != null)	httpconn.disconnect();
		if(in != null)	in.close();
		if(baos != null)	baos.close();
		if(rd != null)	rd.close();
		if(os!=null) os.close();
		if(db!=null) db.close();
	}
%>