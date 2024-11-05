package se.selimkose.techhousespringboot.controller;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import se.selimkose.techhousespringboot.service.S3Service;

@AllArgsConstructor
@RestController
@CrossOrigin("https://localhost:4200")
@RequestMapping("/api/")
public class AWSController {

    private S3Service s3Service;


    @GetMapping("/aws")
    public String listAllBuckets() {
        s3Service.listAllBuckets();
        s3Service.listBucketObjects();
        return ("Hello from AWSController");
    }
}
