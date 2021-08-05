//
//  ViewController.swift
//  XumakBooksChallenge
//
//  Created by Franklin Velásquez Fuentes on 5/08/21.
//

import UIKit

class ViewController: BaseViewController {
    
    // MARK:  - UI Properties
    
    @IBOutlet  var booksCollectionView: UICollectionView!
    private let itemsPerRow: CGFloat = 1
    private let sectionInsets = UIEdgeInsets( top: 10.0,left: 10.0,bottom: 10.0,right: 10.0)
    private let searchController = UISearchController(searchResultsController: nil)
    private var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    // MARK: - Data Properties
    private var booksList = [Book]()
    private var filteredBooks = [Book]()
    

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpBooksCollectionView()
        self.setUpSearchController()
        self.callBooksService()
    }
    
    
    // MARK: - Helpers
    
    func setUpBooksCollectionView(){
        booksCollectionView.register(BookCell.nib(), forCellWithReuseIdentifier: BookCell.identifier)
        booksCollectionView.delegate = self
        booksCollectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 120)
        booksCollectionView.collectionViewLayout = layout
    }
    
    func setUpSearchController(){
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search a book"
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    func callBooksService(){
        self.showProgressView()
        BooksService.listBooks { booksList in
            DispatchQueue.main.async {
                self.booksList = booksList
                self.booksCollectionView.reloadData()
                self.removeProgressView()
            }
        }
    }

}

// MARK: - BooksCollectionView Protocols

extension ViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        booksCollectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return isFiltering ? self.filteredBooks.count : self.booksList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = booksCollectionView.dequeueReusableCell(withReuseIdentifier: BookCell.identifier, for: indexPath) as! BookCell
        let index = indexPath.row
        let book = isFiltering ? self.filteredBooks[index] : self.booksList[index]
        cell.configure(with: book)
        return cell
    }
}

extension ViewController:  UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.right * (itemsPerRow+1)
        let availableWidth = view.frame.width - paddingSpace
        let cellWidth = availableWidth / itemsPerRow
        let cellHight = cellWidth/3
        
        return CGSize(width: cellWidth, height: cellHight)
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
  }

// MARK: - SearchBar Protocols

extension ViewController: UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContent(for: searchBar.text!)
    }
    
    func filterContent(for searchText: String){
        
        filteredBooks = booksList.filter({ book in
            return  book.title.lowercased().contains(searchText.lowercased())
        })
        self.booksCollectionView.reloadData()
    }
    
    
}
