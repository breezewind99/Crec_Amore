<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%@ include file="/common/function.jsp" %>
<%@ page import="java.net.URL"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.io.*"%>
<%
	if(!Site.isPmss(out,"rec_search","")) return;

	Db db = null;

	HttpURLConnection httpconn = null;
	InputStream in = null;
	ByteArrayOutputStream baos = null;
	BufferedReader rd = null;
	BufferedOutputStream os = null;

	try 
	{
		db = new Db(true);

		Map<String, Object> confMap = new HashMap<String, Object>();
//		List<Map<String, Object>> conf_list = db.selectList("download.selectList");
		boolean bDownload = true;
//		for(Map<String, Object> item : conf_list) {
//			if (item.get("download_ip").toString().equals(request.getRemoteAddr().toString())) {bDownload=true;}
//		}
		if (!bDownload) {
			out.print(CommonUtil.getPopupMsg("권한이 없습니다.","","close"));
			return;
		}

		// get parameter
		String info = CommonUtil.getParameter("info");
		String reason_code = CommonUtil.getParameter("reason_code");
		String reason_text = CommonUtil.getParameter("reason_text");
		String extension = CommonUtil.getParameter("extension","WAV");	//확장자

		// 파라미터 체크
		if(!CommonUtil.hasText(info) || (Finals.isExistPlayDownReason && !CommonUtil.hasText(reason_code))) 
		{
			out.print(CommonUtil.getPopupMsg(CommonUtil.getErrorMsg("NO_PARAM"),"",""));
			return;
		}

		// 파리미터 복호화
		CNCrypto aes = new CNCrypto("AES",CommonUtil.getEncKey());
		info = aes.Decrypt(info);
		//logger.error("info2 : " + info);
		String tmp_arr[] = info.split("\\|");
		//logger.error("info count2 : " + tmp_arr.length);

		int arrcount = tmp_arr.length;
		String arrcount2 = Integer.toString(arrcount);

		String rec_datm = tmp_arr[1];
		String local_no = tmp_arr[2];
		String rec_filename = tmp_arr[3];

		String file_name = rec_filename;
		//logger.error("arrcount2 : " + "5".equals(arrcount2));
		
		if("5".equals(arrcount2))
		{
			//20170908 현원희 수정
			//기본파일명+안내번호 명으로 수정
			file_name = rec_filename.replace(".wav","") + "_"+ tmp_arr[4]+".wav";
		}
		
		String ext = ".wav";
		if(extension.equals("PCM"))	ext = ".pcm";
		else						ext = ".wav";
		
		file_name = file_name.replace(".wav",ext);
		
		//logger.error("file_name2 : " + file_name);
		/*
		logger.info("rec_datm : " + rec_datm);
		logger.info("local_no : " + local_no);
		logger.info("rec_filename : " + rec_filename);
		*/
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

		Map<String, Object> argMap = new HashMap<String, Object>();

		// 사용권한 체크
		argMap.put("conf_field","download");
		argMap.put("user_id",_LOGIN_ID);
		argMap.put("user_level",_LOGIN_LEVEL);

		if(!"1".equals(db.selectOne("search_config.selectResultPerm", argMap))) 
		{
			out.print(CommonUtil.getPopupMsg(CommonUtil.getErrorMsg("ERR_PERM"),"",""));
			return;
		}

		//yyyyMMddHHmmssSSS -> yyyy-MM-dd HH:mm:ss.SSS
		//rec_datm = DateUtil.getDateFormatByIntVal(rec_datm, "yyyy-MM-dd HH:mm:ss.SSS");
		rec_datm = DateUtil.getDateFormatByIntVal(rec_datm, "yyyy-MM-dd HH:mm:ss");

		argMap.clear();
		//argMap.put("dateStr", CommonUtil.getRecordTableNm(rec_datm));
		argMap.put("dateStr", "");
		argMap.put("rec_datm",rec_datm);
//		argMap.put("local_no",local_no);
		argMap.put("rec_filename",rec_filename);

		// 녹취이력 조회
		Map<String, Object> data  = db.selectOne("rec_search.selectItem", argMap);
		if(data == null) 
		{
			out.print(CommonUtil.getPopupMsg(CommonUtil.getErrorMsg("NO_DATA"),"",""));
			return;
		}

		// 녹취파일 경로 조회
		//String file_url = getListenURL5("DOWN", data, logger);
		String file_url = getListenURL5(extension, data, logger);
		file_url = getListenURL2("LISTEN", data, logger, "");

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

		// http 통신 관련 변수 선언
		URL url = null;

		// 루키스, 나이스 데이터인 경우 파형 확장자를 가진 URL로 2번 http 통신이 필요함
		String system_code = data.get("system_code").toString();

		//if("99".equals(system_code) || "88".equals(system_code)) {
		String fft_url = "";
		/*if("99".equals(system_code)) {
			fft_url = file_url.replace(".wav", ".fft");
		} else {
			fft_url = file_url.replace(".wav", ".nmf");
		}*/
//		if("88".equals(system_code))
//		{
//			fft_url = file_url.replace("download", "ffttext");
//		}
//		else
//		{
//			fft_url = file_url.replace("download", "ffttext");
//		}
//
//		// 녹취파형 HTTP 연결
//		url = new URL(fft_url);
//		httpconn = (HttpURLConnection) url.openConnection();
//		httpconn.setConnectTimeout(10000);
//
//		if(httpconn.getResponseCode() != HttpURLConnection.HTTP_OK)
//		{
//			out.print(CommonUtil.getPopupMsg("녹취파일이 존재하지 않습니다.","",""));
//			return;
//		}
		//}

		// 녹취파일 HTTP 연결
		// 운영계
		//file_url = file_url.replace("https://cs-record-prd.amorepacific.com","http://localhost");

		// 개발계
		file_url = file_url.replace("https://cs-record-dev.amorepacific.com","http://localhost");
		url = new URL(file_url);

		httpconn = (HttpURLConnection) url.openConnection();
		httpconn.setConnectTimeout(10000);
		//timeout으로 인한 주석 처리
		//httpconn.setReadTimeout(60000);

		if(httpconn.getResponseCode() != HttpURLConnection.HTTP_OK) 
		{
			out.print(CommonUtil.getPopupMsg("녹취파일이 존재하지 않습니다.","",""));
			return;
		}

		String contentType = httpconn.getContentType();
		int contentLength = httpconn.getContentLength();

		in = httpconn.getInputStream();
		baos = new ByteArrayOutputStream();

		// 미디어 서버 연동 결과 저장
		byte[] buffer = new byte[4096];
		int leng = 0;
		while((leng=in.read(buffer)) != -1) 
		{
			baos.write(buffer, 0, leng);
		}
		baos.flush();

		// 미디어 서버 오류 체크
		rd = new BufferedReader(new InputStreamReader(new ByteArrayInputStream(baos.toByteArray())));
		//logger.debug("rd="+rd.readLine());
		String reLine = rd.readLine();
		if (reLine == null) {
			out.print(CommonUtil.getPopupMsg("미디어서버 오류가 발생하였습니다.","",""));
			return;
		}
		//logger.debug("rd1 :"+rd.readLine());
		//logger.debug("rd2 :"+rd.readLine().trim().substring(0, 4));
		
		
		//2017년 08월 16일 현원희 주석처리
		//미디어 서버 다운로드 오류로 인하여 잠시 주석 처리
		//동일하게 다운로드 안되는 이력 발생하여 예외처리 - CJM(20190123)
		/*
		logger.debug("length1 : "+rd.readLine().length());
		rd.readLine().trim();
		logger.debug("length2 : "+rd.readLine().length());
		logger.debug("rd2 : "+rd.readLine());
		*/
		if((reLine.length() > 4) && ("<H2>".equals(reLine.substring(0,4))))
		//if("<H2>".equals(rd.readLine().substring(0,4)))
		{
			out.print(CommonUtil.getPopupMsg("미디어서버 오류가 발생하였습니다.","",""));
			return;
		}

		response.reset();
		response.setContentType(contentType);
		response.setHeader("Content-Description","Generated By CREC");
		response.setHeader("Content-Disposition","attachment; filename = " + new String(file_name.replace(".nmf", ".wav").getBytes("UTF-8"),"8859_1"));
		response.setHeader("Content-Length",""+contentLength);
		response.setHeader("Pragma","no-cache");
		//response.setHeader("Pragma","public");
		response.setHeader("Expires","0");
		response.setHeader("Cache-Control","max-age=0");

		// getOutputStream error block
		out.clear();
		out=pageContext.pushBody();

		// file write
		os = new BufferedOutputStream(response.getOutputStream());
		os.write(baos.toByteArray());

		// resource close
		os.close();
		rd.close();
		baos.close();
		in.close();
		httpconn.disconnect();

		// 다운로드 이력 저장
		argMap.put("rec_datm",data.get("rec_datm").toString());
//		argMap.put("local_no",data.get("local_no").toString());
		argMap.put("rec_filename",data.get("rec_filename").toString());
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
		if(os != null)	os.close();
		if(db != null)	db.close();
	}
%>