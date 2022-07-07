package com.dma.utils.cipher.rsa;

import com.dma.utils.cipher.tea.TEA;

import java.net.URLDecoder;

public class RSATest {

	public static void main(String[] args) {
		TEA tea = new TEA(TEA.generateUUID());
		String contents = "test";
		String encryptText = tea.encrypt(contents);
		String decryptText = tea.decrypt(encryptText);

		System.out.println(encryptText);
		System.out.println(decryptText);

		RSA.RSAKey rsaKey = RSA.createRsa();

		String RSAModulus = rsaKey.getPublicKeyModulus();
		String RSAExponent = rsaKey.getPublicKeyExponent();

		System.out.println(RSAModulus);
		System.out.println(RSAExponent);
	}
}
