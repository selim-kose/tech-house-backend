package se.selimkose.techhousespringboot.service;

import lombok.AllArgsConstructor;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import se.selimkose.techhousespringboot.dao.ProductRepository;
import se.selimkose.techhousespringboot.entity.Address;
import se.selimkose.techhousespringboot.entity.Customer;
import se.selimkose.techhousespringboot.entity.Order;
import se.selimkose.techhousespringboot.entity.OrderItem;

import java.util.Set;

@Service
@AllArgsConstructor
public class EmailSenderServiceImpl implements EmailSenderService {

    JavaMailSender mailSender;
    ProductRepository productRepository;

    @Override
    public void sendEmail(Customer customer, Order order) {
        SimpleMailMessage message = new SimpleMailMessage();

        message.setFrom("selim-kose@live.com");
        message.setTo(customer.getEmail());
        message.setSubject("Tech-House Order Confirmation");

        StringBuilder emailBody = new StringBuilder();

        emailBody.append("Thanks for your order " + customer.getFirstName()+ " " + customer.getLastName() +"!\n\n");
        emailBody.append("Tracking number: " + order.getOrderTrackingNumber() + "\n\n");
        emailBody.append("Your order:\n\n");

        for (OrderItem orderItem : order.getOrderItems()) {
            emailBody.append(orderItem.getQuantity() + " " + productRepository.findById(orderItem.getProductId()).get().getName() + "\n");
        }

        emailBody.append("\n\nShipping address:\n");
        emailBody.append(order.getShippingAddress().getStreet()+"\n"+ order.getShippingAddress().getZipCode()+"\n"+ order.getShippingAddress().getCity());

        message.setText(emailBody.toString());

        mailSender.send(message);

    }
}
