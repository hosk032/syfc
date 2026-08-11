package com.syfc.util;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.regex.Pattern;

public class MyUtil {
	/**
	 * 문자열이 null 이거나 길이가 0 또는 공백 문자(스페이스, 탭, 개행 등)만 있는지 검사
	 * @param str
	 * @return
	 */
	public boolean isEmpty(String str) {
	    return str == null || str.isBlank();
	}
	
	/**
	 * 문자열을 주소형식으로 인코딩
	 * @param str 인코딩할 문자열
	 * @return 주소형식으로 인코딩된 문자열
	 */
	public String encodeUrl(String str) {
		 if (str == null) {
			 return null;
		 }
		 
		 try {
			str = URLEncoder.encode(str, StandardCharsets.UTF_8.name());
		} catch (UnsupportedEncodingException e) {
		}
		
		return str;
	}

	/**
	 * 주소 형식의 문자열을 디코딩
	 * @param str 디코딩할 인코딩된 문자열
	 * @return 디코딩된 문자열
	 */
	public String decodeUrl(String str) {
		Pattern pattern = Pattern.compile(".*%[0-9a-fA-F]{2}.*");
		
		 if (str == null) {
			 return null;
		 }
		 
		 try {
			  if (! str.contains("%")) { // % 가 없으면 디코딩하지 않아도 됨
				  return str;
			  }
			  
			   // 인코딩 패턴이 유효한 경우만 디코딩 시도
			  if (pattern.matcher(str).matches()) {
				  return URLDecoder.decode(str, StandardCharsets.UTF_8.name());
			  }
		} catch (IllegalArgumentException e) {
			// 잘못된 % 인코딩 형식(%가 있지만 2자리 16진수가 아닌 경우)이 존재하는 경우
		} catch (UnsupportedEncodingException e) {
		}
		
		return str;
	}
    
	/**
	 * 특수문자를 HTML 문자로 변경 및 엔터를 <br> 로 변경
	 * 
	 * @param str 변경할 문자열
	 * @return HTML 문자로 변경된 문자열
	 */
	public String htmlSymbols(String str) {
		if (str == null || str.length() == 0) {
			return "";
		}

		str = str.replaceAll("&", "&amp;");
		str = str.replaceAll("\"", "&quot;");
		str = str.replaceAll(">", "&gt;");
		str = str.replaceAll("<", "&lt;");

		str = str.replaceAll("\n", "<br>");
		str = str.replaceAll("\\s", "&nbsp;"); // \\s가 엔터도 변경하므로 \n보다 뒤에

		return str;
	}

	/**
	* 중간 이름 마스킹 처리
	* @param name		이름
	* @return			마스킹 처리된 이름
	*/
	public String nameMasking(String name) {
		int length;

		try {
			name = name.replaceAll("\\s", "");
			length = name.length();

			if (length < 2) {
				return name;
			}

			if (length == 2) {
				return name.charAt(0) + "*";
			}

			StringBuilder masked = new StringBuilder();
			masked.append(name.charAt(0));
			for (int i = 1; i < length - 1; i++) {
				masked.append("*");
			}
			masked.append(name.charAt(length - 1));

			return masked.toString();
		} catch (Exception e) {
		}
		
		return null;
	}
	
	/**
	 * E-Mail 검사
	 * 
	 * @param email 검사 할 E-Mail
	 * @return E-Mail 검사 결과
	 */
	public boolean isValidEmail(String email) {
		if (email == null) {
			return false;
		}

		return Pattern.matches("[\\w\\~\\-\\.]+@[\\w\\~\\-]+(\\.[\\w\\~\\-]+)+", email.trim());
	}
}
