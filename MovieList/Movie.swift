//
//  Movie.swift
//  MovieList
//
//  Created by Andrew Emad on 08/01/2025.
//

import Foundation



struct Movie{
    var title:String=""
    var rating:Double=0.0
    var releaseYear:Int64=0
    var imageWithData:Data?
    var genre:String=""
    var defaultImage="4"
    init (){
        
    }
    init(title: String, Image: String, rating: Double, releaseYear: Int64, genre: String) {
        self.title = title
        self.rating = rating
        self.releaseYear = releaseYear
        self.genre = genre
    }
   
}
