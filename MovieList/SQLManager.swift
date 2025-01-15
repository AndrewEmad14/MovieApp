//
//  SQLManager.swift
//  MovieList
//
//  Created by Andrew Emad on 14/01/2025.
//

import Foundation
import SQLite3
class SQLManager{
    static let sharedInstance = SQLManager()
     var dataBasePath:URL?
     var dataBase:OpaquePointer?
    private init (){
        print("created a global instance")
    }
     func setDBPath() {
        let fileManger = FileManager.default
        let urls = fileManger.urls(for: .documentDirectory, in: .userDomainMask)
        if let documentDirectory = urls.first{
            self.dataBasePath = documentDirectory.appendingPathComponent("MovieAppDataBase")
        }
    }
     func openDataBase()-> OpaquePointer?{
        var db:OpaquePointer?
         guard let dataBasePath = self.dataBasePath else {
            print("There is no DataBase")
            return nil
        }
        if sqlite3_open(dataBasePath.absoluteString, &db) == SQLITE_OK{
            print(dataBasePath.absoluteString)
            self.dataBase=db
            return db
        }else{
            print("Unable to open Data Base")
            return nil
        }
    }
     func createTable(){
        var createTableStatement: OpaquePointer?
        let createStatement="""
        create table MovieTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title String,
        Image Blob,
        rating Float,
        releaseYear int,
        genre String)
        """
         if sqlite3_prepare_v2(self.dataBase, createStatement, -1, &createTableStatement, nil) == SQLITE_OK{
            if sqlite3_step(createTableStatement) == SQLITE_DONE{
                print(" Table is created")
            }else{
                print(" Table wasnt created")
            }
        }else{
            print("create Statement isnt prepared")
        }
        sqlite3_finalize(createTableStatement)
    }
    func insertInTable(movie:Movie){
        var insertStatement:OpaquePointer?
        let insertStatementString = """
        INSERT INTO MovieTable (title,Image,rating,releaseYear,genre) VALUES(?,?,?,?,?);
        """
        if sqlite3_prepare_v2(dataBase, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK{
            var temp : NSString = movie.title as NSString
            sqlite3_bind_text(insertStatement, 1,temp.utf8String , -1, nil)
            sqlite3_bind_text(insertStatement, 2,(movie.ImageWithData! as NSData).bytes ,Int32(movie.ImageWithData!.count), nil)
            sqlite3_bind_double(insertStatement, 3, movie.rating)
            sqlite3_bind_int(insertStatement, 4, Int32(movie.releaseYear))
            temp = movie.genre as NSString
            sqlite3_bind_text(insertStatement, 5,temp.utf8String , -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("Successfully inserted now")
            } else{
                print("could not insert row")
            }
        }else{
            print("inset statement Not prepared")
        }
        sqlite3_finalize(insertStatement)
    }
    func dropTable (){
        var dropTableStatement: OpaquePointer?
        let dropStatement="""
        Drop Table MovieTable
        """
        if sqlite3_prepare_v2(self.dataBase, dropStatement, -1, &dropTableStatement, nil) == SQLITE_OK{
           if sqlite3_step(dropTableStatement) == SQLITE_DONE{
               print(" Table Dropped")
           }else{
               print(" didnt Drop")
           }
       }else{
           print("Drop Statement isnt prepared")
       }
       sqlite3_finalize(dropTableStatement)
    }
    func query()->[Movie]? {
      let queryStatementString="SELECT * FROM MovieTable;"
      var queryStatement: OpaquePointer?
        var movieList:[Movie]=[]
      if sqlite3_prepare_v2(dataBase, queryStatementString, -1, &queryStatement, nil) ==
          SQLITE_OK {
        while sqlite3_step(queryStatement) == SQLITE_ROW {
          
          let id = sqlite3_column_int(queryStatement, 0)
           guard let queryResultCol1 = sqlite3_column_text(queryStatement, 1) else {
              print("title Query result is nil")
              return nil
            }
            guard let queryResultCol2 = sqlite3_column_blob(queryStatement, 2) else {
              print("Image Query result is nil")
              return nil
            }
          let rating = sqlite3_column_double(queryStatement, 3)
            let releaseYear = sqlite3_column_int(queryStatement, 4)
            guard let queryResultCol5 = sqlite3_column_text(queryStatement, 5) else {
              print("Query result is nil")
              return nil
            }
          
          let title = String(cString: queryResultCol1)
          let Image = Data(bytes: queryResultCol2, count: Int(sqlite3_column_bytes(queryStatement, 2)))
          let genre = String(cString: queryResultCol5)
          var movie = Movie()
          movie.title = title
          movie.rating = rating
          movie.releaseYear=Int(releaseYear)
          movie.genre = genre
          movie.ImageWithData = Image
          movieList.append(movie)
          print("\nQuery Result:")
          print("id =\(id) title= \(title) Image=\(Image) rating=  \(rating) releaseYear \(releaseYear) genre= \(genre)")
          }
      } else {
        let errorMessage = String(cString: sqlite3_errmsg(dataBase))
        print("\nQuery is not prepared \(errorMessage)")
      }
      // 7
       return movieList
      
    }
   

    func delete(index : Int) {
    let deleteStatementString = "DELETE FROM MovieTable WHERE Id = \(index);"
      var deleteStatement: OpaquePointer?
      if sqlite3_prepare_v2(dataBase, deleteStatementString, -1, &deleteStatement, nil) ==
          SQLITE_OK {
        if sqlite3_step(deleteStatement) == SQLITE_DONE {
          print("\nSuccessfully deleted row.")
        } else {
          print("\nCould not delete row.")
        }
      } else {
        print("\nDELETE statement could not be prepared")
      }
      
      sqlite3_finalize(deleteStatement)
    }
    func closeConnection(){
        sqlite3_close(dataBase)
    }
    
}

