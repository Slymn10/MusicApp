//
//  MusicTableViewCell.swift
//  MusicApp
//
//  Created by Süleyman Koçak on 30.03.2020.
//  Copyright © 2020 Suleyman Kocak. All rights reserved.
//

import UIKit
import EMTNeumorphicView
import AVFoundation
var bombSoundEffect: AVAudioPlayer?
class MusicTableViewCell: UITableViewCell {

 
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var singerLabel: UILabel!
    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var playButton: EMTNeumorphicButton!

    

    override func awakeFromNib() {
        super.awakeFromNib()
        playButton.neumorphicLayer?.cornerRadius = 25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func playButtonPressed(_ sender: Any) {

    }

}
