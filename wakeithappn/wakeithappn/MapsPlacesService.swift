//
//  MapsPlacesHelper.swift
//  Reco
//
//  Created by Salil Gokhale on 30/07/2017.
//  Copyright © 2017 Salil Gokhale. All rights reserved.
//

import GooglePlaces
import Alamofire

class MapsPlacesService {
    
    typealias resultTuple = (result: GMSAutocompletePrediction?, error: Error?)
    static let mapsUrl = "https://maps.googleapis.com/maps/api/place/textsearch/json"
    static let placesClient = GMSPlacesClient()
    
    enum PlacesResult {
        case success([SearchAddressItem])
        case failure(Error)
    }
    
    enum DataError: Error {
        case invalidJSONData
    }
    
    class func getPlaces(textInput: String, currentLocation: (Double, Double)?, completion: @escaping  ([SearchAddressItem]?, Error?) -> Void) -> Void {
        
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        placesClient.autocompleteQuery(textInput, bounds: nil, filter: filter, callback: {(results, error) -> Void in
            if let error = error {
                print("Autocomplete error \(error)")
                return
            }
            if let results = results {
                var resultArray = [SearchAddressItem] ()
                for result in results {
                    print("Result \(result.attributedFullText) with placeID \(result.placeID)")
                    
                    let item = SearchAddressItem(itemID: result.placeID!, itemName: result.attributedFullText.string, itemDetails: "")
                    resultArray.append(item)
                    
//                    getPlaceWithId(placeId: result.placeID!)
                }
                completion(resultArray, nil)
            }
        })
        
        
        
//        var params = ["query": textInput, "key": "AIzaSyBopx32elcC8POpfWzWNUEsKvTY6e_HbQg", "type": "restaurant"]
//        if let currentLocation = currentLocation {
//            params["location"] = "\(currentLocation.0),\(currentLocation.1)"
//            params["radius"] = "50000"
//        }

//        Alamofire.request(mapsUrl, parameters: params)
//            .responseJSON { response in
//                print("Response: \(String(describing: response.response))") // http url response
//                print("Result: \(response.result)")                         // response serialization result
//                print("Error: \(response.error)")
//
//                // TODO Add error handling
//
//                if let error = response.error {
//                    completion(nil, error)
//                    return
//                }
//
//                if let json = response.result.value as? [String: Any],
//                    let results = json["results"] as? [[String: Any]] {
//
//                    var resultArray = [SearchAddressItem] ()
//
//                    for result in results {
//                        guard let id = result["id"] as? String,
//                            let name = result["name"] as? String,
//                            let address = result["formatted_address"] as? String else {
//                                return
//                        }
//                        let item = SearchAddressItem(itemID: id, itemName: name, itemDetails: address)
//                        resultArray.append(item)
//                    }
//                    completion(resultArray, nil)
//                } else {
//                    completion(nil, DataError.invalidJSONData)
//                }
//
//        }
        
    }
    
    class func getPlaceWithId(placeId: String, completion: @escaping  (Location, Error?) -> Void) -> Void {
        placesClient.lookUpPlaceID(placeId, callback: { (place, error) -> Void in
            if let error = error {
                print("lookup place id query error: \(error.localizedDescription)")
                return
            }
            
            guard let place = place else {
                print("No place details for \(placeId)")
                return
            }
            
            print("Place name \(place.name)")
            print("Place address \(place.formattedAddress)")
            print("Place placeID \(place.placeID)")
            print("Place attributions \(place.attributions)")
            let lat = Double(place.coordinate.latitude)
            let long = Double(place.coordinate.longitude)
            let coords = (lat, long)
            let location = Location(placeId: place.placeID, name: place.name, formattedAddress: place.formattedAddress!, coordinates: coords)
            completion(location, nil)
        })
    }
    
}

