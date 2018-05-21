//
//  BookListViewController.swift
//  Book Collector
//
//  Created by Lizzy on 2018/5/16.
//  Copyright © 2018年 L&L. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet var bookListTV: UITableView!
    
    var books : [Book] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        bookListTV.dataSource = self
        bookListTV.delegate = self
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            books = try context.fetch(Book.fetchRequest())
            bookListTV.reloadData()
        }  catch {
            print("!")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let book = books[indexPath.row]
        cell.textLabel?.text = book.name
        cell.imageView?.image = UIImage(data: book.image!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = books[indexPath.row]
        performSegue(withIdentifier: "bookSegue", sender: book)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! BookViewController
        nextVC.book = sender as? Book
    }
    
    
}
