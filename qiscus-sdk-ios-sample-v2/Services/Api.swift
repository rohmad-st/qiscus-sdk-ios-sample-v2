//
//  Api.swift
//  qiscus-sdk-ios-sample-v2
//
//  Created by Rohmad Sasmito on 11/25/17.
//  Copyright © 2017 Qiscus Technology. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class Api {
    static func loadContacts(url: String, headers: [String:String], completion: @escaping (ApiResponse)->()){
        Alamofire.request(url, method: .get, headers: headers).responseJSON { (response) in
            if let value = response.result.value {
                if (response.response?.statusCode)! >= 300 {
                    completion(ApiResponse.failed(value: "Failed load contacts."))
                } else {
                    completion(ApiResponse.succeed(value: Response.getContacts(data: value)))
                }
                
            } else {
                completion(ApiResponse.failed(value: response.result.error!.localizedDescription))
            }
        }
    }
    
    static func uploadImage(_ url: String, headers: [String:String], image path: String, completion: @escaping (ApiResponse) -> ()) {
        
        Alamofire.upload(multipartFormData: { formData in
            let fileUrl = URL(fileURLWithPath: path)
            formData.append(fileUrl, withName: "file")},
                         usingThreshold: UInt64.init(),
                         to: url,
                         headers: headers,
                         encodingCompletion: { encodingResult in
                            switch encodingResult {
                            case .success(let upload, _, _):
                                upload.uploadProgress(closure: { response in
                                    completion(ApiResponse.onProgress(progress: Double(response.fractionCompleted)))
                                })
                                upload.responseJSON { response in
                                    if let value = response.result.value {
                                        if (response.response?.statusCode)! >= 300 {
                                            completion(ApiResponse.failed(value: "Failed upload image."))
                                        } else {
                                            completion(ApiResponse.succeed(value: Response.getImageFile(data: value)))
                                        }
                                        
                                    } else {
                                        completion(ApiResponse.failed(value: response.result.error!.localizedDescription))
                                    }
                                }
                                
                            case .failure(let encodingError):
                                completion(ApiResponse.failed(value: encodingError.localizedDescription))
                            }
        })
    }
}
