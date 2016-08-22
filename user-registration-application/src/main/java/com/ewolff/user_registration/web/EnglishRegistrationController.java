package com.ewolff.user_registration.web;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ewolff.user_registration.domain.User;
import com.ewolff.user_registration.service.RegistrationService;

@Controller
public class EnglishRegistrationController {

	private Log log = LogFactory.getLog(EnglishRegistrationController.class);

	@Autowired
	private EnglishRegistrationController(RegistrationService registrationService) {
		this.registrationService = registrationService;
	}

	private RegistrationService registrationService;

	@RequestMapping(value = "/en", method = RequestMethod.GET)
	public String homepage_en() {
		return "index_en";
	}
	
	@RequestMapping(value = "/user_en", method = RequestMethod.GET)
	public ModelAndView createForm() {
		return new ModelAndView("user/form_en", "user", new User("", "", ""));
	}

	@RequestMapping(value = "/usersearch_en", method = RequestMethod.GET)
	public ModelAndView search(@RequestParam("email") String email) {
		User user = registrationService.getByEMail(email);
		if (user != null) {
			return new ModelAndView("user/display_en", "user", user);
		} else {
			return new ModelAndView("user/not-found_en");
		}
	}

	@RequestMapping(value = "/user_en", method = RequestMethod.POST)
	public ModelAndView create(@ModelAttribute User user,
			BindingResult bindingResult, RedirectAttributes redirect) {
		if (!registrationService.validEMailAdress(user.getEmail())) {
			log.info(String.format("email=%s not valid", user.getEmail()));
			bindingResult.addError(new FieldError("user", "email",
					"email adress not valid"));
		} else {
			boolean registrationResult = registrationService.register(user);
			if (!registrationResult) {
				log.info(String
						.format("email=%s could not be registered - email adress already in use?",
								user.getEmail()));
				bindingResult
						.addError(new FieldError("user", "email",
								"User could not be registered - email adress already in use?"));
			}
		}
		if (bindingResult.hasErrors()) {
			log.info(String.format(
					"email=%s had errors - display form again",
					user.getEmail()));
			return new ModelAndView("user/form_en", "user", user);
		} else {
			return new ModelAndView("user/display_en", "user", user);
		}
	}

	@RequestMapping(value = "/userdelete_en", method = RequestMethod.POST)
	public String delete(@RequestParam("email") String email) {
		registrationService.unregister(email);
		return "index_en";
	}

}
