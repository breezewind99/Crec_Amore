<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/common.jsp" %>
<%
String dataStr = "[{\"item_code\":\"1000\",\"spart_code\":\"WA3002\",\"mpart_code\":\"WA2001\",\"add_score_tot\":2,\"user_name\":\"신혜숙174\",\"add_score_1100\":0,\"add_score_1000\":2,\"exam_score_tot\":18,\"add_score_1400\":0,\"eval_order\":2,\"add_score_1300\":0,\"add_score_1200\":0,\"add_score_1600\":0,\"bpart_code\":\"WA1001\",\"best_cnt\":0,\"eval_cnt\":1,\"worst_cnt\":0,\"item_score_1200\":\"3<font color=#bbbbbb>/</font>0\",\"item_score_1300\":\"3<font color=#bbbbbb>/</font>0\",\"item_score_1000\":\"5<font color=#bbbbbb>/</font>2\",\"spart_name\":\"6H-1\",\"item_score_1100\":\"4<font color=#bbbbbb>/</font>0\",\"mpart_name\":\"부일\",\"item_score_1600\":\"1<font color=#bbbbbb>/</font>0\",\"exam_score_1600\":1,\"item_score_1400\":\"2<font color=#bbbbbb>/</font>0\",\"exam_score_1400\":2,\"bpart_name\":\"부산센터\",\"user_id\":\"C410287\",\"eval_user_name\":\"관리자\",\"eval_score\":20,\"exam_score_1300\":3,\"exam_score_1200\":3,\"exam_score_1100\":4,\"exam_score_1000\":5,\"upd_datm\":\"17.09.18\"},{\"item_code\":\"1000\",\"spart_code\":\"WA3002\",\"mpart_code\":\"WA2001\",\"add_score_tot\":0,\"user_name\":\"\",\"add_score_1100\":0,\"add_score_1000\":0,\"exam_score_tot\":18,\"add_score_1400\":0,\"eval_order\":3,\"add_score_1300\":0,\"add_score_1200\":0,\"add_score_1600\":0,\"bpart_code\":\"WA1001\",\"best_cnt\":0,\"eval_cnt\":1,\"worst_cnt\":0,\"item_score_1200\":\"3<font color=#bbbbbb>/</font>0\",\"item_score_1300\":\"3<font color=#bbbbbb>/</font>0\",\"item_score_1000\":\"3<font color=#bbbbbb>/</font>0\",\"spart_name\":\"6H-1\",\"item_score_1100\":\"3<font color=#bbbbbb>/</font>0\",\"mpart_name\":\"부일\",\"item_score_1600\":\"3<font color=#bbbbbb>/</font>0\",\"exam_score_1600\":3,\"item_score_1400\":\"3<font color=#bbbbbb>/</font>0\",\"exam_score_1400\":3,\"bpart_name\":\"부산센터\",\"user_id\":\"\",\"eval_user_name\":\"관리자\",\"eval_score\":18,\"exam_score_1300\":3,\"exam_score_1200\":3,\"exam_score_1100\":3,\"exam_score_1000\":3,\"upd_datm\":\"17.09.18\",\"part_name\":\" \"},{\"item_code\":\"1000\",\"spart_code\":\"WA3002\",\"mpart_code\":\"WA2001\",\"add_score_tot\":0,\"user_name\":\"\",\"add_score_1100\":0,\"add_score_1000\":0,\"exam_score_tot\":22,\"add_score_1400\":0,\"eval_order\":4,\"add_score_1300\":0,\"add_score_1200\":0,\"add_score_1600\":0,\"bpart_code\":\"WA1001\",\"best_cnt\":0,\"eval_cnt\":1,\"worst_cnt\":0,\"item_score_1200\":\"5<font color=#bbbbbb>/</font>0\",\"item_score_1300\":\"3<font color=#bbbbbb>/</font>0\",\"item_score_1000\":\"4<font color=#bbbbbb>/</font>0\",\"spart_name\":\"6H-1\",\"item_score_1100\":\"2<font color=#bbbbbb>/</font>0\",\"mpart_name\":\"부일\",\"item_score_1600\":\"5<font color=#bbbbbb>/</font>0\",\"exam_score_1600\":5,\"item_score_1400\":\"3<font color=#bbbbbb>/</font>0\",\"exam_score_1400\":3,\"bpart_name\":\"부산센터\",\"user_id\":\"\",\"eval_user_name\":\"관리자\",\"eval_score\":22,\"exam_score_1300\":3,\"exam_score_1200\":5,\"exam_score_1100\":2,\"exam_score_1000\":4,\"upd_datm\":\"17.09.18\",\"part_name\":\" \"},{\"item_score_1200\":\"<b><font color=blue>3.7<font color=#bbbbbb>/</font>0</font></b>\",\"worst_cnt\":0,\"item_score_1300\":\"<b><font color=blue>3<font color=#bbbbbb>/</font>0</font></b>\",\"item_score_1000\":\"<b><font color=blue>4<font color=#bbbbbb>/</font>0.7</font></b>\",\"item_score_1100\":\"<b><font color=blue>3<font color=#bbbbbb>/</font>0</font></b>\",\"item_score_1600\":\"<b><font color=blue>3<font color=#bbbbbb>/</font>0</font></b>\",\"add_score_tot\":2,\"kind\":\"subSum\",\"user_name\":\"-\",\"item_score_1400\":\"<b><font color=blue>2.7<font color=#bbbbbb>/</font>0</font></b>\",\"exam_score_tot\":58,\"eval_order\":\"\",\"pq_rowcls\":\"red\",\"user_id\":\"-\",\"eval_user_name\":\"-\",\"eval_score\":60,\"best_cnt\":0,\"eval_cnt\":3,\"upd_datm\":\"-\",\"part_name\":\"<font color=gray>소계</font>\"},{\"item_code\":\"1000\",\"spart_code\":\"WC3016\",\"mpart_code\":\"WC2001\",\"add_score_tot\":0,\"user_name\":\"이은하S121\",\"add_score_1100\":0,\"add_score_1000\":0,\"exam_score_tot\":18,\"add_score_1400\":0,\"eval_order\":1,\"add_score_1300\":0,\"add_score_1200\":0,\"add_score_1600\":0,\"bpart_code\":\"WC1001\",\"best_cnt\":0,\"eval_cnt\":1,\"worst_cnt\":0,\"item_score_1200\":\"3<font color=#bbbbbb>/</font>0\",\"item_score_1300\":\"3<font color=#bbbbbb>/</font>0\",\"item_score_1000\":\"3<font color=#bbbbbb>/</font>0\",\"spart_name\":\"iMall저녁02\",\"item_score_1100\":\"3<font color=#bbbbbb>/</font>0\",\"mpart_name\":\"효성\",\"item_score_1600\":\"3<font color=#bbbbbb>/</font>0\",\"exam_score_1600\":3,\"item_score_1400\":\"3<font color=#bbbbbb>/</font>0\",\"exam_score_1400\":3,\"bpart_name\":\"서울센터\",\"user_id\":\"C410140\",\"eval_user_name\":\"관리자\",\"eval_score\":18,\"exam_score_1300\":3,\"exam_score_1200\":3,\"exam_score_1100\":3,\"exam_score_1000\":3,\"upd_datm\":\"17.09.18\"},{\"item_code\":\"1000\",\"spart_code\":\"WC3016\",\"mpart_code\":\"WC2001\",\"add_score_tot\":0,\"user_name\":\"\",\"add_score_1100\":0,\"add_score_1000\":0,\"exam_score_tot\":18,\"add_score_1400\":0,\"eval_order\":2,\"add_score_1300\":0,\"add_score_1200\":0,\"add_score_1600\":0,\"bpart_code\":\"WC1001\",\"best_cnt\":0,\"eval_cnt\":1,\"worst_cnt\":1,\"item_score_1200\":\"3<font color=#bbbbbb>/</font>0\",\"item_score_1300\":\"3<font color=#bbbbbb>/</font>0\",\"item_score_1000\":\"3<font color=#bbbbbb>/</font>0\",\"spart_name\":\"iMall저녁02\",\"item_score_1100\":\"3<font color=#bbbbbb>/</font>0\",\"mpart_name\":\"효성\",\"item_score_1600\":\"3<font color=#bbbbbb>/</font>0\",\"exam_score_1600\":3,\"item_score_1400\":\"3<font color=#bbbbbb>/</font>0\",\"exam_score_1400\":3,\"bpart_name\":\"서울센터\",\"user_id\":\"\",\"eval_user_name\":\"관리자\",\"eval_score\":18,\"exam_score_1300\":3,\"exam_score_1200\":3,\"exam_score_1100\":3,\"exam_score_1000\":3,\"upd_datm\":\"17.09.18\",\"part_name\":\" \"},{\"item_code\":\"1000\",\"spart_code\":\"WC3016\",\"mpart_code\":\"WC2001\",\"add_score_tot\":0,\"user_name\":\"\",\"add_score_1100\":0,\"add_score_1000\":0,\"exam_score_tot\":18,\"add_score_1400\":0,\"eval_order\":3,\"add_score_1300\":0,\"add_score_1200\":0,\"add_score_1600\":0,\"bpart_code\":\"WC1001\",\"best_cnt\":1,\"eval_cnt\":1,\"worst_cnt\":0,\"item_score_1200\":\"3<font color=#bbbbbb>/</font>0\",\"item_score_1300\":\"3<font color=#bbbbbb>/</font>0\",\"item_score_1000\":\"3<font color=#bbbbbb>/</font>0\",\"spart_name\":\"iMall저녁02\",\"item_score_1100\":\"3<font color=#bbbbbb>/</font>0\",\"mpart_name\":\"효성\",\"item_score_1600\":\"3<font color=#bbbbbb>/</font>0\",\"exam_score_1600\":3,\"item_score_1400\":\"3<font color=#bbbbbb>/</font>0\",\"exam_score_1400\":3,\"bpart_name\":\"서울센터\",\"user_id\":\"\",\"eval_user_name\":\"관리자\",\"eval_score\":18,\"exam_score_1300\":3,\"exam_score_1200\":3,\"exam_score_1100\":3,\"exam_score_1000\":3,\"upd_datm\":\"17.09.18\",\"part_name\":\" \"},{\"item_code\":\"1000\",\"spart_code\":\"WC3016\",\"mpart_code\":\"WC2001\",\"add_score_tot\":3,\"user_name\":\"\",\"add_score_1100\":1,\"add_score_1000\":2,\"exam_score_tot\":22,\"add_score_1400\":0,\"eval_order\":4,\"add_score_1300\":0,\"add_score_1200\":0,\"add_score_1600\":0,\"bpart_code\":\"WC1001\",\"best_cnt\":1,\"eval_cnt\":1,\"worst_cnt\":0,\"item_score_1200\":\"3<font color=#bbbbbb>/</font>0\",\"item_score_1300\":\"3<font color=#bbbbbb>/</font>0\",\"item_score_1000\":\"5<font color=#bbbbbb>/</font>2\",\"spart_name\":\"iMall저녁02\",\"item_score_1100\":\"5<font color=#bbbbbb>/</font>1\",\"mpart_name\":\"효성\",\"item_score_1600\":\"3<font color=#bbbbbb>/</font>0\",\"exam_score_1600\":3,\"item_score_1400\":\"3<font color=#bbbbbb>/</font>0\",\"exam_score_1400\":3,\"bpart_name\":\"서울센터\",\"user_id\":\"\",\"eval_user_name\":\"관리자\",\"eval_score\":25,\"exam_score_1300\":3,\"exam_score_1200\":3,\"exam_score_1100\":5,\"exam_score_1000\":5,\"upd_datm\":\"17.09.19\",\"part_name\":\" \"},{\"item_score_1200\":\"<b><font color=blue>3<font color=#bbbbbb>/</font>0</font></b>\",\"worst_cnt\":1,\"item_score_1300\":\"<b><font color=blue>3<font color=#bbbbbb>/</font>0</font></b>\",\"item_score_1000\":\"<b><font color=blue>3.5<font color=#bbbbbb>/</font>0.5</font></b>\",\"item_score_1100\":\"<b><font color=blue>3.5<font color=#bbbbbb>/</font>0.3</font></b>\",\"item_score_1600\":\"<b><font color=blue>3<font color=#bbbbbb>/</font>0</font></b>\",\"add_score_tot\":3,\"kind\":\"subSum\",\"user_name\":\"-\",\"item_score_1400\":\"<b><font color=blue>3<font color=#bbbbbb>/</font>0</font></b>\",\"exam_score_tot\":76,\"eval_order\":\"\",\"pq_rowcls\":\"red\",\"user_id\":\"-\",\"eval_user_name\":\"-\",\"eval_score\":79,\"best_cnt\":2,\"eval_cnt\":4,\"upd_datm\":\"-\",\"part_name\":\"<font color=gray>소계</font>\"}]";
out.println("dataStr="+dataStr+"<br>");

JSONParser jsonParser = new JSONParser();
JSONArray datas = (JSONArray) jsonParser.parse(dataStr);
out.println("datas.size()="+datas.size());
for(int i=0;i<datas.size();i++) {
	JSONObject d = (JSONObject) datas.get(i);
	out.println(d.get("bpart_name"));
}
%>