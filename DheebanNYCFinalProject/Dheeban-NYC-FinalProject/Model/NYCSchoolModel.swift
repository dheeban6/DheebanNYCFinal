//
//  NYCSchoolModel.swift
//  Dheeban-NYC-FinalProject
//
//  Created by Dheeban Jaga on 9/23/24.
//

import Foundation
struct NYCSchoolModel: Decodable {
    let dbn: String
    let school_name: String
    let overview_paragraph: String?
    let neighborhood: String?
    let phone_number: String?
    let school_email: String?
    let borough: String?
    let city: String
    let website: String?
}
