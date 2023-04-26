package com.cnet.crec.util;

import com.sun.deploy.net.HttpResponse;
import org.apache.http.HttpEntity;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import java.io.*;

import static com.cnet.crec.common.Finals.S3_Bucket_Name;

public class S3Download {
    public static boolean DownloadFile( String Key, String FileName  )  {
        try {

            // AWS CLI 명령어 실행을 위한 ProcessBuilder 생성
            ProcessBuilder builder = new ProcessBuilder("aws", "s3api", "get-object", "--bucket", S3_Bucket_Name, "--region", "ap-northeast-2", "--key", Key, "d:\\temp\\" + FileName + ".tmp");

            // 프로세스 시작
            Process process = builder.start();

            // 명령어 실행 결과를 읽기 위한 BufferedReader 생성
            BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream()));

            // 명령어 실행 결과 출력
            String line;
            while ((line = reader.readLine()) != null) {
                //System.out.println(line);
            }
            reader.close();

            File recordFile = new File( "d:\\temp\\" + FileName + ".tmp");
            if (recordFile.exists()) {
                AecEncryption.decryptFile("d:\\temp\\" + FileName + ".tmp", "d:\\temp\\" + FileName);
            }

            return recordFile.exists();
        // 리소스 반환
        } catch (Exception ex) {
            return false;
        }
    }
}
