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
<%@ page import="com.cnet.crec.util.S3Download" %>
<%
    Logger logger = Logger.getLogger(ComLib.getFileName(request));

    // set request
    CommonUtil.setReqest(request);
    CNCrypto aes = new CNCrypto("AES",CommonUtil.getEncKey());
    String refer = CommonUtil.getParameter("refer");

    String[] referfile = aes.Decrypt(refer.replace(".mp3","")).split("\\|");
    String[] tempfile = referfile[2].split("/");
    String filename = "D:/amore/Record/" + referfile[2] + ".mp3";
    String OriginStorage = "RECORD/" + referfile[2] + ".mp3";
    String TargetFile = tempfile[2] + ".mp3";
    if (S3Download.DownloadFile(OriginStorage, TargetFile) ) {
        filename = "D:/temp/" + TargetFile;
    }
    File file = new File(filename);
    FileInputStream fileIn = new FileInputStream(file);

    response.setHeader("Access-Control-Allow-Headers","origin, x-requested-with, content-type, accept");
    response.setHeader("Connection", "Close");
    response.setHeader("Server", "Cnet Media WebServer");
    response.setHeader("Accept-Ranges", "bytes");
    response.setContentLength(fileIn.available());

    // encoding
    request.setCharacterEncoding("UTF-8");

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