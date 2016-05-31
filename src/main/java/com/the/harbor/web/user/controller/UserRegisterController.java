package com.the.harbor.web.user.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping("/user")
public class UserRegisterController {

    private static final Logger LOG = Logger.getLogger(UserRegisterController.class);

    @RequestMapping("/toUserRegister.html")
    public ModelAndView toUserRegister(HttpServletRequest request) {
        ModelAndView view = new ModelAndView("user/toUserRegister");
        return view;
    }
    
    @RequestMapping("/toApplyCertficate.html")
    public ModelAndView toApplyCertficate(HttpServletRequest request) {
        ModelAndView view = new ModelAndView("user/toApplyCertficate");
        return view;
    }
    
    @RequestMapping("/userInfo.html")
    public ModelAndView userInfo(HttpServletRequest request) {
        ModelAndView view = new ModelAndView("user/userInfo");
        return view;
    }
    
    @RequestMapping("/memberCenter.html")
    public ModelAndView memberCenter(HttpServletRequest request) {
        ModelAndView view = new ModelAndView("user/memberCenter");
        return view;
    }
    
    @RequestMapping("/userCenter.html")
    public ModelAndView userCenter(HttpServletRequest request) {
        ModelAndView view = new ModelAndView("user/userCenter");
        return view;
    }
    
    @RequestMapping("/editUserInfo.html")
    public ModelAndView editUserInfo(HttpServletRequest request) {
        ModelAndView view = new ModelAndView("user/editUserInfo");
        return view;
    }

}
