//
//  ViewController.swift
//  unicorn1
//
//  Created by Signe Henderson on 8/19/16.
//  Copyright © 2016 Signe Henderson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var serverLabel: UILabel!
    @IBOutlet weak var apiLabel: UILabel!
    @IBOutlet weak var clockLabel: UILabel!
    
    var timer       = Timer()
    let urlLoader = MyUrlLoader()

    override func viewDidLoad() {
        super.viewDidLoad()
        // allows the UILabel to wrap text across multiple lines
        serverLabel.lineBreakMode = .byWordWrapping;
        
        // allows the UILabel to display an unlimited number of lines
        serverLabel.numberOfLines = 0;
        //loadContent("http://localhost:8080")
        //let url = "http://localhost:8080"
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.loadContent(_:)), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func readJSONObject(_ object: [String: AnyObject]) {
        guard let server = object["serverTimer"] as? Int,
        let api = object["apiTimer"] as? Int,
        let clock = object["clock"] as? String
        else {
                serverLabel.text = "error in dict"
                return
            }
        serverLabel.text = "server has been running for \(server) seconds"
        apiLabel.text = "the last api call was \(api) seconds ago"
        clockLabel.text = "it is currently \(clock)"

        
       
        
    }
    
    func loadContent(_ timer: Timer) {
        let content = urlLoader.loadContent("http://localhost:8080")
        readJSONObject(content)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

