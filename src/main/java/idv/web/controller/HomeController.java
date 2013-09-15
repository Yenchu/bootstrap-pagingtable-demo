package idv.web.controller;

import java.util.LinkedHashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HomeController {

	private static final Logger log = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value={"", "/"})
	public String index() {
		return "home";
	}
	
	@RequestMapping(value="/language/options")
	@ResponseBody
	public Map<String, String> getRoleOptions(HttpServletRequest request) {
		Map<String, String> map = new LinkedHashMap<String, String>();
		map.put("", "");
		map.put(Locale.US.getLanguage(), Locale.US.getDisplayLanguage());
		map.put(Locale.FRANCE.getLanguage(), Locale.FRANCE.getDisplayLanguage());
		map.put(Locale.JAPAN.getLanguage(), Locale.JAPAN.getDisplayLanguage());
		map.put(Locale.CHINESE.getLanguage(), Locale.CHINESE.getDisplayLanguage());
		return map;
	}
}
