package com.arch.util;
import java.io.IOException;

import java.security.Key;
import java.security.MessageDigest;

public class Azdg {
	private static Key key;
	
    private static Arithmetic des = new Arithmetic();// 实例化一个对像
    public Azdg(){
    	des.getKey(SysConst.FORMACTION);
    
    }
    

public static String encrypt(String txt, String key) {

	des.getKey(SysConst.FORMACTION);
	return des.getEncString(txt);
}
public static String encryptsubmit(String txt, String key) {

	des.getKey(SysConst.FORMACTION);
	return des.getEncString(txt);
}
/**

* 解密算法

*/

public static String decrypt(String cipherText, String key) {

	des.getKey(SysConst.FORMACTION);

	return des.getDesString(cipherText);


}

	

	}


