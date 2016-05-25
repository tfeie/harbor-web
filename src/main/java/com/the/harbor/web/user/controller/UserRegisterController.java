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

}
