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
        
        setupBooks()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        let book = self.books?[indexPath.row]
        
        cell.textLabel?.text = book?.title
        cell.imageView?.image = book?.image
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = books?.count else {return 0}
        return count
    }
    
    func setupBooks(){
        let page1 = Page(number: 1, text: "Text for the first page")
        let page2 = Page(number: 2, text: "Text for the second page")
        
        let pages = [page1, page2]
        
        let book = Book(title: "Steeve Jobs", author: "Walter Isaacson", image: #imageLiteral(resourceName: "steeveJobs"), pages: pages)
        
        let book2 = Book(title: "Bill Gates: A Biography", author: "Michael Beacraft", image: #imageLiteral(resourceName: "billGates"), pages: [
            Page(number: 1, text: "Text for page 1"),
            Page(number: 2, text: "Text for page 2"),
            Page(number: 3, text: "Text for page 3"),
            Page(number: 4, text: "Text for page 4")
            ])
        
        self.books = [book, book2]
        
    }
}
