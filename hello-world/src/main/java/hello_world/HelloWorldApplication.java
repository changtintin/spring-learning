package hello_world;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

// @SpringBootApplication: 標注主程序的類別
@SpringBootApplication
public class HelloWorldApplication {

	public static void main(String[] args) {
		// Spring 應用啟動
		SpringApplication.run(HelloWorldApplication.class, args);
	}

}
