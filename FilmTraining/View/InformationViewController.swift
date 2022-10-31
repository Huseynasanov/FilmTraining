//
//  InformationViewController.swift
//  FilmTraining
//
//  Created by Huseyn Hasanov on 03.03.22.
//

import UIKit
import SDWebImage


class InformationViewController: UIViewController{

    var savedMoviesName: [String] = []
    var savedMoviesPicture: [String] = []
    var savedMoviesImdb: [String] = []
    var datacolectedInfo : MovieDataInfo?
    var MovieInfoManager = MovieManagerINfo()
    var ID : String?
    var image : String?
    var picrure = UserDefaults.standard.object(forKey: "SavedPictures") as? [String] ?? []
    var moviesName = UserDefaults.standard.object(forKey: "SavedNames") as? [String] ?? []
    var imdbId = UserDefaults.standard.object(forKey: "SavedImdb") as? [String] ?? []
    //button with image view
    @IBOutlet weak var saveButton: UIImageView!{
        didSet{
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
            saveButton.isUserInteractionEnabled = true
            saveButton.addGestureRecognizer(tap)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        picrure = UserDefaults.standard.object(forKey: "SavedPictures") as? [String] ?? []
        moviesName = UserDefaults.standard.object(forKey: "SavedNames") as? [String] ?? []
        imdbId = UserDefaults.standard.object(forKey: "SavedImdb") as? [String] ?? []
        
        if !(imdbId.contains(ID ?? "")){
            print("Hello")
            saveButton.image = UIImage(systemName: "bookmark")
        }else{
            
            saveButton.image = UIImage(systemName: "bookmark.fill")
    }
}
    @objc func tapped(_ sender: UITapGestureRecognizer){
        if !(savedMoviesImdb.contains(ID ?? "")){
            savedMoviesName.append(nametitle.text ?? "")
            savedMoviesImdb.append(ID ?? "")
            savedMoviesPicture.append(datacolectedInfo?.Poster ?? "")
            print("saved")
            //!!
            saveButton.image = UIImage(systemName: "bookmark.fill")
        }else{
            savedMoviesName.remove(at: savedMoviesName.firstIndex(of: nametitle.text ?? "")!)
            savedMoviesImdb.remove(at: savedMoviesImdb.firstIndex(of: ID ?? "")!)
            savedMoviesPicture.remove(at: savedMoviesPicture.firstIndex(of: datacolectedInfo?.Poster ?? "")!)
            //!!
            saveButton.image = UIImage(systemName: "bookmark")
        }
        //datalari doldurub
        UserDefaults.standard.set(savedMoviesName, forKey:  "SavedNames")//key!!
        UserDefaults.standard.set(savedMoviesPicture, forKey: "SavedPictures" )
        UserDefaults.standard.set(savedMoviesImdb,forKey: "SavedImdb")
        }
    //
    
    @IBOutlet weak var DEscriptionInfo: UILabel!
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var genreInfo: UILabel!
    @IBOutlet weak var runningtimeinfo: UILabel!
    @IBOutlet weak var BoxOfficeInfo: UILabel!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var starring: UILabel!
    @IBOutlet weak var writers: UILabel!
    @IBOutlet weak var bycreater: UILabel!
    @IBOutlet weak var nametitle: UILabel!
    @IBOutlet weak var awards: UILabel!
    
    
    @IBOutlet weak var AwardsInfo: UILabel!
    @IBOutlet weak var writtersINfo: UILabel!
    @IBOutlet weak var sttaringINfo: UILabel!
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var BoxOffice: UILabel!
    @IBOutlet weak var runningtime: UILabel!
    @IBOutlet weak var Genre: UILabel!
    @IBOutlet weak var repleaceData: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // save gore userdefaults isdedirik
        savedMoviesName = UserDefaults.standard.object(forKey: "SavedNames") as? [String] ?? []
        savedMoviesPicture = UserDefaults.standard.object(forKey: "SavedPictures") as? [String] ?? []
        savedMoviesImdb = UserDefaults.standard.object(forKey: "SavedImdb") as? [String] ?? []
        if savedMoviesImdb.contains(ID ?? ""){
            saveButton.image = UIImage(systemName: "bookmark.fill")
        }else{
            saveButton.image = UIImage(systemName: "bookmark")
        }
        //end
        MovieInfoManager.delegate = self
        repleaceData.text = "Replease Data:"
        Description.text = "Description:"
        BoxOffice.text = "Box Office:"
        runningtime.text = "Running Time:"
        Genre.text = "Genre:"
        sttaringINfo.text = "Starring:"
        AwardsInfo.text = "Awards:"
        writtersINfo.text = "Writters:"
        
        
        print(ID ?? "")
        MovieInfoManager.delegate = self
        MovieInfoManager.IdOfMOvie(Id: ID ?? "")
    }
 }


extension InformationViewController: MovieDataInfoProtocol{
    func getMovieDataInfo(data: MovieDataInfo){
        self.datacolectedInfo = data
        DispatchQueue.main.async {
            print("data \(data)")
            self.data.text = String(describing: data.Released ?? "N/A")
            self.genreInfo.text = String(describing: data.Genre ?? "N/A")
            self.runningtimeinfo.text = String(describing: data.Runtime ?? "N/A")
            self.DEscriptionInfo.text = String(describing: data.Plot ?? "N/A")
            self.starring.text = String(describing: data.Actors ?? "N/A")
            self.awards.text = String(describing: data.Awards ?? "N/A")
            self.writers.text = String(describing: data.Writer ?? "N/A")
            self.nametitle.text = String(describing: data.Title!)
            self.bycreater.text = data.Director ?? "N/A"
            self.BoxOfficeInfo.text = data.BoxOffice ?? "N/A"
            self.poster.sd_setImage(with: URL(string: data.Poster ?? ""), completed:nil)
        }
    }
}
