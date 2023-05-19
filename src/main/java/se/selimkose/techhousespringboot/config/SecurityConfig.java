package se.selimkose.techhousespringboot.config;

import com.okta.spring.boot.oauth.Okta;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

    @Bean
    SecurityFilterChain filterChain(HttpSecurity httpSecurity) throws Exception {

        httpSecurity
                .csrf().disable()
                .authorizeHttpRequests()
                .requestMatchers( "/api/orders/**")
                .authenticated()
                .anyRequest().permitAll().and()
                .oauth2ResourceServer()
                .jwt();

        httpSecurity.cors();

        Okta.configureResourceServer401ResponseBody(httpSecurity);


        return httpSecurity.build();
    }
}
