//
//  SearchViewController.swift
//  FilmTraining
//
//  Created by Huseyn Hasanov on 02.03.22.
//

import UIKit
import SDWebImage
class SearchViewController: UIViewController, UISearchBarDelegate {
    var movieManager = MovieManager()
    var dataCollected: MovieData?
    @IBOutlet weak var CollectionView: UICollectionView!{
        didSet{
            //porucayet,posilayet
            CollectionView.delegate = self
            CollectionView.dataSource = self
        }
    }
    @IBOutlet weak var Field: UISearchBar!{
        didSet{
            Field.delegate = self
        }
    }
    @IBOutlet weak var label: UILabel!{
        didSet{
            label.text = "MOVIE"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
 

        Field.delegate = self
        movieManager.delegate = self
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Field.endEditing(true)
        if searchBar.text != ""{
            movieManager.nameOfMOvie(title: searchBar.text ?? "")
            Field.text = ""
        }else{
            Field.placeholder = "Enter the movie"
        }
        print(Field.text!)
    }
}
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataCollected?.Search?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection", for: indexPath) as! CollectionViewCell
        cell.poster.sd_setImage(with: URL(string: (dataCollected?.Search?[indexPath.row].Poster)!), completed: nil)
        cell.titel.text = dataCollected?.Search?[indexPath.row].Title
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            Field.endEditing(true)
            print(Field.text!)
        }
        return cell
    }
    //segue kimi
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "InformationViewController") as! InformationViewController
        
        vc.ID = dataCollected?.Search?[indexPath.row].imdbID

        self.navigationController?.pushViewController(vc , animated: true)
    }
    //sekiler arasindaki mesafe
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/2 - 10, height: 300)
    }
}
extension SearchViewController: MovieDataProtocol{
    func getMovieData(data: MovieData) {
        self.dataCollected = data
        DispatchQueue.main.async {
            self.CollectionView.reloadData()
        }
    }
}
