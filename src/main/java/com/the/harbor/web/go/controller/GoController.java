package com.the.harbor.web.go.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping("/go")
public class GoController {

	private static final Logger LOG = Logger.getLogger(GoController.class);

	@RequestMapping("/toConfirm.html")
	public ModelAndView toUserRegister(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/confirm");
		return view;
	}

	@RequestMapping("/toOrder.html")
	public ModelAndView order(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/order");
		return view;
	}

	@RequestMapping("/toAppointment.html")
	public ModelAndView toAppointment(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/appointment");
		return view;
	}
	
	@RequestMapping("/toPay.html")
	public ModelAndView toPay(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/pay");
		return view;
	}

}
