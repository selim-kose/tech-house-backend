package se.selimkose.techhousespringboot.controller;

import com.stripe.exception.StripeException;
import com.stripe.model.PaymentIntent;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import se.selimkose.techhousespringboot.dto.PaymentInfo;
import se.selimkose.techhousespringboot.dto.Purchase;
import se.selimkose.techhousespringboot.dto.PurchaseResponse;
import se.selimkose.techhousespringboot.service.CheckoutService;
import se.selimkose.techhousespringboot.service.EmailSenderService;
import se.selimkose.techhousespringboot.service.S3Service;

@RestController
@CrossOrigin("https://localhost:4200")
@RequestMapping("/api/checkout")
@AllArgsConstructor
public class CheckoutController {

    CheckoutService checkoutService;
    S3Service s3Service;

    @PostMapping("/purchase")
    public PurchaseResponse placeOrder(@RequestBody Purchase purchase){
        PurchaseResponse purchaseResponse = checkoutService.placeOrder(purchase);
        return purchaseResponse;
    }

    @PostMapping("/payment-intent")
    public ResponseEntity<String> createPaymentIntent(@RequestBody PaymentInfo paymentInfo) throws StripeException{
        PaymentIntent paymentIntent = checkoutService.createPaymentIntent(paymentInfo);
        String paymentStr = paymentIntent.toJson();

        return new ResponseEntity<>(paymentStr, HttpStatus.OK);
    }
}
