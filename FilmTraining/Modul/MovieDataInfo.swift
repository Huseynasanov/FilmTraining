//
//  MovieDataInfo.swift
//  FilmTraining
//
//  Created by Huseyn Hasanov on 04.03.22.
//

import Foundation
struct MovieDataInfo: Codable{
    let Title: String?
    let Year: String?
    let Released: String?
    let Runtime: String?
    let Genre,Director,Writer,Actors,Plot,Country,Language,Awards,Poster,BoxOffice: String?
}

