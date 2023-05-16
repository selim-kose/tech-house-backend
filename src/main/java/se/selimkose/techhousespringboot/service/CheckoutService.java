package se.selimkose.techhousespringboot.service;

import se.selimkose.techhousespringboot.dto.Purchase;
import se.selimkose.techhousespringboot.dto.PurchaseResponse;

public interface CheckoutService {

    PurchaseResponse placeOrder (Purchase purchase);
}
