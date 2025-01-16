//
//  Movie.swift
//  MovieList
//
//  Created by Andrew Emad on 08/01/2025.
//

import Foundation



struct Movie : Codable{
    var id:Int=0  //
    var title:String=""     //
    var rating:Double=0.0   //
    var year:Int=0          //
    var poster:String="4"   //
    var genre : [String] = []    //
    var actors :[String] = []
    var director:String=""
    var trailer:String=""
    var runtime:Int=0
    var awards:String=""
    var country:String=""
    var language:String=""
    var boxOffice:String=""
    var production:String=""
    var website:String=""
    var plot:String=""
    init(){
        
    }
    init(id: Int, title: String, rating: Double, year: Int, poster: String, genre: [String], director: String, trailer: String, runtime: Int, awards: String, country: String, language: String, boxOffice: String, production: String, website: String, actor: [String], plot: String) {
        self.id = id
        self.title = title
        self.rating = rating
        self.year = year
        self.poster = poster
        self.genre = genre
        self.director = director
        self.trailer = trailer
        self.runtime = runtime
        self.awards = awards
        self.country = country
        self.language = language
        self.boxOffice = boxOffice
        self.production = production
        self.website = website
        self.actors = actor
        self.plot = plot
    }
    
   
}
