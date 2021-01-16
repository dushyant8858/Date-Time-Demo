package com.datetime.demo;

import org.springframework.web.client.RestTemplate;

public class RestRetriever {
    public static Greeting getGreeting() {
        final String uri = "http://localhost:8082/greeting";

        RestTemplate restTemplate = new RestTemplate();
        Greeting greeting = restTemplate.getForObject(uri, Greeting.class);

        System.out.println(greeting.getContent());
        return greeting;
    }
}
