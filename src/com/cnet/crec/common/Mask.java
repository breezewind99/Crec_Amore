package com.cnet.crec.common;

import java.util.Arrays;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Mask {

    public Mask(){}

    // 전화번호 마스킹
    public static String getMaskedPhoneNum(Object temp) {
        if (temp == null) return "";
        String phoneNum = temp.toString();
        String regex = "(\\d{2,3})(\\d{3,4})(\\d{4})$";
        //String regex = "(\\d{2,3})-?(\\d{3,4})-?(\\d{4})$";		//휴대폰번호 '-' 포함
        Matcher matcher = Pattern.compile(regex).matcher(phoneNum);
        if (matcher.find()) {
            String replaceTarget1 = matcher.group(1);
            String replaceTarget2 = matcher.group(2).substring(0,2) + "**";
            String replaceTarget3 = matcher.group(3).substring(0,2) + "**";


            return replaceTarget1 + "-" + replaceTarget2 + "-" + replaceTarget3;
        }
        regex = "(\\d{1,4})(\\d{4})$";
        matcher = Pattern.compile(regex).matcher(phoneNum);
        if (matcher.find()) {
            String replaceTarget1 = "";
            if (matcher.group(1).length() == 4) {
                replaceTarget1 = matcher.group(1).substring(0,2) + "**";
            } else if (matcher.group(1).length() == 3) {
                replaceTarget1 = matcher.group(1).charAt(0) + "**";
            } else {
                replaceTarget1 = matcher.group(1);
            }
            String replaceTarget2 = matcher.group(2).substring(0,2) + "**";
            return replaceTarget1 + "-" + replaceTarget2;
        }
        return phoneNum;
    }

    public static String getMaskedPhoneNum2(Object temp) {
        if (temp == null) return "";
        String phoneNum = temp.toString();
        String regex = "(\\d{2,3})(\\d{3,4})(\\d{4})$";
        //String regex = "(\\d{2,3})-?(\\d{3,4})-?(\\d{4})$";		//휴대폰번호 '-' 포함
        Matcher matcher = Pattern.compile(regex).matcher(phoneNum);
        if (matcher.find()) {
            String replaceTarget1 = matcher.group(1);
            String replaceTarget2 = "****";
            String replaceTarget3 = matcher.group(3);


            return replaceTarget1 + "-" + replaceTarget2 + "-" + replaceTarget3;
        }
        regex = "(\\d{1,4})(\\d{4})$";
        matcher = Pattern.compile(regex).matcher(phoneNum);
        if (matcher.find()) {
            String replaceTarget1 = "";
//            if (matcher.group(1).length() == 4) {
//                replaceTarget1 = matcher.group(1).substring(0,2) + "**";
//            } else if (matcher.group(1).length() == 3) {
//                replaceTarget1 = matcher.group(1).charAt(0) + "**";
//            } else {
//                replaceTarget1 = matcher.group(1);
//            }
            replaceTarget1 = "****";
            String replaceTarget2 = matcher.group(2);
            return replaceTarget1 + "-" + replaceTarget2;
        }
        return phoneNum;
    }

    // 이름 중간 마스킹
    public static String getMaskedName(Object temp) {

        String maskedName = "";     // 마스킹 이름
        String firstName = "";      // 성
        String middleName = "";     // 이름 중간
        String lastName = "";       //이름 끝
        int lastNameStartPoint;     // 이름 시작 포인터
        if (temp == null) return "";
        String name = temp.toString();
        maskedName = name;

        /*보안 심의에서 제외 처리 요청*/
        if(!name.equals("") || name != null || name.equals("null")){
            if(name.length() > 1){
                firstName = name.substring(0, 1);
                lastNameStartPoint = name.indexOf(firstName);

                if(name.trim().length() > 2){
                    middleName = name.substring(lastNameStartPoint + 1, name.trim().length()-1);
                    lastName = name.substring(lastNameStartPoint + (name.trim().length() - 1), name.trim().length());
                }else{
                    middleName = name.substring(lastNameStartPoint + 1, name.trim().length());
                }

                String makers = "";
                for(int i = 0; i < middleName.length(); i++){
                    makers += "*";
                }

                lastName = middleName.replace(middleName, makers) + lastName;
                maskedName = firstName + lastName;
            }else{
                maskedName = name;
            }
        }

        return maskedName;
    }

    public static String  getCuttingPhoneNum(Object temp) {
        if (temp == null) return "";
        String phoneNum = temp.toString();
        String regex = "^(sips?):([^@\\n]+)(?:@(.+))?$";
        //String regex = "(\\d{2,3})-?(\\d{3,4})-?(\\d{4})$";		//휴대폰번호 '-' 포함
        Matcher matcher = Pattern.compile(regex).matcher(phoneNum);
        if (matcher.find()) {
            String replaceTarget2 = matcher.group(2);
            phoneNum = replaceTarget2;
        }
        if(phoneNum.substring(0,3).equals("+82")) {
            phoneNum = phoneNum.replace("+82","0");
        }
        if(phoneNum.substring(0,7).equals("tel:+82")) {
            phoneNum = phoneNum.replace("tel:+82","0");
        }
        phoneNum = java.net.URLDecoder.decode(phoneNum);
        return phoneNum;
    }
}
