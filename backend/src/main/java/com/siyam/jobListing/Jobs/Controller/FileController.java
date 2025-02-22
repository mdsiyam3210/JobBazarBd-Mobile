package com.siyam.jobListing.Jobs.Controller;

import com.siyam.jobListing.Jobs.Model.User;
import com.siyam.jobListing.Jobs.Repository.UserRepository;
import com.siyam.jobListing.Jobs.Service.UserService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

@RestController
@RequestMapping("/api/uploads")
public class FileController {

    private final UserService userService;
    private final UserRepository userRepository;

    @Value("${file.upload-dir}")
    private String uploadDir;

    public FileController(UserService userService, UserRepository userRepository) {
        this.userService = userService;
        this.userRepository = userRepository;
    }

    @PostMapping("/pfp/{userId}")
    public ResponseEntity<String> uploadImage(@RequestParam("file") MultipartFile file, @PathVariable Long userId) {
        try {
            String filePath = saveImage(file);

            userService.updateProfilePicture(userId, filePath);

            return ResponseEntity.ok("Image uploaded successfully: " + filePath);
        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error uploading image");
        }
    }

    private String saveImage(MultipartFile file) throws IOException {
        Path uploadPath = Paths.get(uploadDir);
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        String fileName = file.getOriginalFilename();
        Path filePath = uploadPath.resolve(fileName);
        Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
        return filePath.toString();
    }

    @PostMapping("/pdf/{userId}")
    public ResponseEntity<String> uploadPdf(@RequestParam("file") MultipartFile file, @PathVariable Long userId) {
        try {
            String filePath = savePdf(file);

            userService.updateCvFile(userId, filePath);

            return ResponseEntity.ok("PDF uploaded successfully: " + filePath);
        } catch (IOException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error uploading pdf");
        }
    }

    private String savePdf(MultipartFile file) throws IOException {
        Path uploadPath = Paths.get(uploadDir);
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        String fileName = file.getOriginalFilename();
        Path filePath = uploadPath.resolve(fileName);
        Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
        return filePath.toString();
    }

    @GetMapping("/pdf/{userId}")
    public ResponseEntity<Resource> getCvFile(@PathVariable Long userId) {
        try {
            // Fetch the user
            User user = userRepository.findById(userId)
                    .orElseThrow(() -> new IllegalArgumentException("User not found"));

            // Get the file path of the profile picture
            String cvFile = user.getCvFile();
            if (cvFile == null) {
                return ResponseEntity.notFound().build();
            }

            // Serve the image file
            Path filePath = Paths.get(cvFile);
            Resource resource = new UrlResource(filePath.toUri());
            if (resource.exists()) {
                return ResponseEntity.ok()
                        .contentType(MediaType.parseMediaType(Files.probeContentType(filePath)))
                        .body(resource);
            } else {
                return ResponseEntity.notFound().build();
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @GetMapping("/images/{fileName}")
    public ResponseEntity<Resource> getImage(@PathVariable String fileName) {
        try {
            Path filePath = Paths.get(uploadDir).resolve(fileName);
            Resource resource = new UrlResource(filePath.toUri());

            if (resource.exists()) {
                return ResponseEntity.ok()
                        .contentType(MediaType.parseMediaType(Files.probeContentType(filePath)))
                        .body(resource);
            } else {
                return ResponseEntity.notFound().build();
            }
        } catch (MalformedURLException e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    @GetMapping("/pfp/{userId}")
    public ResponseEntity<Resource> getProfilePicture(@PathVariable Long userId) {
        try {
            // Fetch the user
            User user = userRepository.findById(userId)
                    .orElseThrow(() -> new IllegalArgumentException("User not found"));

            // Get the file path of the profile picture
            String profilePicture = user.getProfilePicture();
            if (profilePicture == null) {
                return ResponseEntity.notFound().build();
            }

            // Serve the image file
            Path filePath = Paths.get(profilePicture);
            Resource resource = new UrlResource(filePath.toUri());
            if (resource.exists()) {
                return ResponseEntity.ok()
                        .contentType(MediaType.parseMediaType(Files.probeContentType(filePath)))
                        .body(resource);
            } else {
                return ResponseEntity.notFound().build();
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }


}
