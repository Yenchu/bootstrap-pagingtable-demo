package idv.web.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/pagingtable")
public class PagingTableController {

	private static final Logger log = LoggerFactory.getLogger(PagingTableController.class);
	
	@RequestMapping(value={"", "/"})
	public String home() {
		return "pagingtable/remoteLoad";
	}
	
	@RequestMapping(value="/remoteLoad")
	public String remoteLoad() {
		return "pagingtable/remoteLoad";
	}
	
	@RequestMapping(value="/formEdit")
	public String formEdit() {
		return "pagingtable/formEdit";
	}
	
	@RequestMapping(value="/customColumn")
	public String customColumn() {
		return "pagingtable/customColumn";
	}
	
	@RequestMapping(value="/features")
	public String features() {
		return "pagingtable/features";
	}
}
