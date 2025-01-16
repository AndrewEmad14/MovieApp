//
//  TableViewController.swift
//  MovieList
//
//  Created by Andrew Emad on 08/01/2025.
//

import UIKit
import SDWebImage
class TableViewController: UITableViewController ,addMovieProtocol{
    var movieList:[Movie]=[]

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
                    self.tableView.reloadData()
                }
            }catch{
                print(error)
            }
        }
        task.resume()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
       
        
        print(movieList.count)
        let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(self.addMovieButton))
     
           loadArrayFromWebsite(Url:  "https://www.freetestapi.com/api/v1/movies")

      
      
     //   sql.setDBPath()
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
        let myImageView = UIImageView()
        myImageView.sd_setImage(with: URL(string: movieList[indexPath.row].poster), placeholderImage: UIImage(named: "4"))
        content.image = myImageView.image
       /* if movieList[indexPath.row].ImageWithData != nil {
            content.image = UIImage(data: movieList[indexPath.row].ImageWithData!)
        }else{
            content.image = UIImage(named: "4")
       }*/
        
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
