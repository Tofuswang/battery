import SwiftUI

struct BatteryView: View {
    let percentage: Double
    
    private var batteryColor: LinearGradient {
        let colors: [Color]
        switch percentage {
        case 0...20:
            colors = [Color(red: 1.0, green: 0.3, blue: 0.3), Color(red: 0.9, green: 0.1, blue: 0.1)]
        case 21...50:
            colors = [Color(red: 1.0, green: 0.8, blue: 0.2), Color(red: 1.0, green: 0.6, blue: 0.0)]
        default:
            colors = [Color(red: 0.4, green: 0.9, blue: 0.4), Color(red: 0.2, green: 0.7, blue: 0.2)]
        }
        return LinearGradient(colors: colors, startPoint: .top, endPoint: .bottom)
    }
    
    private var fillHeight: CGFloat {
        CGFloat(percentage / 100.0)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Glass background
                RoundedRectangle(cornerRadius: 30)
                    .fill(.ultraThinMaterial)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(
                                LinearGradient(
                                    colors: [Color.white.opacity(0.6), Color.white.opacity(0.1)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 2
                            )
                    )
                    .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 10)
                
                // Inner glass container
                RoundedRectangle(cornerRadius: 26)
                    .fill(Color.white.opacity(0.05))
                    .padding(4)
                
                // Battery terminal with glass effect
                VStack(spacing: 0) {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.ultraThinMaterial)
                        .frame(width: 60, height: 16)
                        .offset(y: -8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.white.opacity(0.4), lineWidth: 1.5)
                                .frame(width: 60, height: 16)
                                .offset(y: -8)
                        )
                    Spacer()
                }
                
                // Battery fill with gradient
                VStack {
                    Spacer()
                    if percentage > 0 {
                        ZStack {
                            // Glow layer
                            RoundedRectangle(cornerRadius: 22)
                                .fill(batteryColor)
                                .frame(height: max(0, (geometry.size.height - 20) * fillHeight))
                                .blur(radius: 20)
                                .opacity(0.6)
                            
                            // Main fill layer
                            RoundedRectangle(cornerRadius: 22)
                                .fill(batteryColor)
                                .frame(height: max(0, (geometry.size.height - 20) * fillHeight))
                                .overlay(
                                    LinearGradient(
                                        colors: [Color.white.opacity(0.3), Color.clear],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                    .cornerRadius(22)
                                )
                        }
                        .padding(10)
                        .animation(.spring(response: 0.5, dampingFraction: 0.8), value: percentage)
                    }
                }
                
                // Glow effect at the top of fill
                if percentage > 5 {
                    VStack {
                        Spacer()
                            .frame(height: max(0, geometry.size.height * (1 - fillHeight) + 10))
                        
                        Ellipse()
                            .fill(
                                RadialGradient(
                                    colors: [Color.white.opacity(0.4), Color.clear],
                                    center: .center,
                                    startRadius: 0,
                                    endRadius: 30
                                )
                            )
                            .frame(width: geometry.size.width * 0.7, height: 20)
                            .blur(radius: 8)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 10)
                    .animation(.spring(response: 0.5, dampingFraction: 0.8), value: percentage)
                }
            }
        }
    }
}

struct BatteryView_Previews: PreviewProvider {
    static var previews: some View {
        BatteryView(percentage: 75)
            .frame(width: 200, height: 300)
            .background(Color.black)
    }
}