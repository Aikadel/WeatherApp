//
//  ViewController.swift
//  WeatherApp
//
//  Created by Aigerim on 22.05.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var cityName: UILabel!
    @IBOutlet private weak var temperature: UILabel!
    @IBOutlet private weak var precipitation: UIImageView!
    @IBOutlet weak var cityTextField: UITextField!

    var manager = WeatherManager ()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
    }

    @IBAction func onButtonDidTap (_ sender: UIButton){
        if let cityNameIntered = cityTextField.text {
            manager.fetchWeather(with: cityNameIntered)
        }
        cityTextField.text = ""
}
}
extension ViewController: WeatherManagerDelegate {
    
    
        func onWeatherModelDidUpdate(with model: WeatherModel) {
            cityName.text = model.name
            let formattedValue = String(format: "%.1f", model.main.temp)
            temperature.text = formattedValue + "℃"
            let conditionId = model.weather[0].id
    
            switch (conditionId) {
                    case (200...232):
                precipitation.image = UIImage(systemName: "cloud.bolt")
                    case 300...321:
                precipitation.image = UIImage(systemName: "cloud.drizzle")
                    case 500...531:
                precipitation.image = UIImage(systemName: "cloud.rain")
                    case 600...622:
                precipitation.image = UIImage(systemName: "cloud.snow")
                    case 701...781:
                precipitation.image = UIImage(systemName: "cloud.fog")
                    case 800:
                precipitation.image = UIImage(systemName: "sun.max")
                    case 801...804:
                precipitation.image = UIImage(systemName: "cloud.bolt")
                    default:
                precipitation.image = UIImage(systemName: "cloud")
            }
        }
}


