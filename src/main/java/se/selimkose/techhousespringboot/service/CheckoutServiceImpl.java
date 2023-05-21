package se.selimkose.techhousespringboot.service;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.PaymentIntent;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;


import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Service;
import se.selimkose.techhousespringboot.dao.CustomerRepository;
import se.selimkose.techhousespringboot.dto.PaymentInfo;
import se.selimkose.techhousespringboot.dto.Purchase;
import se.selimkose.techhousespringboot.dto.PurchaseResponse;
import se.selimkose.techhousespringboot.entity.Customer;
import se.selimkose.techhousespringboot.entity.Order;
import se.selimkose.techhousespringboot.entity.OrderItem;

import java.beans.BeanProperty;
import java.util.*;


@Service
@AllArgsConstructor

public class CheckoutServiceImpl implements CheckoutService {
    CustomerRepository customerRepository;

    @Value("${stripe.key.secret}") String secretKey;

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
    //check if customer exists already in db
    Customer customerInDB = customerRepository.findByEmail(customer.getEmail());
    if(customerInDB != null) {
        //if customer is found in db, assign that customer so that we won't have copies of customers
        customer = customerInDB;
    }

    customer.add(order);

    customerRepository.save(customer);

        return new PurchaseResponse(orderTrackingNumber);
    }

    @Override
    public PaymentIntent createPaymentIntent(PaymentInfo paymentInfo) throws StripeException {
        Stripe.apiKey = secretKey;

        List<String> paymentMethodTypes = new ArrayList<>();
        paymentMethodTypes.add("card");

        Map<String, Object> params = new HashMap<>();
        params.put("amount", paymentInfo.getAmount());
        params.put("currency", paymentInfo.getCurrency());
        params.put("payment_method_types" , paymentMethodTypes);
        params.put("description", "Tech-House purchase");
        params.put("receipt_email", paymentInfo.getReceiptEmail());

        return PaymentIntent.create(params);
    }

    private String generateOrderTackingNumber() {
        return UUID.randomUUID().toString();
    }
}
