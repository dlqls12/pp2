package com.sbs.lyb.pp.util;

import java.math.BigInteger;

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
		if ( object == null ) {
			return "";
		}

		return object.toString();
	}
}
