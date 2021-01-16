package com.datetime.demo;

import java.util.concurrent.atomic.AtomicLong;
import org.springframework.web.bind.annotation.*;

@RestController
public class DateTimeController {

//    These paths are case-sensitive it appears
    @RequestMapping(value = "/currentdatetime", method = RequestMethod.GET)
    public String currentDate() {
        return java.time.LocalDateTime.now().toString();
    }
}