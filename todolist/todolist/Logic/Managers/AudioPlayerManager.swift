//
//  AudioPlayerManager.swift
//  ToDoList
//
//  Created by Andrey Dovzhenko on 12.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import AVFoundation

final class AudioPlayerManager: NSObject {
    
    // MARK: - Public property
    
    var audioPlayer = AVAudioPlayer()
    
    //MARK: - Initialization
    
    static let shared = AudioPlayerManager()
    private override init() {}
    
    // MARK: - Public functions
    
    func setSound(_ name: String, _ type: String, _ infinity: Bool) {
        do {
            let file = Bundle.main.path(forResource: name, ofType: type)
            let url = URL(fileURLWithPath: file!)
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.numberOfLoops = infinity ? -1 : 0
            audioPlayer.play()
        } catch { print(error.localizedDescription) }
    }
}
