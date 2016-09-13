//
//  ViewController.swift
//  unicorn1
//
//  Created by Signe Henderson on 8/19/16.
//  Copyright © 2016 Signe Henderson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var contentLabel: UILabel!
    
    var timer       = NSTimer()
    let urlLoader = MyUrlLoader()

    override func viewDidLoad() {
        super.viewDidLoad()
        // allows the UILabel to wrap text across multiple lines
        contentLabel.lineBreakMode = .ByWordWrapping;
        
        // allows the UILabel to display an unlimited number of lines
        contentLabel.numberOfLines = 0;
        //loadContent("http://localhost:8080")
        //let url = "http://localhost:8080"
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ViewController.loadContent(_:)), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func readJSONObject(object: [String: AnyObject]) {
        guard let server = object["serverTimer"] as? Int,
        let api = object["apiTimer"] as? Int,
        let clock = object["clock"] as? String
        else {
                contentLabel.text = "error in dict"
                return
            }
        contentLabel.text = "server has been running for \(server) seconds; the last api call was \(api) seconds ago; it is currently \(clock)"

        
       
        
    }
    
    func loadContent(timer: NSTimer) {
        let content = urlLoader.loadContent("http://localhost:8080")
        readJSONObject(content)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

