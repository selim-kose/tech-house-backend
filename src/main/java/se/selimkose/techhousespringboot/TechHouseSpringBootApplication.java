package se.selimkose.techhousespringboot;

import com.stripe.Stripe;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class TechHouseSpringBootApplication {

    @Value("${stripe.key.secret}")
    String secretKey;


    @Bean
    public String getSecretKey(){
        return secretKey;
    }

    public static void main(String[] args) {
        SpringApplication.run(TechHouseSpringBootApplication.class, args);
    }

}
