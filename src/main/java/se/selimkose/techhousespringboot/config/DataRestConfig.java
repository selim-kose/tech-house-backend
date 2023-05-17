package se.selimkose.techhousespringboot.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.rest.core.config.RepositoryRestConfiguration;
import org.springframework.data.rest.webmvc.config.RepositoryRestConfigurer;
import org.springframework.http.HttpMethod;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import se.selimkose.techhousespringboot.entity.City;
import se.selimkose.techhousespringboot.entity.Country;
import se.selimkose.techhousespringboot.entity.Product;
import se.selimkose.techhousespringboot.entity.ProductCategory;

@Configuration
public class DataRestConfig implements RepositoryRestConfigurer {

    @Value("${allowed.origins}")
    private String[] allowedOrigins;

    @Override
    public void configureRepositoryRestConfiguration(RepositoryRestConfiguration config, CorsRegistry cors) {

        config.exposeIdsFor(Product.class, ProductCategory.class);
        cors.addMapping(config.getBasePath() + "/**").allowedOrigins(allowedOrigins);

        HttpMethod[] unsupportedHttpMethods = {HttpMethod.DELETE, HttpMethod.POST, HttpMethod.PUT, HttpMethod.PATCH};

        disableHttpMethods(Product.class, config, unsupportedHttpMethods);
        disableHttpMethods(ProductCategory.class, config, unsupportedHttpMethods);
        disableHttpMethods(City.class, config, unsupportedHttpMethods);
        disableHttpMethods(Country.class, config, unsupportedHttpMethods);
    }

    private static void disableHttpMethods(Class theClass,RepositoryRestConfiguration config, HttpMethod[] unsupportedHttpMethods) {
        config.getExposureConfiguration()
                .forDomainType(theClass)
                .withItemExposure((metdata, httpMethods) -> httpMethods.disable(unsupportedHttpMethods))
                .withCollectionExposure((metdata, httpMethods) -> httpMethods.disable(unsupportedHttpMethods));
    }
}
