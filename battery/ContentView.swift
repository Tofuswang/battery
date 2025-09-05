import SwiftUI

struct ContentView: View {
    @State private var batteryPercentage: Double = 50.0
    @AppStorage("socialBatteryLevel") private var savedBatteryLevel: Double = 50.0
    @State private var lastSoundPercentage: Double = 50.0
    @State private var previousPercentage: Double = 50.0
    @State private var showingInfo = false
    
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
                    
                    BatteryView(percentage: batteryPercentage)
                        .frame(width: 200, height: 300)
                    
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
                                    .onChange(of: batteryPercentage) { newValue in
                                        savedBatteryLevel = newValue
                                        
                                        // Determine direction
                                        let isIncreasing = newValue > previousPercentage
                                        
                                        // Haptic feedback
                                        hapticFeedback()
                                        
                                        // Continuous sound feedback
                                        let percentageDiff = abs(newValue - lastSoundPercentage)
                                        
                                        // Play tick for every 1% change
                                        if percentageDiff >= 1 {
                                            SoundManager.shared.playTickSound(isIncreasing: isIncreasing)
                                        }
                                        
                                        // Play whistle sound for every 5% change
                                        if percentageDiff >= 5 {
                                            SoundManager.shared.playSliderSound(for: newValue, isIncreasing: isIncreasing)
                                            lastSoundPercentage = newValue
                                        }
                                        
                                        // Milestone sounds
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
        case 0...20:
            return Color(red: 1.0, green: 0.3, blue: 0.3)
        case 21...50:
            return Color(red: 1.0, green: 0.7, blue: 0.2)
        default:
            return Color(red: 0.3, green: 0.9, blue: 0.3)
        }
    }
    
    func hapticFeedback() {
        let impact = UIImpactFeedbackGenerator(style: .light)
        impact.impactOccurred()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}