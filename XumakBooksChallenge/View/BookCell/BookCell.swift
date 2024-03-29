//
//  BookCell.swift
//  XumakBooksChallenge
//
//  Created by Franklin Velásquez Fuentes on 5/08/21.
//

import UIKit

class BookCell: UICollectionViewCell {
    
    // MARK: - UI Attributes
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorsNameLabel: UILabel!
    
    // MARK: - Data Atributes
    static let identifier = "BookCell"

    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Helpers
    
    static func nib() -> UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    func configure(with book:Book){
        self.titleLabel.text = book.title
        self.authorsNameLabel.text = book.author ?? ""
        if let imageUrl = book.imageURL {
            self.imageView.downloaded(from: imageUrl)
        }else {
            self.imageView.image = UIImage.init(named: "book_image")!
        }
    }

}



