package com.datetime.demo;

import org.springframework.web.client.RestTemplate;

public class RestRetriever {
    public static Greeting getGreeting(String name) {
        final String uri = String.format("http://localhost:8082/greeting?name=%s", name);

        RestTemplate restTemplate = new RestTemplate();
        Greeting greeting = restTemplate.getForObject(uri, Greeting.class);

        System.out.println(greeting.getContent());
        return greeting;
    }
}
