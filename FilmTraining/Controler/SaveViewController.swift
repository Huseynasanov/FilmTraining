//
//  SaveViewController.swift
//  FilmTraining
//
//  Created by Huseyn Hasanov on 02.03.22.
//

import UIKit
import SDWebImage
class SaveViewController: UIViewController{
    var image:String?
    //save
    var picture = UserDefaults.standard.object(forKey: "SavedPictures") as? [String] ?? []
    var moviesName = UserDefaults.standard.object(forKey: "SavedNames") as? [String] ?? []
    var imdbId = UserDefaults.standard.object(forKey: "SavedImdb") as? [String] ?? []
    //
   
    override func viewDidAppear(_ animated: Bool) {
        //save,herdefe update elesin
        
        picture = UserDefaults.standard.object(forKey: "SavedPictures") as? [String] ?? []
        moviesName = UserDefaults.standard.object(forKey: "SavedNames") as? [String] ?? []
        imdbId = UserDefaults.standard.object(forKey: "SavedImdb") as? [String] ?? []
        collectionViewSave.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Save.text = "Movie Save"
    }
    @IBOutlet weak var Save: UILabel!
    @IBOutlet weak var collectionViewSave: UICollectionView!{
        didSet{
                collectionViewSave.delegate = self
                collectionViewSave.dataSource = self
        }
    }
}
extension  SaveViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesName.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collections", for: indexPath) as! CollectionViewCellSave
        cell.titleSave.text = moviesName[indexPath.row]//!
        print("Movie name\(moviesName[indexPath.row])")//!
        cell.imagaSave.sd_setImage(with: URL(string: picture[indexPath.row]), completed: nil)//!
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "InformationViewController") as! InformationViewController
        vc.ID = imdbId[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/2 - 10, height: 300)
    }
}
