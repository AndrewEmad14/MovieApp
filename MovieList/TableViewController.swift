//
//  TableViewController.swift
//  MovieList
//
//  Created by Andrew Emad on 08/01/2025.
//

import UIKit
import CoreData
class TableViewController: UITableViewController ,addMovieProtocol{
    
   // let sql=SQLManager.sharedInstance
    func addMovie(aMovie: Movie) {
    //    sql.insertInTable(movie: aMovie)
        movieList.append(aMovie)
        tableView.reloadData()
    }
    
    var movieList:[Movie]=[]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
       
        
        print(movieList.count)
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(self.addMovieButton))
        var ManagedMovies:[NSManagedObject]
        let appdelegate = UIApplication.shared.delegate as!AppDelegate
        let managedContext=appdelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Movies")
        do{
            ManagedMovies = try managedContext.fetch(fetchRequest)
            for i in ManagedMovies{
                var tempMovie = Movie()
                tempMovie.title = i.value(forKey: "title")as! String
                tempMovie.rating = i.value(forKey: "rating") as! Double
                tempMovie.releaseYear = i.value(forKey: "releaseYear") as! Int64
                tempMovie.genre = i.value(forKey: "genre") as! String
                tempMovie.imageWithData = i.value(forKey: "imageWithData") as? Data
                movieList.append(tempMovie)
            }
        }catch let error as NSError{
            print(error)
        }
       
 
       // sql.setDBPath()
       // sql.openDataBase()
       // sql.dropTable()
        //sql.createTable()
       
        
      /*  if sql.query() != nil{
            
            movieList=sql.query()!
            print(movieList.count)

        }else{
            print("table is empty")
        }
    
        //sql.query()
        sql.closeConnection()*/
   
      
       

       
        self.navigationItem.rightBarButtonItem = addButton
        
        
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
        return movieList.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
       // cell.textLabel!.text=movieList[indexPath.row].title
       // cell.imageView!.image = UIImage(named: movieList[indexPath.row].Image)
      // print(content.text!)
        content.text = movieList[indexPath.row].title
        if movieList[indexPath.row].imageWithData != nil {
            content.image = UIImage(data: movieList[indexPath.row].imageWithData!)
        }else{
            content.image = UIImage(named: "4")
       }
        
        content.imageProperties.maximumSize = CGSize(width: 90, height: 149)
        content.imageProperties.cornerRadius = 20
        cell.contentConfiguration=content
        // Configure the cell...

        return cell
    }
    override func tableView(_ tableView: UITableView, performPrimaryActionForRowAt indexPath: IndexPath) {
        let view : SecondScreen = self.storyboard?.instantiateViewController(withIdentifier: "second") as! SecondScreen
        view.movieList=movieList
        view.index=indexPath.row
        self.navigationController?.pushViewController(view, animated: true)
    }
 /*   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            movieList.remove(at: indexPath.row)
           // sql.delete(index:indexPath.row)
           // sql.resetSequence(aMovie: movieList)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }*/


  
 
}
