package se.selimkose.techhousespringboot.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.rest.core.config.RepositoryRestConfiguration;
import org.springframework.data.rest.webmvc.config.RepositoryRestConfigurer;
import org.springframework.http.HttpMethod;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import se.selimkose.techhousespringboot.entity.*;

@Configuration
public class DataRestConfig implements RepositoryRestConfigurer {

    @Value("${allowed.origins}") private String[] allowedOrigins;

    @Override
    public void configureRepositoryRestConfiguration(RepositoryRestConfiguration config, CorsRegistry cors) {

        //exposing Ids for the classes
        config.exposeIdsFor(Product.class, ProductCategory.class);
        //defining what origins that are allowed to make rest calls
        cors.addMapping(config.getBasePath() + "/**").allowedOrigins(allowedOrigins);

        //list of disabled HTTP methods
        HttpMethod[] unsupportedHttpMethods = {HttpMethod.DELETE, HttpMethod.POST, HttpMethod.PUT, HttpMethod.PATCH};

        disableHttpMethods(Product.class, config, unsupportedHttpMethods);
        disableHttpMethods(ProductCategory.class, config, unsupportedHttpMethods);
        disableHttpMethods(City.class, config, unsupportedHttpMethods);
        disableHttpMethods(Country.class, config, unsupportedHttpMethods);
        disableHttpMethods(Order.class, config, unsupportedHttpMethods);

    }

    private static void disableHttpMethods(Class theClass,RepositoryRestConfiguration config, HttpMethod[] unsupportedHttpMethods) {
        config.getExposureConfiguration()
                .forDomainType(theClass)
                .withItemExposure((metdata, httpMethods) -> httpMethods.disable(unsupportedHttpMethods))
                .withCollectionExposure((metdata, httpMethods) -> httpMethods.disable(unsupportedHttpMethods));
    }
}
