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
	public ModelAndView toConfirm(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/confirm");
		return view;
	}

	@RequestMapping("/toOrder.html")
	public ModelAndView toOrder(HttpServletRequest request) {
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
	
	@RequestMapping("/publishGo.html")
	public ModelAndView publishGo(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/publishgo");
		return view;
	}
	
	@RequestMapping("/toFeedback.html")
	public ModelAndView toFeedback(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/feedback");
		return view;
	}
	
	@RequestMapping("/confirmlist.html")
	public ModelAndView confirmlist(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/confirmlist");
		return view;
	}
	
	@RequestMapping("/godetail.html")
	public ModelAndView godetail(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/godetail");
		return view;
	}

	
	@RequestMapping("/groupindex.html")
	public ModelAndView groupindex(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/groupindex");
		return view;
	}
	
	@RequestMapping("/oneononeindex.html")
	public ModelAndView oneononeindex(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/oneononeindex");
		return view;
	}
	
	@RequestMapping("/comments.html")
	public ModelAndView comments(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/comments");
		return view;
	}
	
	@RequestMapping("/invite.html")
	public ModelAndView invite(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/invite");
		return view;
	}
	
	@RequestMapping("/invite2.html")
	public ModelAndView invite2(HttpServletRequest request) {
		ModelAndView view = new ModelAndView("go/invite2");
		return view;
	}
}
