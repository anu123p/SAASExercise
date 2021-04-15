package com.google;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.cloud.vision.v1.AnnotateImageRequest;
import com.google.cloud.vision.v1.AnnotateImageResponse;
import com.google.cloud.vision.v1.BatchAnnotateImagesResponse;
import com.google.cloud.vision.v1.EntityAnnotation;
import com.google.cloud.vision.v1.Feature;
import com.google.cloud.vision.v1.Image;
import com.google.cloud.vision.v1.ImageAnnotatorClient;
import com.google.cloud.vision.v1.Feature.Type;
import com.google.protobuf.ByteString;

@WebServlet(
    name = "HelloAppEngine",
    urlPatterns = {"/hello"}
)
public class HelloAppEngine extends HttpServlet {

  @Override
  public void doGet(HttpServletRequest request, HttpServletResponse response) 
      throws IOException {
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
		   AnnotateImageRequest request1 =
		       AnnotateImageRequest.newBuilder().addFeatures(feat).setImage(img).build();
		   requests.add(request1);

		   // Performs label detection on the image file
		   BatchAnnotateImagesResponse response1 = vision.batchAnnotateImages(requests);
		   List<AnnotateImageResponse> responses = response1.getResponsesList();

		   for (AnnotateImageResponse res : responses) {
		     if (res.hasError()) {
		       System.out.format("Error: %s%n", res.getError().getMessage());
		       return;
		     }

		     for (EntityAnnotation annotation : res.getLabelAnnotationsList()) {
		       annotation
		           .getAllFields()
		           .forEach((k, v) -> {
					try {
						if(k.equals("google.cloud.vision.v1.EntityAnnotation.description"))
						{
						response.getWriter().println( v.toString());
						response.getWriter().println();
						}
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				});
		       
		       //response.getWriter().print(k + v.toString());
		     }
		   }
		 }

    response.setContentType("text/plain");
    response.setCharacterEncoding("UTF-8");

   // response.getWriter().print("Hello App Engine!\r\n");

  }
}