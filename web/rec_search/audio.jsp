<%@ page
        language="java" contentType="audio/mpeg; charset=UTF-8" pageEncoding="UTF-8"
        trimDirectiveWhitespaces="true"
        import=" org.apache.log4j.Logger
		, org.json.simple.*
		, org.json.simple.parser.*
		, com.cnet.crec.common.*
		, com.cnet.crec.util.CommonUtil
		, com.cnet.crec.util.DateUtil
		, java.util.*
        , java.io.File
        , java.io.FileInputStream"
%>
<%@ page import="com.cnet.CnetCrypto.CNCrypto" %>
<%@ page import="java.net.URLDecoder" %>
<%
    Logger logger = Logger.getLogger(ComLib.getFileName(request));

    // no cache
    response.setHeader("Pragma", "no-cache");
    response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
    response.setHeader("Expires", "0");
    // encoding
    request.setCharacterEncoding("UTF-8");




    // set request
    CommonUtil.setReqest(request);
    CNCrypto aes = new CNCrypto("AES",CommonUtil.getEncKey());
    String refer = CommonUtil.getParameter("refer");

    String[] referfile = aes.Decrypt(refer.replace(".mp3","")).split("\\|");
    //logger.debug(temp);
//    01|20230324090208|20230323/11/d8f7e70b-765b-41e2-b529-5759e4e2b7f8_c14ce246-9f78-41bf-8d51-82e24b6a5b3b_2

    //out.println(filename);
    //http://127.0.0.1:8888/rec_search/audio.jsp?refer=vmJo1QWlgwQK7pYBJjp0ZsqYDQoCjOKruMBgiG//Qd4EZIk7qgGynWKEFyep36crRjM50P+KG6t2cpf3a/VpKCaDJqYq8PmBZ4y+iq4DR3oE3/JLv5u057LOLrp2+qPZpwRZcy3P2fAkW8ECAebyCQ==.mp3
    String filename = "D:/amore/Record/" + referfile[2] + ".mp3";

    File file = new File(filename);
    FileInputStream fileIn = new FileInputStream(file);
    ServletOutputStream output = response.getOutputStream();
    byte[] outputByte = new byte[4096];
    while(fileIn.read(outputByte, 0, 4096) != -1)
    {
        output.write(outputByte, 0, 4096);
    }
    fileIn.close();
    output.flush();
    output.close();
%>