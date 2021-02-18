//
//  App + Extension.swift
//  SocketIO Chat App Mockup
//
//  Created by Ben Do on 2/9/21.
//

import Foundation
import UIKit

extension UIApplication {
    
    static func jsonString(from object: Any) -> String? {
        guard let data = jsonData(from: object) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
    static func jsonData(from object: Any) -> Data? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return data
    }
}
