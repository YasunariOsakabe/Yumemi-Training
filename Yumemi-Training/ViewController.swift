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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tappedReloadButton(_ sender: UIButton) {
        do {
            weatherImage.image = UIImage(named: try YumemiWeather.fetchWeatherCondition(at: "tokyo"))
        } catch YumemiWeatherError.invalidParameterError {
            showErrorAlert()
        } catch YumemiWeatherError.unknownError {
            showErrorAlert()
        } catch {
            //絶対に入ることのないerror-catchだが記述が必要
        }
    }
    
    private func showErrorAlert() {
        let errorAlert = UIAlertController(title: "error", message: "エラーが発生しました", preferredStyle: .alert)
        errorAlert.addTextField()
        let okAction = UIAlertAction(title: "OK", style: .cancel) {_ in
            self.dismiss(animated: true)
        }
        errorAlert.addAction(okAction)
        present(errorAlert, animated: true)
    }

    
}

