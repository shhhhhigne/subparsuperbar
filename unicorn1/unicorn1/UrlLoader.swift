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
    func loadContent(urlString: String) -> [String: AnyObject]
}


struct MyUrlLoader: UrlLoader {
    func loadContent(urlString: String) -> [String: AnyObject] {
        if let url = NSURL(string: urlString) {
            do {
                let data = NSData(contentsOfURL: url)
                let object = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                if let dictionary = object as? [String: AnyObject] {
                    return dictionary
                }
            } catch {
                let someDict:[String:String] = ["error":"could not load contents"]
                return someDict
            }
        } else {
            let someDict:[String:String] = ["error":"url was bad"]
            return someDict
        }
        let someDict:[String:String] = ["error":"url was bad"]
        return someDict
    }
}