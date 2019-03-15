//
//  CollectionViewController.swift
//  SearchingTable
//
//  Created by Buse ERKUŞ on 4.03.2019.
//  Copyright © 2019 Buse ERKUŞ. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MyCell"
private let searchBarHeight: Int = 40
class MyCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var array: [MyData] = []
    var filtered: [MyData] = []
    var isSearching: Bool = false
    var modRecord: Int = -1
    let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: searchBarHeight))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearsSelectionOnViewWillAppear = false
        
        let firstRecord = MyData(name: "Audrey", age: 39, gender: true)
        let secondRecord = MyData(name: "King", age: 28, gender: false)
        let thirdRecord = MyData(name: "Bucerella", age: 34, gender: true)
        let fourthRecord = MyData(name: "Brian", age: 21, gender: false)
        let fifthRecord = MyData(name: "Erella", age: 17, gender: false)


        array.append(firstRecord)
        array.append(secondRecord)
        array.append(thirdRecord)
        array.append(fourthRecord)
        array.append(fifthRecord)
        
        array.sort { $0.name < $1.name }
        
        navigationItem.title = "My Database"
        navigationController?.navigationBar.isTranslucent = false
        
        self.collectionView?.backgroundColor = .white
        
        // Register cell classes
        self.collectionView!.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addDetails))
        navigationItem.rightBarButtonItem = addButton
        
        
        view.addSubview(searchBar)
        searchBar.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        searchBar.text = ""
    }
    
    @objc func addDetails() {
        
        let detailVC = ViewController()
        detailVC.delegate = self
        detailVC.mode = .add
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func add(record: MyData) {
        
        array.append(record)
        array.sort { $0.name < $1.name }
        collectionView?.reloadData()
    }
    
    func modify(record: MyData) {
        if modRecord != -1{
            array.remove(at: modRecord)
            modRecord = -1
        }
        else{
             let indexPath = collectionView?.indexPathsForSelectedItems
             array.remove(at: indexPath![0].row)
        }
        
       
        array.append(record)
        array.sort { $0.name < $1.name }
        collectionView?.reloadData()
    }
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = ViewController()
        detailVC.delegate = self
        
        if isSearching{
            detailVC.record = filtered[indexPath.row]
            
            for record in array{
                modRecord += 1
                if record.name == filtered[indexPath.row].name{
                    break;
                }
            }
            
        }else{
            detailVC.record = array[indexPath.row]
            
        }
        
        detailVC.mode = .edit
        detailVC.record = array[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if isSearching{
            return filtered.count
        }
        return array.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MyCollectionViewCell
        cell.backgroundColor = .yellow
        
        if isSearching{
            cell.nameLabel.text = filtered[indexPath.row].name
        }else{
            cell.nameLabel.text = array[indexPath.row].name
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return(CGSize(width: view.bounds.width, height: 44))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return (CGSize(width: view.bounds.width, height: CGFloat(searchBarHeight)))
    }
    
}
