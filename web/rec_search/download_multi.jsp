<%@ page import="java.io.*, java.util.zip.*" %>
<%
	try {
		String fileName = "20190329165946_1431.wav";
		String zipFileName = "example.zip";
		String fileUrl = "E:/test/20190403/190013/20190329165946_1431.wav";
		String zipFileUrl = "E:/test/20190403/190013/example.zip";

		FileInputStream fileInputStream = new FileInputStream(fileUrl);
		FileOutputStream fileOutputStream = new FileOutputStream(zipFileUrl);
		ZipOutputStream zipOutputStream = new ZipOutputStream(fileOutputStream);
		ZipEntry zipEntry = new ZipEntry(fileName);
		zipOutputStream.putNextEntry(zipEntry);

		byte[] buffer = new byte[1024];
		int length;
		while ((length = fileInputStream.read(buffer)) > 0) {
			zipOutputStream.write(buffer, 0, length);
		}

		zipOutputStream.closeEntry();
		zipOutputStream.close();
		fileInputStream.close();
		fileOutputStream.close();

		File file = new File(zipFileUrl);
		response.setContentType("application/zip");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + zipFileName + "\"");
		response.setContentLength((int) file.length());

		FileInputStream fileInputStream2 = new FileInputStream(file);
		OutputStream outputStream = response.getOutputStream();
		byte[] buffer2 = new byte[1024];
		int length2;
		while ((length2 = fileInputStream2.read(buffer2)) > 0) {
			outputStream.write(buffer2, 0, length2);
		}
		outputStream.flush();
		outputStream.close();
		fileInputStream2.close();

	} catch (Exception e) {

	}
%>