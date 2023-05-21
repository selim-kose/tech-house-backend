package se.selimkose.techhousespringboot.service;

import se.selimkose.techhousespringboot.entity.Address;
import se.selimkose.techhousespringboot.entity.Customer;
import se.selimkose.techhousespringboot.entity.Order;
import se.selimkose.techhousespringboot.entity.OrderItem;

import java.util.Set;

public interface EmailSenderService {

    void sendEmail(Customer customer, Order order);
}
