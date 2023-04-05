//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Aigerim on 22.05.2022.
//

import Foundation

private struct Constants {
    static let weatherURL: String = "https://api.openweathermap.org/data/2.5/weather?appid=c93b8def09a06a228cf0a053bb059670&units=metric&q="
}

protocol WeatherManagerDelegate: AnyObject {
    func onWeatherModelDidUpdate(with model: WeatherModel)
}

struct WeatherManager {
    
    weak var delegate: WeatherManagerDelegate?
    
    func fetchWeather(with city: String) {
        guard let url = URL(string: Constants.weatherURL + city) else {
            return
        }
        let urlRequest = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("Error \(error)")
            } else {
                guard let safeData = data else { return }
                parseJSON(from: safeData)
            }
        }
        task.resume()
    }
    
    func parseJSON(from data: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherModel.self, from: data)
            DispatchQueue.main.async {
                self.delegate?.onWeatherModelDidUpdate(with: decodedData)
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func configure(with model: Weather) {
        _ = model.id
}
}


