package se.selimkose.techhousespringboot.service;

import com.stripe.exception.StripeException;
import com.stripe.model.PaymentIntent;
import se.selimkose.techhousespringboot.dto.PaymentInfo;
import se.selimkose.techhousespringboot.dto.Purchase;
import se.selimkose.techhousespringboot.dto.PurchaseResponse;

public interface CheckoutService {

    PurchaseResponse placeOrder (Purchase purchase);
    PaymentIntent createPaymentIntent(PaymentInfo paymentInfo) throws StripeException;
}
