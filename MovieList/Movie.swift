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
    var releaseYear:Int=0
    var ImageWithData:Data?
    var genre:String=""
    var defaultImage="4"
    init (){
        
    }
    init(title: String, Image: String, rating: Double, releaseYear: Int, genre: String) {
        self.title = title
        self.rating = rating
        self.releaseYear = releaseYear
        self.genre = genre
    }
   
}
