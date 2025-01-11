//
//  Movie.swift
//  MovieList
//
//  Created by Andrew Emad on 08/01/2025.
//

import Foundation



struct Movie{
    var title:String=""
    var Image:String=""
    var rating:Float=0.0
    var releaseYear:Int=0
    var genre:[String]
    init(title: String, Image: String, rating: Float, releaseYear: Int, genre: [String]) {
        self.title = title
        self.Image = Image
        self.rating = rating
        self.releaseYear = releaseYear
        self.genre = genre
    }
   
}
