//
//  BookViewController.swift
//  Book Collector
//
//  Created by Lizzy on 2018/5/16.
//  Copyright © 2018年 L&L. All rights reserved.
//

import UIKit

class BookViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var bookImageView: UIImageView!
    
    @IBOutlet var bookNameText: UITextField!
    
    @IBOutlet var addUpdateButton: UIButton!
    
    @IBOutlet var deleteButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    var book : Book? = nil
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        if book != nil {
            bookImageView.image = UIImage(data: book!.image!)
            bookNameText.text = book!.name
            addUpdateButton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }
    }
    
    @IBAction func photoTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let bookImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        bookImageView.image = bookImage
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        if book != nil {
            book!.name = bookNameText.text
            book!.image = UIImageJPEGRepresentation(bookImageView.image!, 0.0)
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            navigationController?.popViewController(animated: true)
        } else {
            let book = Book(context: context)
            book.name = bookNameText.text
            book.image = UIImageJPEGRepresentation(bookImageView.image!, 0.0)
            
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        context.delete(book!)
         (UIApplication.shared.delegate as! AppDelegate).saveContext()
         navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        self.bookNameText.endEditing(true)
    }
    
}
