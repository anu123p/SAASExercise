package com.google;

import static java.util.stream.Collectors.toMap;

import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;

import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.DatastoreOptions;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;
import com.google.cloud.datastore.StringValue;
import com.google.cloud.datastore.Value;
import com.google.cloud.vision.v1.AnnotateImageRequest;
import com.google.cloud.vision.v1.AnnotateImageResponse;
import com.google.cloud.vision.v1.BatchAnnotateImagesResponse;
import com.google.cloud.vision.v1.Feature;
import com.google.cloud.vision.v1.Image;
import com.google.cloud.vision.v1.ImageAnnotatorClient;
import com.google.protobuf.ByteString;

@WebServlet(name = "HelloAppEngine", urlPatterns = { "/generateAlbum" })
public class HelloAppEngine extends HttpServlet {
	String category = "People";

	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {

		System.out.println("Inside do post");
		Datastore datastore = DatastoreOptions.getDefaultInstance().getService();

		byte[] imageByte = null;
		boolean imageExist = false;

		String userID = (String) req.getParameter("userID");

		ArrayList<String> photoID = new ArrayList<String>(
				Arrays.asList(req.getParameterValues("imageID")[0].split(",")));
		ArrayList<String> imageLinks = new ArrayList<String>(
				Arrays.asList(req.getParameterValues("imageLinks")[0].split(",")));

		CloudAPI.checkDeletedImages(datastore, photoID, userID);

		for (int i = 0; i < imageLinks.size(); i++) {
			System.out.println("Inside do post addded by anu " + imageLinks.get(i));

			imageExist = CloudAPI.checkIfImageExists(datastore, photoID.get(i));
			if (!imageExist) {
				try {
					imageByte = downloadFile(new URL(imageLinks.get(i)));
					System.out.println("added by anu : image length" + imageByte.length);
				} catch (MalformedURLException e) {

					e.printStackTrace();
				} catch (Exception e) {

					e.printStackTrace();
				}

				String category = getImageCategory(imageByte);
				List<String> labels = getImageLabels(imageByte);
				addData(imageLinks.get(i), photoID.get(i), category, userID, labels);
			}

		}

		Map<String, List<String>> data = CloudAPI.retrieveImages(datastore, userID);

		req.setAttribute("imagesLink", data);

		RequestDispatcher requestDispatcher = req.getRequestDispatcher("index.jsp");

		requestDispatcher.forward(req, res);

	}

	public byte[] downloadFile(URL url) throws Exception {
		try (InputStream in = url.openStream()) {
			byte[] bytes = IOUtils.toByteArray(in);
			return bytes;
		}
	}

	private String getImageCategory(byte[] imgBytes) throws IOException {
		// boolean landscape =false ;
		System.out.println("added by anu : inside image category");
		Map<String, Float> labelsData = new HashMap();
		boolean categorySet = false;
		int countperson = 0;

		ByteString byteString = ByteString.copyFrom(imgBytes);
		Image image = Image.newBuilder().setContent(byteString).build();

		Feature feature = Feature.newBuilder().setType(Feature.Type.LABEL_DETECTION).setMaxResults(15).build();
		Feature featureLandmark = Feature.newBuilder().setType(Feature.Type.LANDMARK_DETECTION).build();
		Feature featureFace = Feature.newBuilder().setType(Feature.Type.FACE_DETECTION).build();
		Feature featureObject = Feature.newBuilder().setType(Feature.Type.OBJECT_LOCALIZATION).build();

		AnnotateImageRequest request = AnnotateImageRequest.newBuilder().addFeatures(feature).setImage(image).build();

		AnnotateImageRequest request1 = AnnotateImageRequest.newBuilder().addFeatures(featureLandmark).setImage(image)
				.build();

		AnnotateImageRequest request2 = AnnotateImageRequest.newBuilder().addFeatures(featureFace).setImage(image)
				.build();
		AnnotateImageRequest request3 = AnnotateImageRequest.newBuilder().addFeatures(featureObject).setImage(image)
				.build();

		List<AnnotateImageRequest> requests = new ArrayList<>();
		requests.add(request);
		requests.add(request1);
		requests.add(request2);
		requests.add(request3);

		ImageAnnotatorClient client = ImageAnnotatorClient.create();

		BatchAnnotateImagesResponse batchResponse = client.batchAnnotateImages(requests);
		client.close();
		List<AnnotateImageResponse> imageResponses = batchResponse.getResponsesList();
		// System.out.println("Added by anu" + imageResponses);
		AnnotateImageResponse imageResponseLabel = imageResponses.get(0);
		AnnotateImageResponse imageResponseLandmark = imageResponses.get(1);
		AnnotateImageResponse imageResponseFace = imageResponses.get(2);
		AnnotateImageResponse imageResponseObject = imageResponses.get(3);
		int Objectcount = imageResponseObject.getLocalizedObjectAnnotationsCount();

		if (Objectcount >= 1) {
			for (int i = 0; i < imageResponseObject.getLocalizedObjectAnnotationsList().size(); i++) {
				String objectCheck = imageResponseObject.getLocalizedObjectAnnotationsList().get(i).getName()
						.toLowerCase();

				if (objectCheck.contains("person")) {
					categorySet = true;
					countperson++;
				}
			}
		}

		for (int i = 0; i < imageResponseLabel.getLabelAnnotationsList().size(); i++) {
			String labelCheck = imageResponseLabel.getLabelAnnotationsList().get(i).getDescription().toLowerCase();

			if (labelCheck.contains("landscape")) {
				labelsData.put("Landscape", imageResponseLabel.getLabelAnnotationsList().get(i).getScore());
			}

			if (labelCheck.contains("animal") || labelCheck.contains("carnivore") || labelCheck.contains("organism")
					|| labelCheck.contains("reptile") || labelCheck.contains("bird") || labelCheck.contains("whiskers") || labelCheck.contains("wildlife")) {
				if(labelsData.get("Animal")==null)
				labelsData.put("Animal", imageResponseLabel.getLabelAnnotationsList().get(i).getScore());
			}

			if (labelCheck.contains("food")) {
				labelsData.put("Food", imageResponseLabel.getLabelAnnotationsList().get(i).getScore());
			}

		}

		Map<String, Float> sortedByValue = labelsData.entrySet().stream()
				.sorted(Map.Entry.<String, Float>comparingByValue().reversed())
				.collect(toMap(Map.Entry::getKey, Map.Entry::getValue, (e1, e2) -> e1, LinkedHashMap::new));

		if (imageResponseLandmark.getLandmarkAnnotationsCount() >= 1)
			category = "Landmark";
		else if (imageResponseFace.getFaceAnnotationsCount() >= 1 || categorySet == true) {
			if (imageResponseFace.getFaceAnnotationsCount() >= 4 || countperson >= 4)
				category = "Grouped People";
			else
				category = "People";
		} else {
			if (sortedByValue.isEmpty())
				category = "Object";
			else
				category = (String) sortedByValue.keySet().toArray()[0];
		}
		// System.out.println("Added by ANU labels: "+
		// imageResponseLabel.getLabelAnnotationsList());
		System.out.println("Added by ANU category Final: " + category);

		if (imageResponseLabel.hasError()) {
			System.err.println("Error getting image labels: " + imageResponseLabel.getError().getMessage());
			return null;
		}
		return category;
	}

	private void addData(String url, String imageId, String category, String userId, List<String> labels) {

		Datastore datastore = DatastoreOptions.getDefaultInstance().getService();

		String kind = "image";
		String ID = imageId;

		Key taskKey = datastore.newKeyFactory().setKind(kind).newKey(ID);

		List<Value<String>> labelsDB = new ArrayList<Value<String>>();
		for (String s : labels) {
			labelsDB.add(StringValue.of(s));
		}

		System.out.println("Added by anu" + labelsDB.get(0));

		Entity task = Entity.newBuilder(taskKey).set("category", category).set("url", url).set("userId", userId)
				.set("label", labelsDB).build();

		datastore.put(task);

		System.out.println("Saved" + task.getKey().getName() + task.getString("category"));

		// Retrieve entity
		Entity retrieved = datastore.get(taskKey);

		System.out.printf("Retrieved %s: %s%n", taskKey.getName(), retrieved.getString("category"));
	}

	private List<String> getImageLabels(byte[] imgBytes) throws IOException {
		ByteString byteString = ByteString.copyFrom(imgBytes);
		Image image = Image.newBuilder().setContent(byteString).build();
		List<String> labels = new ArrayList();

		Feature feature = Feature.newBuilder().setType(Feature.Type.LABEL_DETECTION).build();
		AnnotateImageRequest request = AnnotateImageRequest.newBuilder().addFeatures(feature).setImage(image).build();
		List<AnnotateImageRequest> requests = new ArrayList<>();
		requests.add(request);

		ImageAnnotatorClient client = ImageAnnotatorClient.create();
		BatchAnnotateImagesResponse batchResponse = client.batchAnnotateImages(requests);
		client.close();
		List<AnnotateImageResponse> imageResponses = batchResponse.getResponsesList();
		AnnotateImageResponse imageResponse = imageResponses.get(0);

		if (imageResponse.hasError()) {
			System.err.println("Error getting image labels: " + imageResponse.getError().getMessage());
			return null;
		}

		for (int i = 0; i < imageResponse.getLabelAnnotationsList().size(); i++) {
			labels.add(imageResponse.getLabelAnnotations(i).getDescription());
		}
		return labels;

	}

}
