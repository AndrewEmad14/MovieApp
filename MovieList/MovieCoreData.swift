//
//  MovieCoreData.swift
//  MovieList
//
//  Created by Andrew Emad on 18/01/2025.
//

import Foundation

struct MovieCoreData {
    
      var title:String=""     //
      var rating:Double=0.0   //
      var year:Int=0          //
      var poster=Data()  //
      var genre : String=""//
    init(){
        
    }
    init(title: String, rating: Double, year: Int, poster: Data = Data(), genre: String) {
        self.title = title
        self.rating = rating
        self.year = year
        self.poster = poster
        self.genre = genre
    }
  
   
      
}
