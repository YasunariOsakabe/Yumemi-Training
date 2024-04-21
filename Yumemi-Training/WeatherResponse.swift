//
//  WeatherResponse.swift
//  Yumemi-Training
//
//  Created by 小坂部泰成 on 2024/04/21.
//

import Foundation

struct WeatherResponse: Codable {
    var maxTemperature: Int
    var minTemperature: Int
    var date: String
    var weatherCondition: String
    
    enum CodingKeys: String, CodingKey {
        case maxTemperature = "max_temperature"
        case minTemperature = "min_temperature"
        case date
        case weatherCondition = "weather_condition"
    }
}
