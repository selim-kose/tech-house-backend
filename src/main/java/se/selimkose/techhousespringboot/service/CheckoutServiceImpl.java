package se.selimkose.techhousespringboot.service;

import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import se.selimkose.techhousespringboot.dao.CustomerRepository;
import se.selimkose.techhousespringboot.dto.Purchase;
import se.selimkose.techhousespringboot.dto.PurchaseResponse;
import se.selimkose.techhousespringboot.entity.Customer;
import se.selimkose.techhousespringboot.entity.Order;
import se.selimkose.techhousespringboot.entity.OrderItem;

import java.util.Set;
import java.util.UUID;

@Service
@AllArgsConstructor
public class CheckoutServiceImpl implements CheckoutService {
    CustomerRepository customerRepository;
    @Override
    @Transactional
    public PurchaseResponse placeOrder(Purchase purchase) {
    Order order = purchase.getOrder();

    String orderTrackingNumber = generateOrderTackingNumber();
    order.setOrderTrackingNumber(orderTrackingNumber);

    Set<OrderItem> orderItems = purchase.getOrderItems();
    orderItems.forEach(item -> order.add(item));

    order.setBillingAddress(purchase.getBillingAddress());
    order.setShippingAddress(purchase.getShippingAddress());

    Customer customer = purchase.getCustomer();
    customer.add(order);

    customerRepository.save(customer);

        return new PurchaseResponse(orderTrackingNumber);
    }

    private String generateOrderTackingNumber() {
        return UUID.randomUUID().toString();
    }
}
