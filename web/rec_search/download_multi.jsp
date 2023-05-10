<%@ page import="java.io.*, java.util.zip.*" %>
<%@ page import="com.cnet.crec.util.CommonUtil" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.util.Arrays" %>
<%
	try {

		String zipFileName = "multi.zip";

		String[] file_url = {"https://cs-record-dev.amorepacific.com/rec_search/audio.jsp?refer=pr6jJdmtuBLSBEveGYVWFxA5MhJB61yzDFKBhDp26GDUT%2BeZG8SytZt86zNIeXnC%2B1L2BBPDmuNYriF2Ii%2BJCgOwxIz4ioZLE%2FVMLJF93nw7zKlO5qcqIpTMm%2Fkl%2BT3JRRnzbzmGgSKS9jQwadanmg%3D%3D.mp3",
				"https://cs-record-dev.amorepacific.com/rec_search/audio.jsp?refer=pr6jJdmtuBLSBEveGYVWF9lEMmuRwNuOczk0f%2F3DUWDxrm3332IFz5rm9NgkvIUQ1Hg9g8oN87GfITvtg8D2jHfW9lc6NHJeTCUH0tYzYaQWyX9YBQqO37DEv66Oh5SdVJDl%2Bn01oSPH4vGDO1%2FEtQ%3D%3D.mp3",
				"https://cs-record-dev.amorepacific.com/rec_search/audio.jsp?refer=pr6jJdmtuBLSBEveGYVWFypm1Mc3ERsfzi2LDegECE86OaWlT7siGn8Aq749nSupplD1dG%2F8XBbfCCwIj9j9y7iWgF5Bch%2BYxZZf%2Bs7ReRForFJpgIX20MCxw0qeB%2BHd4%2Bhk%2FLhAKf0a%2B%2B5hQeSU5g%3D%3D.mp3",
				"https://cs-record-dev.amorepacific.com/rec_search/audio.jsp?refer=pr6jJdmtuBLSBEveGYVWF0JIe9SQVxYAaKlsvJQIty5eqHhxhBkrnOI3spemR0MeFxc9FIFFkhK5qzxaTMf4O1gHvRMiu32L6wTJ6UuhN3ivdRsFnNc8fXQnQL%2FGRZxnh%2BI%2BFO%2Fd1AJDlGg43A%2Fprg%3D%3D.mp3",
				"https://cs-record-dev.amorepacific.com/rec_search/audio.jsp?refer=pr6jJdmtuBLSBEveGYVWFy%2BQPvEjuzP6dPFQUsD4tuUcPVszaua9%2FYlK3R5LpYKm12TxzXch35S8WMMIAZEsUjQ1wt9FafTAubUieyD5a9KRX8irfOW%2BK69h%2FZfmTk6Xj6kibvuNVdehTD9mzQsIXA%3D%3D.mp3"
		};

		ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
		ZipOutputStream zipOutputStream = new ZipOutputStream(byteArrayOutputStream);

		for (String item : file_url) {

			URL url = null;
			HttpURLConnection httpconn = null;
			InputStream in = null;

			try {

				url = new URL(item);

				httpconn = (HttpURLConnection) url.openConnection();
				httpconn.setConnectTimeout(10000);

				if(httpconn.getResponseCode() == HttpURLConnection.HTTP_OK)
				{
					ZipEntry zipEntry = new ZipEntry(item);
					in = httpconn.getInputStream();

					zipOutputStream.putNextEntry(zipEntry);
					byte[] Output = new byte[1024];
					int length;
					while ((length = in.read(Output)) > 0) {
						zipOutputStream.write(Output, 0, length);
					}
					in.close();
					zipOutputStream.closeEntry();
				}

			} catch (Exception ex) {

			}

		}
		zipOutputStream.close();
		byteArrayOutputStream.close();

		byte[] bytes = byteArrayOutputStream.toByteArray();
		response.setContentType("application/zip");
		response.setHeader("Content-Disposition", "attachment; filename=\"" + zipFileName + "\"");
		response.setContentLength(bytes.length);

		OutputStream outputStream = response.getOutputStream();
		outputStream.write(bytes);
		outputStream.flush();
		outputStream.close();

	} catch (Exception e) {

	}
%>