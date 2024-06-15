//
//  WeatherDataUpdateDelegate.swift
//  Yumemi-Training
//
//  Created by 小坂部泰成 on 2024/06/15.
//

import UIKit

protocol WeatherDataUpdateDelegate: AnyObject {
    func weatherDataOutput(_ weatherData: WeatherResponse)
}
