package se.selimkose.techhousespringboot.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;
import org.springframework.web.bind.annotation.CrossOrigin;
import se.selimkose.techhousespringboot.entity.City;

import java.util.List;

//@CrossOrigin("http://localhost:4200")
@RepositoryRestResource
public interface CityRepository extends JpaRepository<City,Integer> {

    List<City> findByCountryCode(@Param("code") String code);
}
