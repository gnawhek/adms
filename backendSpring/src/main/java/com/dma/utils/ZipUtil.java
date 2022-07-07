package com.dma.utils;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.zip.GZIPInputStream;
import java.util.zip.GZIPOutputStream;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ZipUtil {

    
	private ZipUtil() {}

	public static byte[] compress2(String value) throws Exception {
		ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
		GZIPOutputStream gzipOutStream = new GZIPOutputStream(new BufferedOutputStream(byteArrayOutputStream));
		gzipOutStream.write(value.getBytes());
		gzipOutStream.finish();
		gzipOutStream.close();
		return byteArrayOutputStream.toByteArray();
	}

	public static String decompress2(byte[] value) throws Exception {
		ByteArrayOutputStream outStream = new ByteArrayOutputStream();
		GZIPInputStream gzipInStream = new GZIPInputStream(new BufferedInputStream(new ByteArrayInputStream(value)));
		int size = 0;
		byte[] buffer = new byte[1024];
		while ((size = gzipInStream.read(buffer)) > 0) {
			outStream.write(buffer, 0, size);
		}
		outStream.flush();
		outStream.close();
		return new String(outStream.toByteArray());
	}

	public static byte[] compress(final String str) throws IOException {
		if ((str == null) || (str.length() == 0)) {
		  return null;
		}
		ByteArrayOutputStream obj = new ByteArrayOutputStream();
		GZIPOutputStream gzip = new GZIPOutputStream(obj);
		gzip.write(str.getBytes("UTF-8"));
		gzip.flush();
		gzip.close();
		return obj.toByteArray();
	  }


    public static String decompress(final byte[] compressed) throws IOException {
		final StringBuilder outStr = new StringBuilder();
		if ((compressed == null) || (compressed.length == 0)) {
		  return "";
		}
		if (isCompressed(compressed)) {
		  final GZIPInputStream gis = new GZIPInputStream(new ByteArrayInputStream(compressed));
		  final BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(gis, "UTF-8"));
	
		  String line;
		  while ((line = bufferedReader.readLine()) != null) {
			outStr.append(line);
		  }
		} else {
		  outStr.append(compressed);
		}
		return outStr.toString();
	  }
	
	  public static boolean isCompressed(final byte[] compressed) {
		return (compressed[0] == (byte) (GZIPInputStream.GZIP_MAGIC)) && (compressed[1] == (byte) (GZIPInputStream.GZIP_MAGIC >> 8));
	  }
	
}