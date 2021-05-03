package com.google;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;

import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.DatastoreOptions;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;
import com.google.cloud.datastore.Query;
import com.google.cloud.datastore.QueryResults;
import com.google.cloud.datastore.StructuredQuery.CompositeFilter;
import com.google.cloud.datastore.StructuredQuery.PropertyFilter;



/**
 * This is a java class which contains all the method to Google Datastore like retrieveImages, checkDeletedImages etc.
 *
 */
@MultipartConfig
@WebServlet(name = "CloudAPI", urlPatterns = { "/search" })
public class CloudAPI extends HttpServlet {
	public CloudAPI() {
	}

	

	/**
	 * This method handles the post request triggered by /search.jsp and returns list of image url and search key
	 *
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("Inside do post of cloud API");
		String key = (String)request.getParameter("Label");
		String userID = (String)request.getParameter("userID1");
		String keyUpper = key.substring(0, 1).toUpperCase() + key.substring(1);
		System.out.println("Inside do post of cloud API : userID " + userID);
		List<String> searchResults = retrieveImagesWithKey(keyUpper,userID);
		request.setAttribute("labelAttribute", key);
        request.setAttribute("imagesLink", searchResults);
        
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("search.jsp");
 
        requestDispatcher.forward(request, response);		
}


	/**
	 * This method gets image data from Google datastore on the basis of the search key given in search.jsp for user with id 'userID'
	 * @param key
	 * @param userID
	 * @return
	 */
	private List<String> retrieveImagesWithKey(String key, String userID) {
		Datastore datastore = DatastoreOptions.getDefaultInstance().getService();
		 Query<Entity> query = Query.newEntityQueryBuilder()
			        .setKind("image")
			        .setFilter(CompositeFilter.and(
			            PropertyFilter.eq("label", key),PropertyFilter.eq("userId", userID))
			        		)
			        .build();
	

		System.out.println("Added by anu + " + query.toString());
		QueryResults<Entity> results = datastore.run(query);

		List<String> searchResults = new ArrayList();
		while (results.hasNext()) {
			Entity task = results.next();
			System.out.println(task.getKey().getName().toString());
			System.out.println(task.getValue("userId").get());
			System.out.println(task.getValue("category").get().toString());
			System.out.println(task.getValue("label").get());
			System.out.println(task.getValue("url").get());
			searchResults.add(task.getValue("url").get().toString());
		}
		return searchResults;
	}



	/**
	 * This method gets all images from Google datastore for user with id 'userID'
	 * @param datastore
	 * @param userId
	 * @return
	 */
	public static Map<String, List<String>> retrieveImages(Datastore datastore, String userId) {

		Query<Entity> query = Query.newEntityQueryBuilder().setKind("image")
				.setFilter(PropertyFilter.eq("userId", userId)).build();

		System.out.println("Added by anu + " + query.toString());
		QueryResults<Entity> results = datastore.run(query);

		Map<String, List<String>> data = new HashMap();
		while (results.hasNext()) {
			Entity task = results.next();
			String category = task.getValue("category").get().toString();
			String url = task.getValue("url").get().toString();
			
			if(data.get(category)!=null)
			{
				List<String> list = data.get(category);
				list.add(url);
				data.put(category, list);
			}
			else {
				List<String> list = new ArrayList();
				list.add(url);
				data.put(category,list);
			}
			
			System.out.println(task.getKey().getName().toString());
			System.out.println(task.getValue("userId").get());
			System.out.println(task.getValue("category").get().toString());
			System.out.println(task.getValue("label").get());
			System.out.println(task.getValue("url").get());
		}
		return data;

	}

	/**
	 * This method returns true if image is present in Google Datastore.
	 * @param datastore
	 * @param imageId
	 * @return
	 */
	public static boolean checkIfImageExists(Datastore datastore, String imageId) {
		String kind = "image";
		// The name/ID for the new entity
		String ID = imageId;
		// The Cloud Datastore key for the new entity
		Key taskKey = datastore.newKeyFactory().setKind(kind).newKey(ID);
		Entity image = datastore.get(taskKey);

		if (image == null) {
			return false;
		}
		return true;
	}

	/**
	 * This method deletes images in datastore if image is not present in the list of images retrieved from facebook.
	 * @param datastore
	 * @param imageId
	 * @param userId
	 */
	public static void checkDeletedImages(Datastore datastore, List<String> imageId, String userId) {
		Query<Entity> query = Query.newEntityQueryBuilder().setKind("image")
				.setFilter(PropertyFilter.eq("userId", userId)).build();

		QueryResults<Entity> results = datastore.run(query);

		List<String> imageDatastore = new ArrayList<>();

		while (results.hasNext()) {
			Entity task = results.next();
			String imageDB = task.getKey().getName().toString();
			imageDatastore.add(imageDB);
		}

		List<String> differences = imageDatastore.stream().filter(element -> !imageId.contains(element))
				.collect(Collectors.toList());

		differences.forEach(k -> datastore.delete(datastore.newKeyFactory().setKind("image").newKey(k)));

	}

}
