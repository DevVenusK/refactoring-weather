//
//  WeatherForecast - Weather.swift
//  Created by yagom.
//  Copyright © yagom. All rights reserved.
// 

import Foundation

// MARK: - Weather JSON Format
struct WeatherJSON: Decodable {
    let weatherForecast: [WeatherForecastInfo]
    let city: City
}

// MARK: - List
struct WeatherForecastInfo: Decodable {
    let dt: TimeInterval
    let main: MainInfo
    let weather: Weather
    let dtTxt: String
}

// MARK: - MainClass
struct MainInfo: Decodable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity, pop: Double
}

// MARK: - Weather
struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

// MARK: - City
struct City: Decodable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone: Int
    let sunrise, sunset: TimeInterval
}

// MARK: - Coord
struct Coord: Decodable {
    let lat, lon: Double
}

// MARK: - Temperature Unit
enum TempUnit: String {
  case metric, imperial
  var expression: String {
    switch self {
    case .metric: return "℃"
    case .imperial: return "℉"
    }
  }
  
  var character: String {
    switch self {
    case .metric: return "섭씨"
    case .imperial: return "화씨"
    }
  }
}

struct Temp {
 private (set) var value: Double
}

struct MetricTemp {
  var temp: Temp
}

struct ImperialTemp {
  private var _temp: Temp
  
  var temp: Double {
    return _temp.value
  }
  
  init(from metricTemp: MetricTemp) {
    let metricTemp = metricTemp.temp
    let imperialTemp = (metricTemp.value * 9/5) + 32.0
    _temp = Temp(value: imperialTemp)
  }
}
