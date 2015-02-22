package idv.config;

import idv.web.interceptor.AppHandlerInterceptor;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.MethodParameter;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.bind.support.WebDataBinderFactory;
import org.springframework.web.context.request.NativeWebRequest;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.method.support.ModelAndViewContainer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.mvc.method.annotation.ServletWebArgumentResolverAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.UrlBasedViewResolver;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;

import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.databind.ObjectMapper;

@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "idv.web.controller")
public class WebConfig extends WebMvcConfigurerAdapter {
	
	private static final Logger log = LoggerFactory.getLogger(WebConfig.class);
	
	@Override
	public void addArgumentResolvers(List<HandlerMethodArgumentResolver> argumentResolvers) {
		/*PageableArgumentResolver resolver = new PageableArgumentResolver();
		resolver.setFallbackPagable(new PageRequest(1, 10));
		argumentResolvers.add(new ServletWebArgumentResolverAdapter(resolver));*/
		argumentResolvers.add(new PageableHandlerMethodArgumentResolver());
	}
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new AppHandlerInterceptor());
	}
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/public/**").addResourceLocations("/public/");
	}
	
	/*@Override
	public void configureMessageConverters(List<HttpMessageConverter<?>> converters) {
		ObjectMapper objectMapper = new ObjectMapper();
		objectMapper.setSerializationInclusion(Include.NON_NULL);
		
		MappingJackson2HttpMessageConverter converter = new MappingJackson2HttpMessageConverter();
		converter.setObjectMapper(objectMapper);
		converters.add(converter);
		
		super.configureMessageConverters(converters);
	}*/

	@Bean
	public TilesConfigurer tilesConfigurer() {
		TilesConfigurer configurer = new TilesConfigurer();
		configurer.setDefinitions(new String[] {
			"/WEB-INF/tiles/tiles.xml"				
		});
		configurer.setCheckRefresh(true);
		return configurer;
	}
	
	@Bean
	public UrlBasedViewResolver tilesViewResolver() {
		UrlBasedViewResolver viewResolver = new UrlBasedViewResolver();
		viewResolver.setViewClass(TilesView.class);
		viewResolver.setOrder(0);
		return viewResolver;
	}

	@Bean
    public InternalResourceViewResolver jspViewResolver() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setPrefix("/WEB-INF/views/");
        viewResolver.setSuffix(".jsp");
        viewResolver.setOrder(1);
        return viewResolver;
    }
	
	private static class PageableHandlerMethodArgumentResolver implements HandlerMethodArgumentResolver {

		//@Override
		public boolean supportsParameter(MethodParameter parameter) {
			return Pageable.class.isAssignableFrom(parameter.getParameterType());
		}

		//@Override
		public Object resolveArgument(MethodParameter parameter, ModelAndViewContainer modelAndViewContainer, NativeWebRequest webRequest,
				WebDataBinderFactory binderFactory) throws Exception {
			String pageStr = webRequest.getParameter("page");
			if (pageStr == null || pageStr.equals("")) {
				return null;
			}
			
			int page = 0;
			try {
				page = Integer.parseInt(pageStr);
			} catch (Exception e) {
				log.warn(e.getMessage(), e);
			}
			
			int pageSize = 10;
			String pageSizeStr = webRequest.getParameter("pageSize");
			if (pageSizeStr != null && !pageSizeStr.equals("")) {
				try {
					pageSize = Integer.parseInt(pageSizeStr);
				} catch (Exception e) {
					log.warn(e.getMessage(), e);
				}
			}
			pageSize = (pageSize > 0 ? pageSize : 10);
			
			Pageable pageable = null;
			String sortCol = webRequest.getParameter("sort");
			if (sortCol != null && !sortCol.equals("")) {
				String sortColDir = webRequest.getParameter("sortDir");
				Sort.Direction sortDir = (sortColDir != null && !sortColDir.equals("") ? Sort.Direction.fromString(sortColDir) : Sort.Direction.ASC);
				Sort.Order sortOrder = new Sort.Order(sortDir, sortCol);
				Sort sort = new Sort(sortOrder);
				pageable = new PageRequest(page, pageSize, sort);
			} else {
				pageable = new PageRequest(page, pageSize);
			}
			return pageable;
		}
	}
}
