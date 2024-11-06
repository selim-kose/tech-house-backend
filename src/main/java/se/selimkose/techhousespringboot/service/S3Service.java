package se.selimkose.techhousespringboot.service;

import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.*;
import software.amazon.awssdk.services.s3.paginators.ListObjectsV2Iterable;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

@AllArgsConstructor
@Service
public class S3Service {

    S3Client s3Client;

    @Value("${aws.s3.bucket}")
    private String bucketName;

    public void listAllBuckets() {
        ListBucketsResponse response = s3Client.listBuckets();
        List<Bucket> bucketList = response.buckets();
        for (Bucket bucket : bucketList) {
            System.out.println("Bucket name " + bucket.name());
        }
    }

    public void getObject(String key) {
        s3Client.getObject(builder -> builder.bucket(bucketName).key(key));
    }

    public void listBucketObjects() {
        try {
            ListObjectsV2Request listReq = ListObjectsV2Request.builder()
                    .bucket(bucketName)
                    .maxKeys(1)
                    .build();

            ListObjectsV2Iterable listRes = s3Client.listObjectsV2Paginator(listReq);
            listRes.stream()
                    .flatMap(r -> r.contents().stream())
                    .forEach(content -> System.out.println(" Key: " + content.key() + " size = " + content.size()));

        } catch (S3Exception e) {
            System.err.println(e.awsErrorDetails().errorMessage());
            System.exit(1);
        }
    }

    public String uploadFile(String key,File file) {
        try {
            s3Client.putObject(PutObjectRequest.builder()
                            .bucket(bucketName)
                            .key(key)
                            .build(),
                    RequestBody.fromFile(file));

            return "File uploaded successfully!";
        } catch (S3Exception e) {
            throw new RuntimeException("Error uploading file to S3: " + e.getMessage(), e);
        }
    }

    public File convertMultiPartToFile(MultipartFile file) throws IOException {
        File convFile = new File(file.getOriginalFilename());
        try (FileOutputStream fos = new FileOutputStream(convFile)) {
            fos.write(file.getBytes());
        }
        return convFile;
    }

    public File downloadFile(String key) {
        try {
            File downloadFile = Paths.get("downloaded-" + key).toFile();
            s3Client.getObject(GetObjectRequest.builder()
                    .bucket(bucketName)
                    .key(key)
                    .build(), downloadFile.toPath());
            return downloadFile;
        } catch (S3Exception e) {
            throw new RuntimeException("Error downloading file from S3: " + e.getMessage(), e);
        }
    }
}
