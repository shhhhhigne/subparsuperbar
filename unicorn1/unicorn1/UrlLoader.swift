//
//  UrlLoader.swift
//  unicorn1
//
//  Created by Signe Henderson on 8/19/16.
//  Copyright © 2016 Signe Henderson. All rights reserved.
//

import Foundation
import UIKit

protocol UrlLoader {
    func loadContent(_ urlString: String) -> [String: AnyObject]
}


struct MyUrlLoader: UrlLoader {
    func loadContent(_ urlString: String) -> [String: AnyObject] {
        if let url = URL(string: urlString) {
            do {
                let data = try? Data(contentsOf: url)
                let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                if let dictionary = object as? [String: AnyObject] {
                    return dictionary
                }
            } catch {
                let someDict:[String:String] = ["error":"could not load contents"]
                return someDict as [String : AnyObject]
            }
        } else {
            let someDict:[String:String] = ["error":"url was bad"]
            return someDict as [String : AnyObject]
        }
        let someDict:[String:String] = ["error":"url was bad"]
        return someDict as [String : AnyObject]
    }
}
