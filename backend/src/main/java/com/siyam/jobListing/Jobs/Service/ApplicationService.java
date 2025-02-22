package com.siyam.jobListing.Jobs.Service;

import com.siyam.jobListing.Jobs.Model.Application;
import com.siyam.jobListing.Jobs.Model.CoverLetter;
import com.siyam.jobListing.Jobs.Model.Job;
import com.siyam.jobListing.Jobs.Model.User;
import com.siyam.jobListing.Jobs.Repository.ApplicationRepository;
import com.siyam.jobListing.Jobs.Repository.JobRepository;
import com.siyam.jobListing.Jobs.Repository.UserRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import javax.swing.text.html.Option;
import java.util.List;
import java.util.Optional;

@Service
public class ApplicationService {
    public final ApplicationRepository applicationRepository;
    public final JobRepository jobRepository;
    public final UserRepository userRepository;

    public ApplicationService(ApplicationRepository applicationRepository, JobRepository jobRepository, UserRepository userRepository) {
        this.applicationRepository = applicationRepository;
        this.jobRepository = jobRepository;
        this.userRepository = userRepository;
    }

    public ResponseEntity<Application> applyForJob(Integer jobId, Long userId, CoverLetter coverLetter, Application.Status status) {
        Job job = jobRepository.findById(jobId).orElseThrow(() -> new RuntimeException("Job not found"));
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));

        Optional<User> employer = userRepository.findByUsername(user.getUsername());
        if (!employer.get().getRole().equals(User.Role.USER)) {
            throw new IllegalArgumentException("The user must be an Employee to apply for a job listing");
        }

        Optional<Application> existingApplication = applicationRepository.findByApplicantAndJob(user, job);
        if (existingApplication.isPresent()) {
            throw new IllegalArgumentException("You have already applied for this job");
        }
        else {
            Application application = new Application();
            application.setJob(job);
            application.setApplicant(user);
            application.setCoverLetter(coverLetter);
            application.setStatus(status);
            applicationRepository.save(application);
            return ResponseEntity.ok(application);
        }
    }

    public List<Application> getApplicationsForJob(Integer jobId) {
       Job job = jobRepository.findById(jobId).orElseThrow(() -> new RuntimeException("Job not found"));
       return applicationRepository.findByJob(job);
    }

    public List<Application> getApplicationsByUser(Long userId) {
        User user = userRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));
        return applicationRepository.findByApplicant(user);
    }

    public ResponseEntity<Application> updateApplicationStatus(Long id, Application application) {

        Optional<Application> existingApplication = applicationRepository.findById(Math.toIntExact(id));
        if (existingApplication.isPresent()) {
            Application updatedApplication = existingApplication.get();
            updatedApplication.setStatus(application.getStatus());
            applicationRepository.save(updatedApplication);
            return ResponseEntity.ok(updatedApplication);
        }

        return null;
    }

    public ResponseEntity<String> deleteApplication(Long id) {
        Optional<Application> existingApplication = applicationRepository.findById(Math.toIntExact(id));
        if (existingApplication.isPresent()) {
            applicationRepository.deleteById(Math.toIntExact(id));
            return ResponseEntity.ok("Application deleted successfully");
        }
        return new ResponseEntity<>("Application not found", HttpStatus.NOT_FOUND);
    }

    public List<Application> getAllApplications() {
        return applicationRepository.findAll();
    }
}
