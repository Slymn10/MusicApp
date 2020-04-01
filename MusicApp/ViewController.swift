//
//  ViewController.swift
//  MusicApp
//
//  Created by Süleyman Koçak on 30.03.2020.
//  Copyright © 2020 Suleyman Kocak. All rights reserved.
//

import UIKit
import EMTNeumorphicView
import AVFoundation
class ViewController: UIViewController , AVAudioPlayerDelegate {
    @IBOutlet weak var backButton: EMTNeumorphicButton!

    @IBOutlet weak var likeButton: EMTNeumorphicButton!
    @IBOutlet weak var middleImageButton: EMTNeumorphicButton!

    @IBOutlet weak var shuffleButton: UIButton!

    @IBOutlet weak var forwardButton: EMTNeumorphicButton!

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var songLabel: UILabel!
    
    var currentSoundsIndex: Int = 0
    var indextPath : IndexPath?


    let gangnamstyle = Music(musicFileName: "gangnamstyle", musicImage: UIImage(named:"gangnamstyleImg")!, singerName: "Psy", songName: "Gangnam Style")
    let senorita = Music(musicFileName: "senorita", musicImage: UIImage(named:"senoritaImg")!, singerName: "Shawn Mendes", songName: "Senorita")
    let shapeofyou = Music(musicFileName: "shapeofyou", musicImage: UIImage(named:"shapeofyouImg")!, singerName: "Ed Sheeran", songName: "Shape Of You")
    let uptownfunk = Music(musicFileName: "uptownfunk", musicImage: UIImage(named:"uptownfunkImg")!, singerName: "Mark Ronson", songName: "Uptown Funk")
    let wakawaka = Music(musicFileName: "wakawaka", musicImage: UIImage(named:"wakawakaImg")!, singerName: "Shakira", songName: "Waka Waka")
    var musicArray = [Music]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        musicArray = [gangnamstyle,senorita,shapeofyou,uptownfunk,wakawaka]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(red:0.87, green:0.89, blue:0.92, alpha:1.00)
        shuffleButton.layer.cornerRadius = 25
        view.backgroundColor = UIColor(red:0.87, green:0.89, blue:0.92, alpha:1.00)
        [backButton,forwardButton,likeButton].forEach { (button) in
            button?.neumorphicLayer?.cornerRadius = 25
        }
        middleImageButton.neumorphicLayer?.cornerRadius = 0.5 * middleImageButton.bounds.size.width
//        middleImageButton.neumorphicLayer?.cornerRadius = 80
        middleImageButton.imageView?.layer.cornerRadius = 0.5 * middleImageButton.bounds.size.width
        middleImageButton.clipsToBounds = true


    }

    
    @IBAction func shuffleButtonPressed(_ sender: UIButton) {
        musicArray.shuffle()
        tableView.reloadData()
    }
    func play(){
        middleImageButton.setImage(self.musicArray[currentSoundsIndex].musicImage, for: .normal)
        songLabel.text = "\(musicArray[currentSoundsIndex].singerName) , \(musicArray[currentSoundsIndex].songName)"
        if bombSoundEffect?.isPlaying == true {
            bombSoundEffect?.stop()

        }
        let path = Bundle.main.path(forResource: "\(musicArray[currentSoundsIndex].musicFileName).mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do {
            bombSoundEffect = try AVAudioPlayer(contentsOf: url)
            bombSoundEffect?.play()
        } catch {
            // couldn't load file :(
        }
    }

    @IBAction func forwardButtonPressed(_ sender: Any) {
        if currentSoundsIndex < musicArray.count - 1{
            currentSoundsIndex += 1
            play()
        }else{
            currentSoundsIndex = 0
           play()
        }

    }

    @IBAction func backButtonPressed(_ sender: Any) {
        if currentSoundsIndex < musicArray.count && currentSoundsIndex != 0{
            currentSoundsIndex -= 1
            play()
        }else{
            currentSoundsIndex = musicArray.count - 1
            play()
        }
    }


}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as! MusicTableViewCell
        cell.backgroundColor = UIColor(red:0.87, green:0.89, blue:0.92, alpha:1.00)
        cell.singerLabel.text = musicArray[indexPath.row].singerName
        cell.songLabel.text = musicArray[indexPath.row].songName
        cell.musicImage.image = musicArray[indexPath.row].musicImage
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentSoundsIndex = indexPath.row
        indextPath = indexPath
        playSound(index : indexPath)
    }
    func  playSound(index:IndexPath?){
        middleImageButton.setImage(self.musicArray[currentSoundsIndex].musicImage, for: .normal)
        songLabel.text = "\(musicArray[currentSoundsIndex].singerName), \(musicArray[currentSoundsIndex].songName)"
        if bombSoundEffect?.isPlaying == true {
            (self.tableView.cellForRow(at: index!) as! MusicTableViewCell).playButton.setImage(UIImage.init(systemName: "play.fill"), for: .normal)
            bombSoundEffect?.stop()
            return
        }
        let path = Bundle.main.path(forResource: "\(musicArray[currentSoundsIndex].musicFileName).mp3", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do {
            bombSoundEffect = try AVAudioPlayer(contentsOf: url)
            (self.tableView.cellForRow(at: index!) as! MusicTableViewCell).playButton.setImage(UIImage.init(systemName: "pause.fill"), for: .normal)
            bombSoundEffect?.play()
        } catch {
            // couldn't load file :(
        }
    }
}

