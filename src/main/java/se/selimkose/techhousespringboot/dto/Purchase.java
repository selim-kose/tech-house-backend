package se.selimkose.techhousespringboot.dto;

import lombok.Data;
import se.selimkose.techhousespringboot.entity.Address;
import se.selimkose.techhousespringboot.entity.Customer;
import se.selimkose.techhousespringboot.entity.Order;
import se.selimkose.techhousespringboot.entity.OrderItem;

import java.util.Set;

@Data
public class Purchase {

    private Customer customer;
    private Address shippingAddress;
    private Address billingAddress;
    private Order order;
    private Set<OrderItem> orderItems;
}
