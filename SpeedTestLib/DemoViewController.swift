//
//  DemoViewController.swift
//  SpeedTestLib
//
//  Created by 于涛鸣 on 2021/5/3.
//  Copyright © 2021 Exadel. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    private var speedTest = SpeedTest()
    let group = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let speedTestHost = SpeedTestHost(url: URL(string: "http://gdspeedtest.com/speedtest/upload.php")!, name: "Guangzhou", country: "China", cc: "CN", host: "gdspeedtest.com.prod.hosts.ooklaserver.net:8080", sponsor: "ChinaTelecom 5G")
        
        var speedTestHosts = [SpeedTestHost]()
        
        speedTest.findHosts(timeout: 10) { result in
            switch result {
            case.error:
                print("Cannot find host!!")
            case.value(let hosts):
                speedTestHosts = hosts
                print("\(speedTestHosts)")
            }
        }
        
        // Test ping
        
        self.speedTest.ping(host: speedTestHost, timeout: TimeInterval(10)) { result in
            switch result {
            case .value(let ping):
                print("ping: \(ping)ms")
            case .error:
                print("Error!!")
            }
        }
        
        speedTest.findBestHost(from: 8, timeout: 10) { result in
                switch result {
                case .value(let ping):
                    print("\(ping.0)")
                    print("\(ping.1)")
                case .error:
                    print("Cannot find host!!")
                }
        }
        
        // Test download speed
        speedTest.runDownloadTest(for: speedTestHost.url, size: 10000000, timeout: 60) { speed in
            print("Current average download speed:\(speed.description)")
        } final: { result in
            switch result {
            case .value(let speed):
                print("Final average download speed:\(speed.description)")
            case .error:
                print("An error happened during downloading...")
            }
        }
        
        // Test upload speed
        speedTest.runUploadTest(for: speedTestHost.url, size: 10000000, timeout: 30) { speed in
            print("Current average upload speed:\(speed.description)")
        } final: { result in
            switch result {
            case .value(let speed):
                print("Final average upload speed:\(speed.description)")
            case .error:
                print("An error happened during uploading...")
            }
        }
    }
}

