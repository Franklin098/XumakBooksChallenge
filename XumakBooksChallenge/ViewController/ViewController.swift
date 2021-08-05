//
//  ViewController.swift
//  XumakBooksChallenge
//
//  Created by Franklin Velásquez Fuentes on 5/08/21.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.callBooksService()
    }
    
    
    // MARK: - Helpers
    
    func callBooksService(){
        BooksService.listBooks { booksList in
            
            print("fetch from API \(booksList.count)")
        }
    }


}

