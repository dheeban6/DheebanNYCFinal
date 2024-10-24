//
//  NYCSchoolService.swift
//  Dheeban-NYC-FinalProject
//
//  Created by Dheeban Jaga on 9/23/24.
//

//
//  NYCSchoolService.swift
//  Dheeban-NYC-FinalProject
//
//  Created by Dheeban Jaga on 9/23/24.
//

import Foundation
import Combine

protocol NYCSchoolServiceProtocol {
    func fetchSchoolList() -> AnyPublisher<[NYCSchoolModel], Error>
    func fetchSATDetails() -> AnyPublisher<[NYCSchoolSATModel], Error>
}

class NYCSchoolService: NYCSchoolServiceProtocol {
    private let schoolListURL = "https://data.cityofnewyork.us/resource/7crd-d9xh.json"
    private let satDetailsURL = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"
    
    func fetchSchoolList() -> AnyPublisher<[NYCSchoolModel], Error> {
        guard let url = URL(string: schoolListURL) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [NYCSchoolModel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchSATDetails() -> AnyPublisher<[NYCSchoolSATModel], Error> {
        guard let url = URL(string: satDetailsURL) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [NYCSchoolSATModel].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
