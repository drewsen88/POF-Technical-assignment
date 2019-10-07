//
//  APIClient.swift
//  CollectionViewBlog
//
//  Created by Erica Millado on 7/3/17.
//  Copyright © 2017 Erica Millado. All rights reserved.
//

import Foundation

typealias AudiobookJSON = [String: Any]

struct APIClient {
    
    static func getAudiobooksAPI(completion: @escaping ([AudiobookJSON?]) -> Void) {
        
        // Set up the URL request
        let todoEndpoint: String = "https://jsonplaceholder.typicode.com/photos"
        guard let url = URL(string: todoEndpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on photos")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let photos = try JSONSerialization.jsonObject(with: responseData)
                    as? [[String: Any]] else {
                        print("error trying to convert data to JSON")
                        return
                }
                // now we have the todo
                // let's just print it to prove we can access it
//                print("The todo is: " + todo.description)
                
                completion(photos)
                
                // the todo object is a dictionary
                // so we just access the title using the "title" key
                // so check for a title and print it if we have one
//                guard let todoTitle = photos["title"] as? String else {
//                    print("Could not get todo title from JSON")
//                    return
//                }
//                print("The title is: " + todoTitle)
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
        
//        let url = URL(string: "http://jsonplaceholder.typicode.com/photos")
//
//        let session = URLSession.shared
//
//        guard let unwrappedURL = url else { print("Error unwrapping URL"); return }
//
//        let dataTask = session.dataTask(with: unwrappedURL) { (data, response, error) in
//
//            guard let unwrappedDAta = data else { print("Error unwrapping data"); return }
//
//            do {
//                let responseJSON = try JSONSerialization.jsonObject(with: unwrappedDAta, options: []) as? AudiobookJSON
//                completion(responseJSON)
//            } catch {
//                print("Could not get API data. \(error), \(error.localizedDescription)")
//            }
//        }
//        dataTask.resume()
    }
}

