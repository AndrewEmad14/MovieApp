//
//  TableViewController.swift
//  MovieList
//
//  Created by Andrew Emad on 08/01/2025.
//

import UIKit
import SDWebImage
import CoreData

class TableViewController: UITableViewController ,addMovieProtocol{
    let reachability = try! Reachability()
    var movieList:[Movie]=[]
    var movieCoreDataList:[MovieCoreData]=[]
   let sql=SQLManager.sharedInstance
    func addMovie(aMovie: Movie) {
        //sql.insertInTable(movie: aMovie)
        movieList.append(aMovie)
        tableView.reloadData()
    }
    func loadArrayFromWebsite(Url str: String){
        let url=URL(string: str)
        let request = URLRequest(url: url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request) {
            data, response, error in
            do{
                let json = try JSONDecoder().decode([Movie].self, from: data!)
                
               /* var json = try JSONSerialization.jsonObject(with: data!) as! [[String:String]]
                var dict=json[0]*/
                //print("title: \(String(self.movieList[0].title))")
                
                DispatchQueue.main.async {
                    self.movieList=json
                    self.saveDataFromWebToCoreData()
                    self.tableView.reloadData()
                }
            }catch{
                print(error)
            }
        }
        task.resume()
        
    }
   func  loadArrayFromCoreData(){
       var ManagedMovies:[NSManagedObject]
       let appdelegate = UIApplication.shared.delegate as!AppDelegate
       let managedContext=appdelegate.persistentContainer.viewContext
       let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "MovieDB")
       do{
           ManagedMovies = try managedContext.fetch(fetchRequest)
           for i in ManagedMovies{
               var tempMovie = MovieCoreData()
               tempMovie.title = i.value(forKey: "title")as! String
               tempMovie.rating = i.value(forKey: "rating") as! Double
               tempMovie.year = Int(i.value(forKey: "year") as! Int64)
               tempMovie.genre = i.value(forKey: "genre") as! String
               tempMovie.poster = i.value(forKey: "poster") as! Data
               movieCoreDataList.append(tempMovie)
           }
       }catch let error as NSError{
           print(error)
       }
 
       tableView.reloadData()
    }
    func concatStrArray(array:[String])->String{
        var temp:String=""
        for i in array{
            temp += i
            temp += ","
        }
        return temp
    }
    func saveDataFromWebToCoreData(){
        for movie in movieList{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let manager: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
            // entity
            let movieEntity = NSEntityDescription.entity(forEntityName: "MovieDB", in: manager)
            let movieDB = NSManagedObject(entity: movieEntity!, insertInto: manager)
            let tempGenre=concatStrArray(array: movie.genre)
            let myImageView = UIImageView()
            myImageView.sd_setImage(with: URL(string: movie.poster), placeholderImage: UIImage(named: "4"))
            let tempImageData=myImageView.image?.pngData()
            movieDB.setValue(movie.title, forKey: "title")
            movieDB.setValue(movie.rating, forKey: "rating")
            movieDB.setValue(movie.year, forKey: "year")
            movieDB.setValue(tempImageData, forKey: "poster")
            movieDB.setValue(tempGenre, forKey: "genre")
            do{
                try manager.save()
               
            }catch let error{
                print(error)
            }
        }
      
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(self.addMovieButton))
        self.navigationItem.rightBarButtonItem = addButton
       
      
            reachability.whenReachable = { reachability in
                if reachability.connection == .wifi {
                    self.loadArrayFromWebsite(Url:  "https://www.freetestapi.com/api/v1/movies")
                } else {
                    print("Reachable via Cellular")
                }
            }
            reachability.whenUnreachable = { _ in
                self.loadArrayFromCoreData()
            }

            do {
                try reachability.startNotifier()
            } catch {
                print("Unable to start notifier")
            }

      
        
        
    }
    @objc func reachabilityChanged(note: Notification) {

      let reachability = note.object as! Reachability

      switch reachability.connection {
      case .wifi:
          print("Reachable via WiFi")
      case .cellular:
          print("Reachable via Cellular")
      case .unavailable:
        print("Network not reachable")
      }
    }
    @objc func addMovieButton (){
          let view : AddMovieScreen=self.storyboard?.instantiateViewController(withIdentifier: "third") as! AddMovieScreen
          view.delegate=self
          self.present(view, animated: true)
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if movieList.count != 0{
            return movieList.count

        }
        if movieCoreDataList.count != 0{
            return movieCoreDataList.count

        }
        return 0
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        let myImageView = UIImageView()
        if movieList.count != 0{
            content.text = movieList[indexPath.row].title
            myImageView.sd_setImage(with: URL(string: movieList[indexPath.row].poster), placeholderImage: UIImage(named: "4"))
        }else if movieCoreDataList.count != 0{
            content.text = movieCoreDataList[indexPath.row].title
           
            myImageView.image=UIImage(data: movieCoreDataList[indexPath.row].poster)
        }
      
        content.image = myImageView.image
      
        
        content.imageProperties.maximumSize = CGSize(width: 90, height: 149)
        content.imageProperties.cornerRadius = 20
        cell.contentConfiguration=content
       

        return cell
    }
    override func tableView(_ tableView: UITableView, performPrimaryActionForRowAt indexPath: IndexPath) {
        let view : SecondScreen = self.storyboard?.instantiateViewController(withIdentifier: "second") as! SecondScreen
        
        view.movieList=movieList
        view.movieCoreDataList=movieCoreDataList
        view.index=indexPath.row
        self.navigationController?.pushViewController(view, animated: true)
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            movieList.remove(at: indexPath.row)
        
           // sql.delete(index:indexPath.row)
            //sql.resetSequence(aMovie: movieList)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }


  
 
}
