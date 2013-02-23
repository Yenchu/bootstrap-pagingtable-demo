package idv.web.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

	private static final Logger log = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value="/")
	public String index() {
		return "home";
	}
	
	@RequestMapping(value = "/home")
	public String home(HttpServletRequest request) {
		return "home";
	}
	
	@RequestMapping(value = "/test")
	public String test(HttpServletRequest request) {
		return "test";
	}
}
