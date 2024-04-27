package com.example.pyroscopedemo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.Scheduled;

import io.pyroscope.javaagent.PyroscopeAgent;
import io.pyroscope.javaagent.config.Config;
import jakarta.annotation.PostConstruct;
import io.pyroscope.javaagent.EventType;
import io.pyroscope.http.Format;

@SpringBootApplication
public class PyroscopeDemoApplication {

  public static void main(String[] args) {
    SpringApplication.run(PyroscopeDemoApplication.class, args);
  }

  @Scheduled(fixedRate = 5000)
  void someMethod() throws InterruptedException {
    Thread.sleep(5000);

    System.out.println("Hello from someMethod");

  }

  @PostConstruct
  public void init() {

    PyroscopeAgent.start(
        new Config.Builder()
            .setApplicationName("demo-app")
            .setProfilingEvent(EventType.ITIMER)
            .setFormat(Format.JFR)
            .setServerAddress("http://pyroscope:4040")
            // Optionally, if authentication is enabled, specify the API key.
            .setBasicAuthUser("admin")
            .setBasicAuthPassword("admin")
            // Optionally, if you'd like to set allocation threshold to register events, in
            // bytes. '0' registers all events
            // .setProfilingAlloc("0")
            .build());
  }

}
