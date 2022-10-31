//
//  MovieData.swift
//  FilmTraining
//
//  Created by Huseyn Hasanov on 02.03.22.
//

import Foundation
struct MovieData: Codable{
    let Search: [Search]?
}
struct Search : Codable{
    let Title: String?
    let Year: String?
    let Poster: String?
    let imdbID: String?
}

