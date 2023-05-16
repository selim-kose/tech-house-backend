package se.selimkose.techhousespringboot.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import se.selimkose.techhousespringboot.entity.Customer;

public interface CustomerRepository extends JpaRepository<Customer,Long> {


}
