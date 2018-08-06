//
//  WUJSONParser.swift
//  Wunder
//
//  Created by sanjay on 04/08/18.
//  Copyright © 2018 sanjay. All rights reserved.
//

import Foundation
enum APIError: Error {
  case message(String)
  
  var localizedDescription: String {
    switch self {
    case .message(let string):
      return string
    }
  }
}
// return .failure(APIError.message(errorMessage))

let baseUrl = "https://s3-us-west-2.amazonaws.com/wunderbucket/locations.json"
struct JSONParser<Model> {
  var request: URLRequest
  let parse: (Data) throws -> Model
}
enum Result<Model> {
  case success(Model)
  case failure(Error)
}

struct WUJSONParser{
  func request<Model>(resource: JSONParser<Model>, completion: @escaping (Result<Model>) -> Void) {
    URLSession.shared.dataTask(with: resource.request) { (data, _, error) in
      if let error = error {
        DispatchQueue.main.async {
          completion(.failure(error))
        }
      } else {
        if let data = data {
          do {
            let result = try resource.parse(data)
            DispatchQueue.main.async {
              completion(.success(result))
            }
          } catch let error {
            DispatchQueue.main.async {
              completion(.failure(error))
            }
          }
        }
      }
      }.resume()
  }
}

extension JSONParser {
  init(url: ServiceURL, parseJSON: @escaping (Any) throws -> Model) {
    print("Url is \(url.description)")
    // create the url request
    self.request = URLRequest(url: url.description)
    self.parse = { data in
      let json = try JSONSerialization.jsonObject(with: data, options: [])
      print("Json is \(json)")
      return try parseJSON(data)
    }
  }
}

struct WUCarInfo {
  let carInfoService = JSONParser<WUResponse>(url: ServiceURL.CarService, parseJSON: { json in
    guard let data = json as? Data else {
      throw APIError.message("Unable to deconde the response")
    }
    return  try  JSONDecoder().decode(WUResponse.self, from: data)
  })
}

enum ServiceURL {
  case CarService;
  var description : URL {
    switch self {
    case .CarService: return URL(string: "\(baseUrl)")!;
    }
  }
}
  


/// Codable Protocol for response
struct WUResponse : Codable {
  let placemarks: [WUPlaceMark]
  enum CodingKeys: String, CodingKey {
    case placemarks = "placemarks"
  }
  
  /*
  static func decodeData(responseData: Data?)  {
    guard let data = responseData, let response = try? JSONDecoder().decode(WUResponse.self, from: data) else {
      //completionHandler(GooglePlacesResponse(results:[]))
      //throw APIError.message("Error")
      return nil
    }
  }*/
}


/// Placemarks info
struct WUPlaceMark : Codable {
  let address: String
  let coordinates: [Double]
  let engineType: String
  let exterior: String
  let fuel: Int
  let interior: String
  let name: String
  let vin: String
}
