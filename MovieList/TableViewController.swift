//
//  TableViewController.swift
//  MovieList
//
//  Created by Andrew Emad on 08/01/2025.
//

import UIKit

class TableViewController: UITableViewController {
    var movieList:[Movie]=[]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        let tempMovie1 = Movie(title: "Mission impossible", Image: "1", rating: 3.3, releaseYear: 1966, genre: ["action","thriller"])
        let tempMovie2 = Movie(title: "Kung Fu panda", Image: "2", rating: 4, releaseYear: 2008, genre: ["action","animation","Family"])
        let tempMovie3 = Movie(title: "Home Alone ", Image: "3", rating: 4, releaseYear: 1990, genre: ["comedy","Family"])
       
        movieList.append(tempMovie1)
        movieList.append(tempMovie2)
        movieList.append(tempMovie3)
        print(movieList.count)
        
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
        content.image = UIImage(named: movieList[indexPath.row].Image)
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



  
 
}
