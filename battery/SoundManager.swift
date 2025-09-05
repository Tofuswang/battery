import AVFoundation
import SwiftUI

class SoundManager {
    static let shared = SoundManager()
    private var audioPlayer: AVAudioPlayer?
    
    private init() {
        // Set up audio session for haptic and sound playback
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }
    
    func playSliderSound(for percentage: Double, isIncreasing: Bool) {
        if isIncreasing {
            // Fun rising sounds
            let sounds: [SystemSoundID] = [1113, 1114, 1115] // Pop sounds
            let randomSound = sounds.randomElement()!
            playSystemSound(soundID: randomSound)
        } else {
            // Funny falling sounds  
            playSystemSound(soundID: 1073) // Bubble pop sound
        }
    }
    
    func playTickSound(isIncreasing: Bool) {
        if isIncreasing {
            // Cute plop sound for increase
            playSystemSound(soundID: 1103) // Plop sound
        } else {
            // Drip sound for decrease (like battery draining)
            playSystemSound(soundID: 1070) // Drip sound
        }
    }
    
    func playMilestoneSound(for percentage: Double) {
        // Play special sounds at milestone percentages
        switch percentage {
        case 0:
            playSystemSound(soundID: 1073) // Sad deflating bubble sound
        case 100:
            playSystemSound(soundID: 1120) // Party popper sound  
        case 25, 50, 75:
            playSystemSound(soundID: 1118) // Celebration boing sound
        default:
            break
        }
    }
    
    private func playSystemSound(soundID: SystemSoundID) {
        AudioServicesPlaySystemSound(soundID)
    }
}