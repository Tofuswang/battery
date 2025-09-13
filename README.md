# Battery - Social Battery Level Tracker 🔋

A beautiful, interactive iOS app that helps you track and visualize your social energy levels with delightful animations, sounds, and haptic feedback.

<div align="center">

![Battery Level Demo](https://github.com/Tofuswang/battery/blob/main/assets/demo.gif)

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/Tofuswang/battery/blob/main/LICENSE)
[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org/)
[![iOS](https://img.shields.io/badge/iOS-17.0+-lightgrey.svg)](https://developer.apple.com/ios/)
[![Xcode](https://img.shields.io/badge/Xcode-15.0+-blue.svg)](https://developer.apple.com/xcode/)

</div>

## ✨ Features

- **Interactive Battery UI**: Beautiful glass-morphism battery design with real-time visual feedback
- **Emoji Expressions**: Dynamic emoji display based on your current energy level
- **Sound & Haptics**: Delightful sound effects and haptic feedback for an engaging experience  
- **Smooth Animations**: Fluid spring animations and transitions throughout the app
- **Persistent Storage**: Your battery level is automatically saved and restored
- **Accessibility**: Full VoiceOver support and accessibility labels
- **Multilingual**: Supports multiple languages through string localization

## 🎯 What's a Social Battery?

The concept of a "social battery" represents your mental and emotional energy for social interactions. Just like a phone battery:
- **100%**: Fully energized, ready for social activities
- **75%**: Still good energy, can handle most social situations  
- **50%**: Moderate energy, selective about social commitments
- **25%**: Low energy, prefer quiet activities
- **0%**: Completely drained, need alone time to recharge

This app helps you:
- Track your current social energy level
- Communicate your social capacity to others
- Be more mindful of your social energy management

## 📱 Screenshots

| Battery View | Info Screen | Concept Letter |
|---|---|---|
| ![Battery](assets/battery.png) | ![Info](assets/info.png) | ![Letter](assets/letter.png) |

## 🚀 Getting Started

### Prerequisites

- iOS 17.0+ (Note: Project currently set to iOS 26.0+, may need adjustment)
- Xcode 15.0+
- Swift 5.0+

### Installation

1. Clone the repository:
```bash
git clone https://github.com/Tofuswang/battery.git
cd battery
```

2. Open the project in Xcode:
```bash
open battery.xcodeproj
```

3. Update the development team in project settings:
   - Select the project in Xcode
   - Go to "Signing & Capabilities" 
   - Change the development team from the current one to your Apple Developer account

4. Build and run the project on your device or simulator

## 🏗️ Architecture

The app follows a clean SwiftUI architecture with these main components:

```
battery/
├── batteryApp.swift          # Main app entry point
├── ContentView.swift         # Primary battery interface
├── BatteryView.swift         # Custom battery UI component  
├── InfoView.swift            # Information and about screen
├── SoundManager.swift        # Sound effects management
├── Persistence.swift         # Core Data stack (if needed)
└── Assets.xcassets/          # App icons and assets
```

### Key Components

- **ContentView**: Main interface with battery slider, emoji display, and animations
- **BatteryView**: Custom glass-morphism battery component with fill animations
- **InfoView**: Detailed information screen with app concept explanation
- **SoundManager**: Handles system sounds for different battery levels and interactions

## 🎨 Design Philosophy

- **Glass Morphism**: Modern UI with translucent glass effects
- **Fluid Animations**: Spring-based animations for natural feel
- **Color Psychology**: Red (low), Yellow (medium), Green (high) battery colors
- **Inclusive Design**: Accessibility-first approach with VoiceOver support

## 🔧 Customization

### Adding New Sound Effects

```swift
// In SoundManager.swift
func playCustomSound(for percentage: Double) {
    let soundID: SystemSoundID = 1234 // Your sound ID
    AudioServicesPlaySystemSound(soundID)
}
```

### Modifying Battery Colors

```swift
// In BatteryView.swift
private var batteryColor: LinearGradient {
    switch percentage {
    case 0...20:
        return LinearGradient(colors: [.red, .orange], startPoint: .top, endPoint: .bottom)
    // Add your custom color ranges
    }
}
```

## 🌍 Localization

The app uses SwiftUI's built-in localization system. To add a new language:

1. Add a new `.strings` file for your language
2. Translate the following keys:
   - `app.title`
   - `battery.percentage` 
   - `battery.empty`
   - `battery.full`
   - And other keys found in the source code

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development Guidelines

1. Follow Swift coding conventions
2. Maintain accessibility support
3. Test on both simulator and physical devices
4. Update documentation for new features

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🎮 王豆腐的開源玩具品味規範 (Tofus Wang's Open Source Toy Guidelines)

### 使用條款 (Terms of Use)

這個專案是王豆腐 (Tofus Wang) 的開源玩具作品。你可以：

✅ **允許的使用方式 (What you CAN do):**
- 任意修改、重新分發、商業使用
- 收費販售改版作品
- 用於個人或商業專案
- 做任何你想做的事情

⚠️ **唯一要求 (The ONLY requirement):**

**如果你使用了這個專案的任何部分，必須在你的作品中明確標註：**

```
CC-BY 4.0 by Tofus Wang
Source: https://github.com/Tofuswang/battery
```

### 📢 重要聲明 (Important Notice)

> **王豆腐的承諾與警告 (Tofus Wang's Promise & Warning):**
> 
> 我很樂意分享我的開源玩具給大家玩，但請尊重這個簡單的標註要求。
> 
> **如果發現有人使用了我的專案卻沒有做到標註，下次我就不會再釋出原始碼了。**
> 
> 讓我們一起維護開源社群的互相尊重文化 🤝

### 🎨 標註範例 (Attribution Examples)

**在 App 的關於頁面中：**
```
本專案基於 Tofus Wang 的開源作品
CC-BY 4.0 by Tofus Wang
原始碼: https://github.com/Tofuswang/battery
```

**在專案 README 中：**
```markdown
## Credits
- Based on [Battery](https://github.com/Tofuswang/battery) 
- CC-BY 4.0 by Tofus Wang
```

**在程式碼註解中：**
```swift
// Based on Battery by Tofus Wang
// CC-BY 4.0 by Tofus Wang
// Source: https://github.com/Tofuswang/battery
```

### 🤝 為什麼這樣做？ (Why This Approach?)

- 鼓勵知識分享和創新
- 保持開源精神的同時給予原作者應有的認可
- 建立互相尊重的開發者社群
- 讓好的作品能被更多人看見和改進

記住：**創作不易，尊重不難** ❤️

## 👤 Author

**Fu-Syuan Wang (Tofus)**
- Instagram: [@tofuswang](https://www.instagram.com/tofuswang/)
- Buy Me a Coffee: [tofuswang](https://buymeacoffee.com/tofuswang)

## 🙏 Acknowledgments

- Inspired by the social battery concept from the neurodivergent community
- Built with SwiftUI and native iOS frameworks
- Special thanks to the iOS developer community for inspiration and support

## 📚 Additional Resources

- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui/)
- [iOS Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/)
- [Understanding Social Battery](https://www.gvm.com.tw/article/120015)

---

<div align="center">

Made with ❤️ and lots of ☕ by [Tofus](https://github.com/Tofuswang)

If this app helps you manage your social energy, consider [buying me a coffee](https://buymeacoffee.com/tofuswang) ☕

</div>