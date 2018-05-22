//
//  MainVC.swift
//  KindleLBTA
//
//  Created by Ruslan Suvorov on 5/19/18.
//  Copyright © 2018 Lets Build That App. All rights reserved.
//

import UIKit

class MainVC: UITableViewController {
    
    var books: [Book]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(BookCell.self, forCellReuseIdentifier: "cellId")
        tableView.tableFooterView = UIView()
        
        navigationItem.title = "Kindle"
        
        fetchBooks()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedBook = self.books?[indexPath.row]
        
        let layout = UICollectionViewFlowLayout()
        let bookPageController = BookPageController(collectionViewLayout: layout)
        
        bookPageController.book = selectedBook
        
        let navigationController = UINavigationController(rootViewController: bookPageController)
        present(navigationController, animated: true, completion: nil)
    }
    
    func fetchBooks() {
        
        if let url = URL(string: "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/kindle.json") {

            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if let err = error {
                    print("Failed to fetch external json books: ", err)
                    return
                }
                
                guard let data = data else {return}
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)

                    guard let bookDictionaries = json as? [[String: Any]] else {return}
                    
                    self.books = []
                    for bookDictionary in bookDictionaries {
                        let book = Book(dictionary: bookDictionary)
                        self.books?.append(book)
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                } catch let jsonError {
                    print("Failed to parse json", jsonError)
                }
                
            }).resume()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! BookCell
        
        let book = self.books?[indexPath.row]
        cell.book = book
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = books?.count else {return 0}
        return count
    }
}
