//
//  ViewController.swift
//  Yumemi-Training
//
//  Created by 小坂部泰成 on 2024/04/19.
//

import UIKit
import YumemiWeather

protocol WeatherFetching {
    //天気予報を取得する関数を宣言する
    func fetchWeatherData(area: String, date: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void)
    }

class WeatherViewController: UIViewController {
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var syncLoadingIndicator: UIActivityIndicatorView!
    
    private var weatherProvider: WeatherFetching!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weatherProvider = WeatherProvider()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchWeatherDataNotification(_ :)), name: Notification.Name.activeApp, object: nil)
        self.syncLoadingIndicator.isHidden = true
    }
    
    @IBAction func tappedReloadButton(_ sender: UIButton) {
        fetchWeatherData()
    }
    
    @IBAction func tappedCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    

    
    
    @objc func fetchWeatherDataNotification(_ notification: Notification) {
        fetchWeatherData()
    }
    
    func fetchWeatherData() {
        self.showLodingIndicator()
        DispatchQueue.global().async {
            self.weatherProvider.fetchWeatherData(area: "tokyo", date: "2020-04-01T12:00:00+09:00") { [weak self] result in
                DispatchQueue.main.async {
                    self?.hideLodingIndicator()
                    switch result {
                    case .success(let weatherResponse):
                        self?.maxTemperatureLabel.text = String(weatherResponse.maxTemperature)
                        self?.minTemperatureLabel.text = String(weatherResponse.minTemperature)
                        self?.weatherImage.image = UIImage(named: weatherResponse.weatherCondition)
                    case .failure:
                        self?.showErrorAlert()
                    }
                }
            }
            
            
        }
    }
    
    private func showLodingIndicator () {
        self.syncLoadingIndicator.isHidden = false
        self.syncLoadingIndicator.startAnimating()
    }
    
    private func hideLodingIndicator () {
        self.syncLoadingIndicator.stopAnimating()
        self.syncLoadingIndicator.isHidden = true
    }
    
    private func showErrorAlert() {
        let errorAlert = UIAlertController(title: "error", message: "エラーが発生しました", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) {_ in
            self.dismiss(animated: true)
        }
        errorAlert.addAction(okAction)
        present(errorAlert, animated: true)
    }

    
}

