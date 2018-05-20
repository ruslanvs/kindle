//
//  MainVC.swift
//  KindleLBTA
//
//  Created by Ruslan Suvorov on 5/19/18.
//  Copyright © 2018 Lets Build That App. All rights reserved.
//

import UIKit

class Book {
    let title: String
    let author: String
    let pages: [Page]
    
    init(title: String, author: String, pages: [Page]) {
        self.title = title
        self.author = author
        self.pages = pages
    }
}

class Page {
    let number: Int
    let text: String
    
    init(number: Int, text: String) {
        self.number = number
        self.text = text
    }
}


class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        view.backgroundColor = .red
        
        let page1 = Page(number: 1, text: "Text for the first page")
        let page2 = Page(number: 2, text: "Text for the second page")
        
        let pages = [page1, page2]
        
        let book = Book(title: "Steeve Jobs", author: "Walter Isaacson", pages: pages)
        
        let firstPage = book.pages[0]
                
        let book2 = Book(title: "Bill Gates: A Biography", author: "Michael Beacraft", pages: [
            Page(number: 1, text: "Text for page 1"),
            Page(number: 2, text: "Text for page 2"),
            Page(number: 3, text: "Text for page 3"),
            Page(number: 4, text: "Text for page 4")
            ])
        
//        var pageCollection = [Page]()
//        pageCollection += book.pages
//        pageCollection += book2.pages
////        pageCollection.append(book2.pages)
//        for page in pageCollection {
//            print(page.text)
//        }
        
        for book in [book, book2]{
            print(book.title)
            for page in book.pages{
                print(page.text)
            }
        }
        
        
    }

    
}
