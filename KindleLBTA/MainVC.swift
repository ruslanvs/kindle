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
        
        setupNavigationBarStyles()
        setupNavBarButtons()
        
        tableView.register(BookCell.self, forCellReuseIdentifier: "cellId")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(white: 1, alpha: 0.3)
        tableView.separatorColor = UIColor(white: 1, alpha: 0.2)
        
        navigationItem.title = "Kindle"
        
        
        fetchBooks()
        
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        
        let segmentedControl = UISegmentedControl(items: ["Cloud", "Device"])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(segmentedControl)
        segmentedControl.tintColor = .white
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: footerView.centerXAnchor).isActive = true
        segmentedControl.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        
        let gridButton = UIButton(type: .system)
        gridButton.setImage(#imageLiteral(resourceName: "icons8-grid-filled-90"), for: .normal)
        gridButton.tintColor = .white
        gridButton.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(gridButton)
        
        gridButton.leftAnchor.constraint(equalTo: footerView.leftAnchor, constant: 8).isActive = true
        gridButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        gridButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        gridButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        
        let sortButton = UIButton(type: .system)
        sortButton.setImage(#imageLiteral(resourceName: "icons8-up-down-arrow-90"), for: .normal)
        sortButton.tintColor = .white
        sortButton.translatesAutoresizingMaskIntoConstraints = false
        footerView.addSubview(sortButton)
        
        sortButton.rightAnchor.constraint(equalTo: footerView.rightAnchor, constant: -8).isActive = true
        sortButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        sortButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sortButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor).isActive = true
        
        
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func setupNavBarButtons(){

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-menu-90").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector (handleMenuPressed))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-menu-90").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector (handleMenuPressed))
        
    }
    
    @objc func handleMenuPressed() {
        print("Menu pressed")
    }
    
    func setupNavigationBarStyles(){
        navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 40/255, blue: 40/255, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
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
