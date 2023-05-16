package se.selimkose.techhousespringboot.controller;

import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;
import se.selimkose.techhousespringboot.dto.Purchase;
import se.selimkose.techhousespringboot.dto.PurchaseResponse;
import se.selimkose.techhousespringboot.service.CheckoutService;

@RestController
@CrossOrigin("http://localhost:4200")
@RequestMapping("/api/checkout")
@AllArgsConstructor
public class CheckoutController {

    CheckoutService checkoutService;

    @PostMapping("/purchase")
    public PurchaseResponse placeOrder(@RequestBody Purchase purchase){
        PurchaseResponse purchaseResponse = checkoutService.placeOrder(purchase);
        return purchaseResponse;
    }

}
