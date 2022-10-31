//
//  MovieManagerINfo.swift
//  FilmTraining
//
//  Created by Huseyn Hasanov on 04.03.22.
//

import Foundation

protocol MovieDataInfoProtocol{
    func getMovieDataInfo(data: MovieDataInfo)
}
struct MovieManagerINfo{
    var delegate: MovieDataInfoProtocol?
    let MovieURL = "https://www.omdbapi.com/?&apikey=b8c9c906"
    func IdOfMOvie(Id: String){
        let urlStr = "\(MovieURL)&i=\(Id)"
        print(urlStr)
        performREquest(urlstring: urlStr)
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
                let data = try decoder.decode(MovieDataInfo.self, from: safeDate)
                delegate?.getMovieDataInfo(data: data)
            }catch{
                return
            }
        }
    }
}

