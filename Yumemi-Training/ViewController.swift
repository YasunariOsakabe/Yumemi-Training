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
        weatherImage.image = UIImage(named: YumemiWeather.fetchWeatherCondition())
    }

    
}

