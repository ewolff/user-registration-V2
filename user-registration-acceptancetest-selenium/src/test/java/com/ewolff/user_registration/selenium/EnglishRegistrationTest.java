package com.ewolff.user_registration.selenium;

import static org.junit.Assert.assertTrue;

import java.util.List;
import java.util.concurrent.TimeUnit;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.htmlunit.HtmlUnitDriver;
import org.springframework.boot.ExitCodeGenerator;
import org.springframework.boot.SpringApplication;
import org.springframework.context.ConfigurableApplicationContext;

import com.ewolff.user_registration.RegistrationApplication;

public class EnglishRegistrationTest {
	private WebDriver driver;
	private String baseUrl;

	@BeforeClass
	public static void startWebApplication() {
		if (!WebApp.running) {
			SpringApplication.run(RegistrationApplication.class);
			WebApp.running=true;
		}
	}

	@Before
	public void setUp() throws Exception {
		baseUrl = "http://localhost:8080/";
		driver = new HtmlUnitDriver();
		driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
	}

	@Test
	public void testRegisterDelete() throws Exception {
		userDoesNotExist();
		registerUserTestCase();
		registerUserAgain();
		userExists();
		deleteUser();
		userDoesNotExist();
	}

	@Test
	public void testInvalidEMail() throws Exception {
		registerUser("HURZ!");
		assertTrue(driver.findElement(By.cssSelector(".alert.alert-error"))
				.getText().matches("^[\\s\\S]*not[\\s\\S]*valid[\\s\\S]*$"));
	}

	public void deleteUser() throws Exception {
		driver.get(baseUrl + "/en");
		driver.findElement(By.name("email")).clear();
		driver.findElement(By.name("email")).sendKeys(
				"eberhard.wolff+en@gmail.com");
		driver.findElement(By.cssSelector("input[type=\"submit\"]")).click();
		driver.findElement(By.cssSelector("input.btn.btn-link")).click();
	}

	public void userDoesNotExist() throws Exception {
		searchUser();
		assertTrue(driver.findElement(By.cssSelector(".container>.container"))
				.getText().matches("^[\\s\\S]*No[\\s\\S]*user[\\s\\S]*$"));

	}

	public void userExists() throws Exception {
		searchUser();
		List<WebElement> divs = driver.findElements(By.cssSelector("div"));
		boolean found = false;
		for (WebElement div : divs) {
			if (div.getText().matches("^[\\s\\S]*Firstname[\\s\\S]*$")) {
				found = true;
			}
		}
		assertTrue(found);
	}

	private void searchUser() {
		driver.get(baseUrl + "/en");
		driver.findElement(By.name("email")).clear();
		driver.findElement(By.name("email")).sendKeys(
				"eberhard.wolff+en@gmail.com");
		driver.findElement(By.cssSelector("input[type=\"submit\"]")).click();
	}

	public void registerUserTestCase() throws Exception {
		registerUser("eberhard.wolff+en@gmail.com");
		assertTrue(isElementPresent(By.cssSelector("input.btn.btn-link")));
	}

	public void registerUserAgain() throws Exception {
		registerUser("eberhard.wolff+en@gmail.com");
		assertTrue(driver.findElement(By.cssSelector(".alert.alert-error"))
				.getText().matches("^[\\s\\S]*already in use[\\s\\S]*$"));
	}

	private void registerUser(String email) {
		driver.get(baseUrl + "/en");
		driver.findElement(By.linkText("Register User")).click();
		driver.findElement(By.id("firstname")).clear();
		driver.findElement(By.id("firstname")).sendKeys("Eberhard");
		driver.findElement(By.id("name")).clear();
		driver.findElement(By.id("name")).sendKeys("Wolff");
		driver.findElement(By.id("email")).clear();
		driver.findElement(By.id("email")).sendKeys(email);
		driver.findElement(By.cssSelector("input[type=\"submit\"]")).click();
	}

	@After
	public void tearDown() throws Exception {
		driver.quit();
	}

	private boolean isElementPresent(By by) {
		try {
			driver.findElement(by);
			return true;
		} catch (NoSuchElementException e) {
			return false;
		}
	}

}
