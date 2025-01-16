//
//  Movie.swift
//  MovieList
//
//  Created by Andrew Emad on 08/01/2025.
//

import Foundation

/*extension Movie{
    func getTitle()->String{
        return title!
    }
    func getReleseYear()->Int64{
        return releaseYear
    }
    func getRating()->Double{
        return rating
    }
    func getGenre(){
        return
    }
}*/
extension Movie{
  func  setTitle(title:String){
        self.title=title
    }
    func setReleaseYear(release: Int64){
        self.releaseYear=release
    }
    func setRating(rating: Double){
        self.rating=rating
    }
    func setGenre(genre: String){
        self.genre=genre
    }
    func setImage(image: Data){
        self.imageWithData=image
    }
}
/*struct Movie{
    var title:String=""
    var rating:Double=0.0
    var releaseYear:Int=0
    var imageWithData:Data?
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
   
}*/
