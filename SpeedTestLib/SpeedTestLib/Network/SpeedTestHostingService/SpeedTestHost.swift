//
//  SpeedTestHost.swift
//  SpeedTestLib
//
//  Created by dhaurylenka on 2/5/18.
//  Copyright © 2018 Exadel. All rights reserved.
//

import Foundation

/*
 "url": "http://test.byfly.by/speedtest/upload.php",
 "lat": "53.9000",
 "lon": "27.5667",
 "distance": 0,
 "name": "Minsk",
 "country": "Belarus",
 "cc": "BY",
 "sponsor": "MGTS",
 "id": "1119",
 "preferred": 0,
 "host": "test.byfly.by:8080"
*/

public struct SpeedTestHost: Codable {
    let url: URL
    let name: String
    let country: String
    let cc: String
    let host: String
    let sponsor: String
}
