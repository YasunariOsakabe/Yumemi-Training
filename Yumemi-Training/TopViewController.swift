//
//  TopViewController.swift
//  Yumemi-Training
//
//  Created by 小坂部泰成 on 2024/04/27.
//

import UIKit

class TopViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "WeatherViewController") as! WeatherViewController
        secondViewController.modalPresentationStyle = .fullScreen
        self.present(secondViewController, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
