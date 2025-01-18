//
//  Movie.swift
//  MovieList
//
//  Created by Andrew Emad on 08/01/2025.
//

import Foundation



struct Movie : Codable{
  
    var title:String=""     //
    var rating:Double=0.0   //
    var year:Int=0          //
    var poster:String="4"   //
    var genre : [String] = []    //

   
    init(){
        
    }
    init(id: Int, title: String, rating: Double, year: Int, poster: String, genre: [String]) {
     
        self.title = title
        self.rating = rating
        self.year = year
        self.poster = poster
        self.genre = genre
  
    }
    
   
}
