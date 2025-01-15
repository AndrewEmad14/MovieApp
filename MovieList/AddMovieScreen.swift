//
//  AddMovieScreen.swift
//  MovieList
//
//  Created by Andrew Emad on 11/01/2025.
//

import UIKit

class AddMovieScreen: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var title_field: UITextField!
    @IBOutlet weak var rating_field: UITextField!
    @IBOutlet weak var releaseYear_field: UITextField!
    @IBOutlet weak var genreField: UITextField!
    var delegate : addMovieProtocol?
    
    let imagePicker = UIImagePickerController()
    var imageData = Data()
    override func viewDidLoad() {
        super.viewDidLoad()
        movieImage.isUserInteractionEnabled=true //tap recognizer + user interaction enabled
        // Do any additional setup after loading the view.
    }
    @IBAction func insertImage(_ sender: Any) {
        imagePicker.delegate=self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage{
            movieImage.image=pickedImage
            imageData=pickedImage.pngData()!
            
        }
        dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }

    @IBAction func DoneEditingButton(_ sender: Any) {
        var movie = Movie()
        movie.title = title_field.text!
        movie.rating = Double(rating_field.text!)!
        movie.releaseYear=Int(releaseYear_field.text!)!
        movie.genre.append(genreField.text!)
        movie.ImageWithData=imageData
       
        delegate?.addMovie(aMovie: movie)
        self.dismiss(animated: true)
    }
    

}
