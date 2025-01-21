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
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var actorsLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var trailerLabel: UILabel!
    @IBOutlet weak var runtime: UILabel!
    @IBOutlet weak var awards: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var boxOfficeLabel: UILabel!
    @IBOutlet weak var productionLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!
    var movieList:[Movie]=[]
    var movieCoreDataList:[MovieCoreData]=[]
    var index:Int=0

    override func viewDidLoad() {
        super.viewDidLoad()
        //UserDefaults.standard.set(["ar"], forKey: "AppleLanguages")
       // UserDefaults.standard.synchronize()
        // Do any additional setup after loading the view.
        if movieList.count != 0 {
            titleLabel.text=movieList[index].title
            ratingLabel.text = String(movieList[index].rating)
            releaseYearLabel.text=String(movieList[index].year)
            secondScreenImage.sd_setImage(with: URL(string: movieList[index].poster), placeholderImage: UIImage(named: "4"))
            genreLabel.text=concatString(genre: movieList[index].genre)
           
        } else if movieCoreDataList.count != 0 {
            titleLabel.text=movieCoreDataList[index].title
            ratingLabel.text = String(movieCoreDataList[index].rating)
            releaseYearLabel.text=String(movieCoreDataList[index].year)
            secondScreenImage.image=UIImage(data: movieCoreDataList[index].poster)
            genreLabel.text=movieCoreDataList[index].genre
        }
        
        self.navigationItem.title=NSLocalizedString("NavTitle", comment: "")
     
        print(self.navigationItem.title)
      

 
        
        
    }
    func concatString(genre:[String])->String{
        var temp:String=" "
        for i in genre{
            temp += i
            temp += ", "
        }
         
        return temp
    }


}
