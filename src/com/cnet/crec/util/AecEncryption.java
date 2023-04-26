package com.cnet.crec.util;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.nio.file.Files;
import java.nio.file.Paths;

public class AecEncryption {
    private static final byte[] KEY = {
            // AES256 키 (32바이트)
            // 키는 암호화 및 복호화에 사용됩니다.
            (byte) 0x2B, (byte) 0x7E, (byte) 0x15, (byte) 0x16,
            (byte) 0x28, (byte) 0xAE, (byte) 0xD2, (byte) 0xA6,
            (byte) 0xAB, (byte) 0xF7, (byte) 0x15, (byte) 0x88,
            (byte) 0x09, (byte) 0xCF, (byte) 0x4F, (byte) 0x3C,
            (byte) 0xA8, (byte) 0x36, (byte) 0x9F, (byte) 0x43,
            (byte) 0x00, (byte) 0x00, (byte) 0x00, (byte) 0x00,
            (byte) 0x00, (byte) 0x00, (byte) 0x00, (byte) 0x00,
            (byte) 0x00, (byte) 0x00, (byte) 0x00, (byte) 0x00
    };

    private static final byte[] IV = {
            // 초기화 벡터 (16바이트)
            // IV는 암호화를 수행하기 전에 데이터에 랜덤으로 추가됩니다.
            (byte) 0x00, (byte) 0x01, (byte) 0x02, (byte) 0x03,
            (byte) 0x04, (byte) 0x05, (byte) 0x06, (byte) 0x07,
            (byte) 0x08, (byte) 0x09, (byte) 0x0A, (byte) 0x0B,
            (byte) 0x0C, (byte) 0x0D, (byte) 0x0E, (byte) 0x0F
    };

    public static void decryptFile(String inputFile, String outputFile) throws Exception {
        // AES256 복호화 객체 생성
        Cipher aes = Cipher.getInstance("AES/CBC/PKCS5Padding");
        SecretKeySpec keySpec = new SecretKeySpec(KEY, "AES");
        IvParameterSpec ivSpec = new IvParameterSpec(IV);
        aes.init(Cipher.DECRYPT_MODE, keySpec, ivSpec);

        // 입력 파일을 바이트 배열로 읽어들임
        byte[] cipherBytes = Files.readAllBytes(Paths.get(inputFile));

        // 암호화된 데이터를 복호화
        byte[] fileBytes = aes.doFinal(cipherBytes);

        // 복호화된 데이터를 출력 파일에 저장
        Files.write(Paths.get(outputFile), fileBytes);
    }

    public static void encryptFile(String inputFile, String outputFile) throws Exception {
        // AES256 암호화 객체 생성
        Cipher aes = Cipher.getInstance("AES/CBC/PKCS5Padding");
        SecretKeySpec keySpec = new SecretKeySpec(KEY, "AES");
        IvParameterSpec ivSpec = new IvParameterSpec(IV);
        aes.init(Cipher.ENCRYPT_MODE, keySpec, ivSpec);

        // 입력 파일을 바이트 배열로 읽어들임
        byte[] fileBytes = Files.readAllBytes(Paths.get(inputFile));

        // 데이터를 암호화
        byte[] cipherBytes = aes.doFinal(fileBytes);

        // 암호화된 데이터를 출력 파일에 저장
        Files.write(Paths.get(outputFile), cipherBytes);
    }
}
