package com.google;

import com.google.appengine.repackaged.com.google.common.collect.Lists;
import com.google.auth.oauth2.GoogleCredentials;

//Imports the Google Cloud client library

import com.google.cloud.vision.v1.AnnotateImageRequest;
import com.google.cloud.vision.v1.AnnotateImageResponse;
import com.google.cloud.vision.v1.BatchAnnotateImagesResponse;
import com.google.cloud.vision.v1.EntityAnnotation;
import com.google.cloud.vision.v1.Feature;
import com.google.cloud.vision.v1.Feature.Type;
import com.google.cloud.vision.v1.Image;
import com.google.cloud.vision.v1.ImageAnnotatorClient;
import com.google.protobuf.ByteString;

import io.grpc.Context.Storage;

import java.io.FileInputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

public class QuickstartSample {
public static void sample() throws Exception {    
	
	System.out.println("Reached here!!!!!!!!!!");
 // Initialize client that will be used to send requests. This client only needs to be created
 // once, and can be reused for multiple requests. After completing all of your requests, call
 // the "close" method on the client to safely clean up any remaining background resources.
 try (ImageAnnotatorClient vision = ImageAnnotatorClient.create()) {
	 
	 System.out.println("Inside try Reached here!!!!!!!!!!");

   // The path to the image file to annotate
   String fileName = "/Users/anuparmar/Desktop/Landmark.png";

   // Reads the image file into memory
   Path path = Paths.get(fileName);
   byte[] data = Files.readAllBytes(path);
   ByteString imgBytes = ByteString.copyFrom(data);

   // Builds the image annotation request
   List<AnnotateImageRequest> requests = new ArrayList<>();
   Image img = Image.newBuilder().setContent(imgBytes).build();
   Feature feat = Feature.newBuilder().setType(Type.LABEL_DETECTION).build();
   AnnotateImageRequest request =
       AnnotateImageRequest.newBuilder().addFeatures(feat).setImage(img).build();
   requests.add(request);

   // Performs label detection on the image file
   BatchAnnotateImagesResponse response = vision.batchAnnotateImages(requests);
   List<AnnotateImageResponse> responses = response.getResponsesList();

   for (AnnotateImageResponse res : responses) {
     if (res.hasError()) {
       System.out.format("Error: %s%n", res.getError().getMessage());
       return;
     }

     for (EntityAnnotation annotation : res.getLabelAnnotationsList()) {
       annotation
           .getAllFields()
           .forEach((k, v) -> System.out.format("%s : %s%n", k, v.toString()));
     }
   }
 }
}
}
