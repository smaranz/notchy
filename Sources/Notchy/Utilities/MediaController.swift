import Foundation
import AppKit
import MediaPlayer
import Combine
import SwiftUI
import CoreGraphics

struct NowPlayingInfo {
    let title: String
    let album: String?
    let artist: String
    let artwork: NSImage?
}

class MediaController: ObservableObject {
    @Published var isPlaying: Bool = false
    @Published var nowPlaying: NowPlayingInfo?
    
    private var cancellables = Set<AnyCancellable>()
    private let commandCenter = MPRemoteCommandCenter.shared()
    
    init() {
        setupMediaControls()
        updateNowPlaying()
        
        // Update every 2 seconds
        Timer.publish(every: 2, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.updateNowPlaying()
            }
            .store(in: &cancellables)
    }
    
    private func setupMediaControls() {
        commandCenter.playCommand.addTarget { [weak self] _ in
            self?.play()
            return .success
        }
        
        commandCenter.pauseCommand.addTarget { [weak self] _ in
            self?.pause()
            return .success
        }
        
        commandCenter.togglePlayPauseCommand.addTarget { [weak self] _ in
            self?.togglePlayPause()
            return .success
        }
        
        commandCenter.nextTrackCommand.addTarget { [weak self] _ in
            self?.skipNext()
            return .success
        }
        
        commandCenter.previousTrackCommand.addTarget { [weak self] _ in
            self?.skipPrevious()
            return .success
        }
    }
    
    func updateNowPlaying() {
        let nowPlayingInfo = MPNowPlayingInfoCenter.default().nowPlayingInfo
        
        if let info = nowPlayingInfo,
           let title = info[MPMediaItemPropertyTitle] as? String {
            let artist = info[MPMediaItemPropertyArtist] as? String ?? "Unknown Artist"
            let album = info[MPMediaItemPropertyAlbumTitle] as? String
            let artwork = info[MPMediaItemPropertyArtwork] as? MPMediaItemArtwork
            
            var image: NSImage?
            if let artwork = artwork {
                image = artwork.image(at: NSSize(width: 100, height: 100))
            }
            
            let playbackRate = info[MPNowPlayingInfoPropertyPlaybackRate] as? Double ?? 0
            let isCurrentlyPlaying = playbackRate > 0
            
            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 0.2)) {
                    self.nowPlaying = NowPlayingInfo(
                        title: title,
                        album: album,
                        artist: artist,
                        artwork: image
                    )
                    self.isPlaying = isCurrentlyPlaying
                }
            }
        } else {
            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 0.2)) {
                    self.nowPlaying = nil
                    self.isPlaying = false
                }
            }
        }
    }
    
    func play() {
        // Simulate media key press for play
        simulateMediaKey(keyCode: 0x7E) // Play key
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.updateNowPlaying()
        }
    }
    
    func pause() {
        // Simulate media key press for pause
        simulateMediaKey(keyCode: 0x7E) // Play/Pause key
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.updateNowPlaying()
        }
    }
    
    func togglePlayPause() {
        // Simulate media key press for play/pause toggle
        simulateMediaKey(keyCode: 0x7E) // Play/Pause key
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.updateNowPlaying()
        }
    }
    
    func skipNext() {
        // Simulate media key press for next track
        simulateMediaKey(keyCode: 0x7D) // Next track key
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.updateNowPlaying()
        }
    }
    
    func skipPrevious() {
        // Simulate media key press for previous track
        simulateMediaKey(keyCode: 0x7B) // Previous track key
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.updateNowPlaying()
        }
    }
    
    private func simulateMediaKey(keyCode: UInt16) {
        let source = CGEventSource(stateID: .hidSystemState)
        let keyDown = CGEvent(keyboardEventSource: source, virtualKey: keyCode, keyDown: true)
        let keyUp = CGEvent(keyboardEventSource: source, virtualKey: keyCode, keyDown: false)
        keyDown?.flags = .maskNonCoalesced
        keyDown?.post(tap: .cghidEventTap)
        keyUp?.post(tap: .cghidEventTap)
    }
}
