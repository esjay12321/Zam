//
//  ProfileViewController.swift
//  prototype1
//
//  Created by Esjay Hong on 21/04/2018.
//  Copyright © 2018 Minkyung Kim. All rights reserved.
//

import UIKit
import CoreMotion

class ProfileViewController: UIViewController {
    
    var motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile"
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewDidAppear(_ animated: Bool) {
        motionManager.accelerometerUpdateInterval = 0.5
        
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!, withHandler: {(data, error) in
            if let myData = data {
                print(myData)
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
