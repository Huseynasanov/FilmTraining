//
//  MovieManager.swift
//  FilmTraining
//
//  Created by Huseyn Hasanov on 02.03.22.
//

import Foundation
import Foundation
protocol MovieDataProtocol{
    func getMovieData(data: MovieData)
}
struct MovieManager{
    var delegate: MovieDataProtocol?
    let MovieURL = "https://www.omdbapi.com/?apikey=e8bb5a85"
    func nameOfMOvie(title: String){
        let urlString = "\(MovieURL)&s=\(title)"
        print(urlString)
        performREquest(urlstring: urlString)
}
    func performREquest(urlstring: String){
        if let url = URL(string: urlstring){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: { data, res, err in
                self.handle(data: data, response: res, error: err)
            })
            task.resume()
        }
    }
    func handle(data : Data?, response: URLResponse?,error: Error?){
        if error != nil{
            print(error!)
            return
        }
        if let safeDate = data{
            let decoder = JSONDecoder()
            do{
                let data = try decoder.decode(MovieData.self, from: safeDate)
                delegate?.getMovieData(data: data)
            }catch{
                return
            }
        }
    }
}
