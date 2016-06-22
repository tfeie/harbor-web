package com.the.harbor.web.be.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.the.harbor.web.go.controller.GoController;

@RestController
@RequestMapping("/be")
public class BeController {

	private static final Logger LOG = Logger.getLogger(GoController.class);

	@RequestMapping("/index.html")
	public ModelAndView index(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("be/index");
		return view;
	}

	@RequestMapping("/detail.html")
	public ModelAndView detail(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("be/detail");
		return view;
	}
	
	@RequestMapping("/publishbe.html")
	public ModelAndView publishbe(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("be/publishbe");
		return view;
	}
	
	@RequestMapping("/mybe.html")
	public ModelAndView mybe(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("be/mybe");
		return view;
	}
	
	@RequestMapping("/mytimeline.html")
	public ModelAndView mytimeline(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("be/mytimeline");
		return view;
	}

}
