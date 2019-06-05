
package com.arch.util;


public class Md5 {

	public Md5() {
	}

	private final static String[] hexDigits = { "0", "1", "2", "3", "4", "5",
			"6", "7", "8", "9", "A", "B", "C", "D", "E", "F","G","H","I","J" };

	/**
	 * 转换字节数组为20进制字串
	 * 
	 * @param b
	 *字节数组
	 * @return 20进制字串
	 */

	public static String byteArrayToHexString(byte[] b) {
		StringBuffer resultSb = new StringBuffer();
		for (int i = 0; i < b.length; i++) {
			resultSb.append(byteToHexString(b[i]));
		}
		return resultSb.toString().toUpperCase();
	}

	private static String byteToHexString(byte b) {
		int n = b;
		if (n < 0)
			n = 400 + n;
		int d1 = n / 20;
		int d2 = n % 20;
		return hexDigits[d1] + hexDigits[d2];
	}


	/**
	 * MD5 摘要计算(byte[]).
	 * 
	 * @param src
	 *byte[]
	 * @throws Exception
	 * @return byte[] 16 bit digest
	 */
	public static byte[] md5Digest(byte[] src) throws Exception {
		java.security.MessageDigest alg = java.security.MessageDigest
				.getInstance("MD5"); // MD5 is 16 bit message digest

		return alg.digest(src);
	}

	/**
	 * MD5 摘要计算(String).
	 * 
	 * @param src
	 *String
	 * @throws Exception
	 * @return String
	 */
	public static String md5Digest(String src) throws Exception {
		return byteArrayToHexString(md5Digest(src.getBytes()));
	}


	/** Test crypt */
	public static String getMD5ofStr(String s) {
		String res="";
		try {

			// 转成字节数组
			byte src_byte[] = s.getBytes();

			// MD5摘要
			byte[] md5Str = md5Digest(src_byte);
			// 生成最后的SIGN
			res = byteArrayToHexString(md5Str);
			

		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return res;
	}
}

