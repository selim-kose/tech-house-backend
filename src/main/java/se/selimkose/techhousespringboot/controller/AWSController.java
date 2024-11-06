package se.selimkose.techhousespringboot.controller;

import lombok.AllArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import se.selimkose.techhousespringboot.service.S3Service;
import java.io.File;
import java.io.IOException;

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

    @PostMapping("/upload")
    public String uploadFile(@RequestParam("file") MultipartFile multipartFile) throws IOException {
        File file = s3Service.convertMultiPartToFile(multipartFile);
        String message = s3Service.uploadFile(multipartFile.getOriginalFilename(), file);
        file.delete();
        return message;
    }

    @GetMapping("/download/{key}")
    public String downloadFile(@PathVariable("key") String key) {
        s3Service.downloadFile(key);
        return "File downloaded successfully";
    }
}
