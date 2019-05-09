//
//  Model.swift
//  JaesoseolAssignment
//
//  Created by 진형진 on 08/05/2019.
//  Copyright © 2019 진형진. All rights reserved.
//

import Foundation

struct Model: Codable {
    let companyName: String
    let fields: String
    let image: String
    let endTime: String
    
    enum CodingKeys: String, CodingKey {
        case companyName = "company_name"
        case endTime = "end_time"
        case fields, image
    }
}
