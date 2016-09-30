//
//  ViewController.swift
//  unicorn1
//
//  Created by Signe Henderson on 8/19/16.
//  Copyright © 2016 Signe Henderson. All rights reserved.
//

import UIKit
import SocketIO

class ViewController: UIViewController {

    @IBOutlet weak var serverLabel: UILabel!
    @IBOutlet weak var apiLabel: UILabel!
    @IBOutlet weak var clockLabel: UILabel!
    @IBOutlet weak var resetNotification: UILabel!
    @IBOutlet weak var buttonLabel: UILabel!
	@IBOutlet weak var socketServer: UILabel!
	@IBOutlet weak var socketAPILabel: UILabel!
	@IBOutlet weak var socketClock: UILabel!
    
    var timer       = Timer()
    let urlLoader = MyUrlLoader()
    
	let socket = SocketIOClient(socketURL: URL(string: "http://localhost:8888")!, config: [.log(true), .forcePolling(true)])
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // allows the UILabel to wrap text across multiple lines
        serverLabel.lineBreakMode = .byWordWrapping;
        
        // allows the UILabel to display an unlimited number of lines
        serverLabel.numberOfLines = 0;
        
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(ViewController.loadContent(_:)), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view, typically from a nib.
//		socket.on("connect") {data, ack in
//			print("socket connected 1")
//		}
		socket.on("ping") {data, ack in
			print(data[0])
			self.socket.emit("pong", ["hello": "server"])
		}
		
		socket.connect()

		print("checkpoint")
	//		func socketHandler(data) {
	//			print(data)
	//			socket.emit("pong", {hello: server})
		//socket.emit("connection")
//		socket.on("socket_timer") {data,ack in
//			print(data)
//			//readSocketJSON(data)
//		}
    }
	
	func readSocketJSON(_ object: [String: AnyObject]) {
		guard let server = object["serverTimer"] as? Double,
			let api = object["apiTimer"] as? Int,
			let clock = object["clock"] as? String
			else {
				socketServer.text = "error in dict"
				return
		}
		socketServer.text = "server has been running for \(server) seconds"
		socketAPILabel.text = "the last api call was \(api) seconds ago"
		socketClock.text = "it is currently \(clock)"
	}
	
    func readJSONObject(_ object: [String: AnyObject]) {
        guard let server = object["serverTimer"] as? Double,
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
    
    @IBAction func SayHello(_ sender: AnyObject) {
        // create the alert
        let alert = UIAlertController(title: "UIAlertController", message: "Would you like reset this timer? Well it wont actually do that but it will say Hello.", preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: {action in         self.resetNotification.text = "Hello"
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func buttonHello(_ sender: AnyObject) {
        buttonLabel.text = "HI!"
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

