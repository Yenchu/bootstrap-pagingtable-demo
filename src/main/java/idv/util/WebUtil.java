package idv.util;

import java.util.Enumeration;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class WebUtil {

	private static final Logger log = LoggerFactory.getLogger(WebUtil.class);
	
	public static String getUserAddress(HttpServletRequest request) {
		String userAddress = request.getHeader("X-Forwarded-For");
		if (userAddress == null || userAddress.equals("")) {
			userAddress = request.getRemoteAddr();
		}
		return userAddress;
	}
	
	public static void logParameters(HttpServletRequest request) {
        StringBuilder buffer = new StringBuilder("\n");
        Map<String, String[]> paramMap = request.getParameterMap();
        Iterator<Entry<String, String[]>> ite = paramMap.entrySet().iterator();
        while (ite.hasNext()) {
            Map.Entry<String, String[]> entry = (Map.Entry<String, String[]>) ite.next();
            String key = entry.getKey();
            String[] values = entry.getValue();
            
            buffer.append(key).append("=");
            if (values.length > 1) {
            	buffer.append("[");
	            for (int i = 0; i < values.length; i++) {
	                buffer.append(values[i]);
	                if (i + 1 < values.length) {
	                    buffer.append(",");
	                }
	            }
	            buffer.append("]");
            } else {
            	 buffer.append(values[0]);
            }
            buffer.append(" ");
        }
        log.debug("RequestParametes: {}", buffer.toString());
    }
	
	public static void logHeaders(HttpServletRequest request) {
		StringBuilder buf = new StringBuilder();
		Enumeration<String> enumer = request.getHeaderNames();
		while (enumer.hasMoreElements()) {
			String name = enumer.nextElement();
			buf.append(name).append("=");
			Enumeration<String> enumerVal = request.getHeaders(name);
			while (enumerVal.hasMoreElements()) {
				String value = enumerVal.nextElement();
				buf.append(value).append(",");
			}
			buf.append("\n");
		}
		log.debug("\n{}", buf.toString());
	}
}
