//
//  MyCollview + Search.swift
//  SearchingTable
//
//  Created by Buse ERKUŞ on 4.03.2019.
//  Copyright © 2019 Buse ERKUŞ. All rights reserved.
//

import UIKit

extension MyCollectionViewController : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered.removeAll(keepingCapacity: false)
        let predicateString = searchBar.text!
        filtered = array.filter({$0.name.range(of: predicateString) != nil} )
        filtered.sort{$0.name < $1.name}
        isSearching = (filtered.count == 0) ? false:true
        collectionView.reloadData()
    }
    
    
}
