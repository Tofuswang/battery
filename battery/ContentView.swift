import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var batteryPercentage: Double = 50.0
    @AppStorage("socialBatteryLevel") private var savedBatteryLevel: Double = 50.0
    @State private var lastSoundPercentage: Double = 50.0
    @State private var previousPercentage: Double = 50.0
    @State private var showingInfo = false
    @State private var showingEmoji = false
    @State private var emojiScale: CGFloat = 0.5
    @State private var emojiOffset: CGFloat = 50
    @State private var emojiOpacity: Double = 0
    @State private var batteryRotation: Double = 0
    @State private var animationID = UUID()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Gradient background
                LinearGradient(
                    colors: [
                        Color(red: 0.05, green: 0.05, blue: 0.1),
                        Color(red: 0.02, green: 0.02, blue: 0.05)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                // Ambient light effects
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                Color.purple.opacity(0.1),
                                Color.clear
                            ],
                            center: .center,
                            startRadius: 50,
                            endRadius: 200
                        )
                    )
                    .frame(width: 400, height: 400)
                    .offset(x: -150, y: -200)
                    .blur(radius: 100)
                
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [
                                Color.blue.opacity(0.1),
                                Color.clear
                            ],
                            center: .center,
                            startRadius: 50,
                            endRadius: 200
                        )
                    )
                    .frame(width: 400, height: 400)
                    .offset(x: 150, y: 200)
                    .blur(radius: 100)
                
                VStack(spacing: 40) {
                    Spacer()
                    
                    Text("app.title", bundle: .main, comment: "App title")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                        .tracking(2)
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                    
                    ZStack {
                        BatteryView(percentage: batteryPercentage)
                            .frame(width: 200, height: 300)
                            .rotationEffect(.degrees(batteryRotation))
                            .animation(.spring(response: 0.1, dampingFraction: 0.3), value: batteryRotation)
                            .onTapGesture {
                                showEmojiAnimation()
                            }
                        
                        Text(currentEmoji)
                            .font(.system(size: 80))
                            .scaleEffect(emojiScale)
                            .offset(y: emojiOffset)
                            .opacity(emojiOpacity)
                            .animation(.spring(response: 0.4, dampingFraction: 0.6), value: emojiScale)
                            .animation(.spring(response: 0.4, dampingFraction: 0.6), value: emojiOffset)
                            .animation(.easeOut(duration: 0.3), value: emojiOpacity)
                            .id(animationID)
                    }
                    
                    VStack(spacing: 20) {
                        Text(String(format: NSLocalizedString("battery.percentage", bundle: .main, comment: "Battery percentage"), Int(batteryPercentage)))
                            .font(.system(size: 72, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                        
                        VStack(spacing: 10) {
                            ZStack {
                                // Slider track background
                                Capsule()
                                    .fill(Color.white.opacity(0.1))
                                    .frame(width: 280, height: 6)
                                
                                Slider(value: $batteryPercentage, in: 0...100, step: 1)
                                    .accentColor(sliderAccentColor)
                                    .frame(width: 280)
                                    .accessibilityLabel(Text("accessibility.slider", bundle: .main, comment: "Slider accessibility"))
                                    .accessibilityValue(String(format: NSLocalizedString("accessibility.battery", bundle: .main, comment: "Battery accessibility"), Int(batteryPercentage)))
                                    .onChange(of: batteryPercentage) { _, newValue in
                                        savedBatteryLevel = newValue
                                        
                                        // Determine direction
                                        // let isIncreasing = newValue > previousPercentage
                                        
                                        // Haptic feedback
                                        hapticFeedback()
                                        
                                        // Milestone sounds only
                                        let milestones = [0.0, 25.0, 50.0, 75.0, 100.0]
                                        if milestones.contains(newValue) {
                                            SoundManager.shared.playMilestoneSound(for: newValue)
                                        }
                                        
                                        // Update previous percentage
                                        previousPercentage = newValue
                                    }
                            }
                            
                            HStack {
                                Text("battery.empty", bundle: .main, comment: "Empty label")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                                Spacer()
                                Text("battery.full", bundle: .main, comment: "Full label")
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .frame(width: 280)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.bottom, 30)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingInfo = true }) {
                        Label("Info", systemImage: "info.circle")
                            .labelStyle(.iconOnly)
                    }
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
        }
        .onAppear {
            batteryPercentage = savedBatteryLevel
            lastSoundPercentage = savedBatteryLevel
            previousPercentage = savedBatteryLevel
        }
        .sheet(isPresented: $showingInfo) {
            InfoView()
        }
    }
    
    var sliderAccentColor: Color {
        switch batteryPercentage {
        case 0..<21:
            return Color(red: 1.0, green: 0.3, blue: 0.3)
        case 21..<50:
            return Color(red: 1.0, green: 0.7, blue: 0.2)
        default:
            return Color(red: 0.3, green: 0.9, blue: 0.3)
        }
    }
    
    func hapticFeedback() {
        let impact = UIImpactFeedbackGenerator(style: .light)
        impact.impactOccurred()
    }
    
    var currentEmoji: String {
        switch batteryPercentage {
        case 0..<17:
            return "😵"  // 完全沒電
        case 17..<34:
            return "😫"  // 很累
        case 34..<51:
            return "😕"  // 有點累
        case 51..<68:
            return "😐"  // 普通
        case 68..<85:
            return "🙂"  // 還不錯
        default:
            return "😄"  // 滿電
        }
    }
    
    func showEmojiAnimation() {
        // 每次點擊創建新的動畫實例
        animationID = UUID()
        
        // 觸覺回饋 - 更強烈的震動
        let impact = UIImpactFeedbackGenerator(style: .rigid)
        impact.prepare()
        impact.impactOccurred()
        
        // 播放點擊音效 - 隨機選擇可愛的 pop 音效
        let tapSounds: [SystemSoundID] = [1306, 1113, 1114, 1115]
        AudioServicesPlaySystemSound(tapSounds.randomElement()!)
        
        // 延遲一點播放電量音效
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            SoundManager.shared.playMilestoneSound(for: batteryPercentage)
        }
        
        // 電池震動效果
        batteryRotation = 0 // 重置
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            batteryRotation = -5
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            batteryRotation = 5
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            batteryRotation = -3
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            batteryRotation = 2
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            batteryRotation = 0
        }
        
        // 立即重置 emoji 狀態
        emojiScale = 0.3
        emojiOffset = -120
        emojiOpacity = 0
        
        // emoji 動畫序列
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                emojiScale = 1.2
                emojiOffset = -180
                emojiOpacity = 1
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
            withAnimation(.easeInOut(duration: 0.2)) {
                emojiScale = 1.0
                emojiOffset = -190
            }
        }
        
        // 1.2 秒後開始淡出
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            withAnimation(.easeOut(duration: 0.5)) {
                emojiOffset = -220
                emojiOpacity = 0
                emojiScale = 0.8
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}