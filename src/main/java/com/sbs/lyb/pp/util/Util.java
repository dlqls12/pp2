package com.sbs.lyb.pp.util;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.ExecutionException;

import org.springframework.web.multipart.MultipartFile;

import com.google.common.cache.LoadingCache;
import com.sbs.lyb.pp.dto.Article;
import com.sbs.lyb.pp.dto.File;

public class Util {

	public static int getAsInt(Object object) {
		if (object instanceof BigInteger) {
			return ((BigInteger) object).intValue();
		} else if (object instanceof Long) {
			return (int) object;
		} else if (object instanceof Integer) {
			return (int) object;
		} else if (object instanceof String) {
			return Integer.parseInt((String) object);
		}

		return -1;
	}

	public static String getAsStr(Object object) {
		if (object == null) {
			return "";
		}

		return object.toString();
	}

	public static String numberGen(int len, int dupCd) {

		Random rand = new Random();
		String numStr = ""; // 난수가 저장될 변수

		for (int i = 0; i < len; i++) {

			// 0~9 까지 난수 생성
			String ran = Integer.toString(rand.nextInt(10));

			if (dupCd == 1) {
				// 중복 허용시 numStr에 append
				numStr += ran;
			} else if (dupCd == 2) {
				// 중복을 허용하지 않을시 중복된 값이 있는지 검사한다
				if (!numStr.contains(ran)) {
					// 중복된 값이 없으면 numStr에 append
					numStr += ran;
				} else {
					// 생성된 난수가 중복되면 루틴을 다시 실행한다
					i -= 1;
				}
			}
		}
		return numStr;
	}
	
	public static String getDateStrLater(int seconds) {
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		String dateStr = format1.format(System.currentTimeMillis() + seconds * 1000);

		return dateStr;
	}

	public static Map<String, Object> getNewMapOf(Map<String, Object> oldMap, String... keys) {
		Map<String, Object> newMap = new HashMap<>();

		for (String key : keys) {
			newMap.put(key, oldMap.get(key));
		}

		return newMap;
	}
	
	public static <T extends Object> T getCacheData(LoadingCache cache, int key) {
		try {
			return (T) cache.get(key);
		} catch (ExecutionException e) {
			return null;
		}
	}
	
	public static String getFileExtTypeCodeFromFileName(String fileName) {
		String ext = getFileExtFromFileName(fileName).toLowerCase();

		switch (ext) {
		case "jpeg":
		case "jpg":
		case "gif":
		case "png":
			return "img";
		case "mp4":
		case "avi":
		case "mov":
			return "video";
		case "mp3":
			return "audio";
		}

		return "etc";
	}

	public static String getFileExtType2CodeFromFileName(String fileName) {
		String ext = getFileExtFromFileName(fileName).toLowerCase();

		switch (ext) {
		case "jpeg":
		case "jpg":
			return "jpg";
		case "gif":
			return ext;
		case "png":
			return ext;
		case "mp4":
			return ext;
		case "mov":
			return ext;
		case "avi":
			return ext;
		case "mp3":
			return ext;
		}

		return "etc";
	}

	public static String getFileExtFromFileName(String fileName) {
		int pos = fileName.lastIndexOf(".");
		String ext = fileName.substring(pos + 1);

		return ext;
	}
	
	public static byte[] getFileBytesFromMultipartFile(MultipartFile multipartFile) {
		try {
			return getFileBytes(multipartFile.getInputStream());
		} catch (IOException e) {
			e.printStackTrace();
		}

		return null;
	}
	
	public static byte[] getFileBytes(InputStream fis) {
		byte[] returnValue = null;

		ByteArrayOutputStream baos = null;

		try {
			baos = new ByteArrayOutputStream();

			byte[] buf = new byte[1024];
			int read = 0;

			while ((read = fis.read(buf, 0, buf.length)) != -1) {
				baos.write(buf, 0, read);
			}

			returnValue = baos.toByteArray();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (baos != null) {
				try {
					baos.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

		return returnValue;
	}

	public static void putExtraVal(Object obj, String key, Object value) {
		Class cls = obj.getClass();

		try {
			Method getExtraMethod = cls.getDeclaredMethod("getExtra");
			Map<String, Object> extra = (Map<String, Object>) getExtraMethod.invoke(obj);

			if (extra == null) {
				extra = new HashMap<>();
				extra.put(key, value);

				Method setExtraMethod = cls.getDeclaredMethod("setExtra", Map.class);
				setExtraMethod.invoke(obj, extra);
			} else {
				extra.put(key, value);
			}
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
