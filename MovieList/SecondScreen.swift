//
//  SecondScreen.swift
//  MovieList
//
//  Created by Andrew Emad on 08/01/2025.
//

import UIKit

class SecondScreen: UIViewController {
    @IBOutlet weak var secondScreenImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    var movieList:[Movie]=[]
    var index:Int=0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text=movieList[index].title
        ratingLabel.text = String(movieList[index].rating)
        releaseYearLabel.text=String(movieList[index].releaseYear)
        genreLabel.text=concatString(genre: movieList[index].genre)
        if movieList[index].Image == "4"{
            secondScreenImage.image=UIImage(data:  movieList[index].ImageWithData)
        }else{
            secondScreenImage.image=UIImage(named: movieList[index].Image)
        }
       
        
        
    }
    func concatString(genre:[String])->String{
        var temp:String=" "
        for i in genre{
            temp += i
            temp += ", "
        }
         
        return temp
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
