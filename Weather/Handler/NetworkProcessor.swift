//
//  NetworkProcessor.swift
//  Weather
//
//  Created by Joakim Kajan on 19.02.2019.
//  Copyright © 2019 JapeSoft. All rights reserved.
//

import Foundation

class NetworkProcessor {
    
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configuration)
    
    let url : URL
    
    init(url: URL)
        
    {
        self.url = url
        
    }
    
    typealias JSONDictionaryHandler = (([String: Any]?) -> Void)
    
    func downloadJSONFromUrl(_completion: @escaping JSONDictionaryHandler) {
        
        let request = URLRequest(url: self.url)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            if error == nil {
                
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                        
                    case 200:
                        // Succesful response
                        if let data = data {
                            do {
                                let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                                _completion(jsonDictionary as? [String: Any] )
                                
                            }catch let error as NSError {
                                print("Error processing JSON data: \(error.localizedDescription)")
                            }
                        }
                    default:
                        print("HTTP Response Code: \(httpResponse.statusCode)")
                    }
                }
            }else{
                print("Error in NetworkProcessor")
            }
        }
        dataTask.resume()
    }
    
    
}
