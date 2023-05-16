package se.selimkose.techhousespringboot.dto;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class PurchaseResponse {

    private String orderTrackingNumber;
}
