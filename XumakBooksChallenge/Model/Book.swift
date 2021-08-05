//
//  Book.swift
//  XumakBooksChallenge
//
//  Created by Franklin Velásquez Fuentes on 5/08/21.
//

import Foundation


struct Book: Decodable{
    let title: String
    let imageURL: String?
    let author: String?
}
