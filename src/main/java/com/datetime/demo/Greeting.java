package com.datetime.demo;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import lombok.*;

//@RequiredArgsConstructor
@Getter
@Setter
@JsonIgnoreProperties(ignoreUnknown = true)
public class Greeting {

//    @JsonProperty("isSet") for when json variable != java variable
    private final long id;
    private final @NonNull String content;

    public Greeting(long id, String content) {
        this.id = id;
        this.content = content;
    }
}
