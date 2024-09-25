//
//  NYCSchoolSATModel.swift
//  Dheeban-NYC-FinalProject
//
//  Created by Dheeban Jaga on 9/23/24.
//

import Foundation
struct NYCSchoolSATModel: Decodable {
    let dbn: String
    let school_name: String?
    let num_of_sat_test_takers: String?
    let sat_critical_reading_avg_score: String?
    let sat_math_avg_score: String?
    let sat_writing_avg_score: String?
}
