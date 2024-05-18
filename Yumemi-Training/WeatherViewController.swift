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
    func fetchWeatherData()
}

class WeatherViewController: UIViewController {
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(fetchWeatherDataNotification(_ :)), name: Notification.Name.activeApp, object: nil)
    }
    
    @IBAction func tappedReloadButton(_ sender: UIButton) {
        fetchWeatherData()
    }
    
    @IBAction func tappedCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    private func encodeWeatherRequest(_ area: String, _ date: String) throws -> Data {
        let jsonEncode = JSONEncoder()
        let data = try jsonEncode.encode(WeatherRequest(area: area, date: date))
        return data
    }
    
    private func decorderWeatherData(_ jsonData: Data) throws -> WeatherResponse? {
        //レスポンスで受け取ったJSONをデコード
        let decoder = JSONDecoder()
        let responseData = try YumemiWeather.fetchWeather(String(data: jsonData, encoding: String.Encoding.utf8)!)
        //Data型として扱えるように.utf8に変換してあげる必要がある
        if let jsonData = responseData.data(using: .utf8) {
            //WeatherResponse.selfでデコードするオブジェクトの型指定
            let decodeData = try decoder.decode(WeatherResponse.self, from: jsonData)
            return decodeData
        }
        return nil
    }
    
    
    @objc func fetchWeatherDataNotification(_ notification: Notification) {
        fetchWeatherData()
    }
    
    func fetchWeatherData() {
        do {
            //ここの部分のJSON形式でリクエスト送るところをエンコード処理を実装して簡易的にJSON形式を作れるようにしたい
            let encodeData = try encodeWeatherRequest("tokyo", "2020-04-01T12:00:00+09:00" )
            if let weatherResponseData = try decorderWeatherData(encodeData) {
                self.maxTemperatureLabel.text = String(weatherResponseData.maxTemperature)
                self.minTemperatureLabel.text = String(weatherResponseData.minTemperature)
                self.weatherImage.image = UIImage(named: weatherResponseData.weatherCondition)
            }
        } catch YumemiWeatherError.unknownError {
            showErrorAlert()
        } catch YumemiWeatherError.invalidParameterError {
            showErrorAlert()
        }catch {
            //絶対に入ることのないerror-catchだが記述が必要
        }
        
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

