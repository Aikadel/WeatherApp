//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Aigerim on 22.05.2022.
//

import Foundation



struct WeatherModel: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
}


