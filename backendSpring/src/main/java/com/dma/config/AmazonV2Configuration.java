package com.dma.config;

import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.net.URI;

@Configuration
public class AmazonV2Configuration {

    @Value("${cloud.aws.credentials.access-key:AKIATQ35DAASCPFYX6KE}")
    private String accessKey;

    @Value("${cloud.aws.credentials.secret-key:cT9Kk40fV9bBH3rkdFZN5nRh4nC4TUyCzKPMEtZy}")
    private String secretKey;

    @Value("${cloud.aws.endpoint:dynamodb.ap-northeast-2.amazonaws.com}")
    private String endPoint;

    @Bean
    public DynamoDbClient buildDynamoDbClient(){
        return DynamoDbClient.builder()
                .endpointOverride(URI.create("https://dynamodb.ap-northeast-2.amazonaws.com"))
                // The region is meaningless for local DynamoDb but required for client builder validation
                .region(Region.AP_NORTHEAST_2)
                .credentialsProvider(StaticCredentialsProvider.create(
                        AwsBasicCredentials.create(accessKey, secretKey)))
                .build();
    }
}