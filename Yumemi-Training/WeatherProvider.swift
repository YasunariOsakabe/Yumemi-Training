//
//  WeatherProvider.swift
//  Yumemi-Training
//
//  Created by 小坂部泰成 on 2024/05/12.
//

import YumemiWeather
import Foundation

class WeatherProvider: WeatherFetching {
    func fetchWeatherData(area: String, date: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        do {
            let encodeData = try encodeWeatherRequest(area, date)//APIリクエスト
            if let weatherResponseData = try decorderWeatherData(encodeData) { //レスポンスJSONをdecode
                completion(.success(weatherResponseData))
            } else {
                completion(.failure(YumemiWeatherError.unknownError))
            }
        } catch YumemiWeatherError.unknownError {
            completion(.failure(YumemiWeatherError.unknownError))
        } catch YumemiWeatherError.invalidParameterError {
            completion(.failure(YumemiWeatherError.invalidParameterError))
        } catch {
            completion(.failure(error))
        }
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
}

