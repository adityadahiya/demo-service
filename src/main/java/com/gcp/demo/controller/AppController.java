package com.gcp.demo.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AppController {

    @GetMapping("/status")
    public ResponseEntity<String> getStatus(){
        return ResponseEntity.ok("Application is working");
    }
}
