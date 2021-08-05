//
//  BooksService.swift
//  XumakBooksChallenge
//
//  Created by Franklin Velásquez Fuentes on 5/08/21.
//

import Foundation


struct BooksService {
    
    static func listBooks(completion: @escaping ([Book])->Void){
        guard let url = URL(string: Constants.BooksWebService.baseURL) else {return}
        URLSession.shared.dataTask(with: url){(data, response, error) in
            // check error
            // check response status 200 ok
            guard let data = data else {return}
            
            do{
                let booksList = try JSONDecoder().decode([Book].self, from: data)
                completion(booksList)
            } catch let decodingError {
                print("error in listBooks() API \(decodingError)")
            }
        }.resume()
    }
}
