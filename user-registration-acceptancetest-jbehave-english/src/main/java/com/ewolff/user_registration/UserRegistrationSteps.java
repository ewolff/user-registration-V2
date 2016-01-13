package com.ewolff.user_registration;

import static org.junit.Assert.*;

import org.jbehave.core.annotations.BeforeStory;
import org.jbehave.core.annotations.Given;
import org.jbehave.core.annotations.Then;
import org.jbehave.core.annotations.When;
import org.jbehave.core.embedder.Embedder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.AutowiredAnnotationBeanPostProcessor;
import org.springframework.boot.SpringApplication;

import com.ewolff.user_registration.domain.User;
import com.ewolff.user_registration.service.RegistrationService;

public class UserRegistrationSteps extends Embedder {

	@Autowired
	RegistrationService registrationService;

	private User user;
	private boolean error = false;

	private User anotherUser;

	private boolean anotherUserRegistered = false;

	public UserRegistrationSteps() {
		super();
		SpringApplication application = new SpringApplication(
				RegistrationApplication.class);
		application.setWebEnvironment(false);
		AutowiredAnnotationBeanPostProcessor autowiredAnnotationBeanPostProcessor = new AutowiredAnnotationBeanPostProcessor();
		autowiredAnnotationBeanPostProcessor.setBeanFactory(application.run()
				.getBeanFactory());
		autowiredAnnotationBeanPostProcessor.processInjection(this);
	}

	@BeforeStory
	public void cleanUp() {
		registrationService.clean();
		error = false;
		anotherUserRegistered = false;
	}

	@Given("a new user with email $email firstname $firstname name $name")
	public void givenUser(String email, String firstname, String name) {
		user = new User(firstname, name, email);
	}

	@Given("another user with email $email firstname $firstname Name $name")
	public void givenAnotherUser(String email, String firstname, String name) {
		anotherUser = new User(firstname, name, email);
	}

	@When("the other user registers")
	public void registerAnotherUser() {
		try {
			anotherUserRegistered = registrationService
					.register(anotherUser);
		} catch (IllegalArgumentException ex) {
			error = true;
		}
	}

	@When("the user registers")
	public void registerUser() {
		try {
			registrationService.register(user);
		} catch (IllegalArgumentException ex) {
			error = true;
		}
	}

	@When("the user is deleted")
	public void deleteUser() {
		registrationService.unregister(user.getEmail());
	}

	@Then("a customer with email $email should exist")
	public void exists(String email) {
		assertNotNull(registrationService.getByEMail(email));
	}

	@Then("no customer with email $email should exist")
	public void doesNotExist(String email) {
		assertNull(registrationService.getByEMail(email));
	}

	@Then("no error should be reported")
	public void noError() {
		assertFalse(error);
	}

	@Then("an error should be reported")
	public void error() {
		assertTrue(error);
	}

	@Then("the registration of the other user should fail")
	public void otherRegistrationShouldFail() {
		assertFalse(anotherUserRegistered);
	}

}
