//
//  ViewController.swift
//  Yumemi-Training
//
//  Created by 小坂部泰成 on 2024/04/19.
//

import UIKit
import YumemiWeather

class ViewController: UIViewController {
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tappedReloadButton(_ sender: UIButton) {
        do {
            let jsonString = """
            {
                "area": "tokyo",
                "date": "2020-04-01T12:00:00+09:00",
            }
            """
            let responseData = try YumemiWeather.fetchWeather(jsonString)
            
            //レスポンスで受け取ったJSONをデコード
            let decoder = JSONDecoder()
            //Data型として扱えるように.utf8に変換してあげる必要がある
            if let jsonData = responseData.data(using: .utf8) {
                //WeatherResponse.selfでデコードするオブジェクトの型指定
                let decodeData = try decoder.decode(WeatherResponse.self, from: jsonData)
                self.maxTemperatureLabel.text = String(decodeData.maxTemperature)
                self.minTemperatureLabel.text = String(decodeData.minTemperature)
                self.weatherImage.image = UIImage(named: decodeData.weatherCondition)
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

