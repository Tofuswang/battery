import SwiftUI

struct InfoView: View {
    @Environment(\.dismiss) var dismiss
    @State private var animateIn = false
    @State private var showingLetterSheet = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    // Hero Header with App Icon
                    VStack(spacing: 24) {
                        // Animated Battery Icon
                        ZStack {
                            // Glow effect
                            Circle()
                                .fill(
                                    RadialGradient(
                                        colors: [
                                            Color.blue.opacity(0.3),
                                            Color.clear
                                        ],
                                        center: .center,
                                        startRadius: 20,
                                        endRadius: 60
                                    )
                                )
                                .frame(width: 120, height: 120)
                                .blur(radius: 20)
                                .scaleEffect(animateIn ? 1.2 : 0.8)
                            
                            // Battery icon container
                            ZStack {
                                Circle()
                                    .fill(.ultraThinMaterial)
                                    .frame(width: 90, height: 90)
                                
                                Image(systemName: "battery.75")
                                    .font(.system(size: 40, weight: .medium))
                                    .foregroundStyle(
                                        LinearGradient(
                                            colors: [Color.green, Color.teal],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        )
                                    )
                                    .rotationEffect(.degrees(-90))
                            }
                            .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 10)
                        }
                        .scaleEffect(animateIn ? 1 : 0.9)
                        .opacity(animateIn ? 1 : 0)
                        
                        VStack(spacing: 8) {
                            Text("info.title", bundle: .main, comment: "Info title")
                                .font(.system(size: 28, weight: .bold, design: .rounded))
                            
                            Text("info.subtitle", bundle: .main, comment: "Info subtitle")
                                .font(.body)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .opacity(animateIn ? 1 : 0)
                        .offset(y: animateIn ? 0 : 20)
                    }
                    .padding(.top, 30)
                    .padding(.bottom, 40)
                    .padding(.horizontal, 24)
                    
                    // Content Cards
                    VStack(spacing: 16) {
                        // What is this?
                        InfoCard(
                            icon: "questionmark.circle.fill",
                            iconColor: .blue,
                            title: "info.what.title",
                            content: "info.what.description",
                            delay: 0.1
                        )
                        
                        // How to use
                        InfoCard(
                            icon: "hand.draw.fill",
                            iconColor: .green,
                            title: "info.how.title",
                            items: [
                                "info.how.adjust",
                                "info.how.sound",
                                "info.how.language"
                            ],
                            delay: 0.2
                        )
                        
                        // Why this exists
                        InfoCard(
                            icon: "heart.fill",
                            iconColor: .pink,
                            title: "info.why.title",
                            content: "info.why.description",
                            delay: 0.3
                        )
                        
                        // Letter to Audience
                        Button(action: { showingLetterSheet = true }) {
                            HStack {
                                Image(systemName: "envelope.fill")
                                    .font(.title2)
                                    .foregroundColor(.purple)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("concept.title", bundle: .main, comment: "Concept title")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    Text("concept.subtitle", bundle: .main, comment: "Concept subtitle")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "arrow.right.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.purple.opacity(0.5))
                            }
                            .padding(20)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color(UIColor.secondarySystemBackground))
                                    .shadow(color: .black.opacity(0.03), radius: 20, x: 0, y: 10)
                            )
                        }
                        .buttonStyle(ScaleButtonStyle())
                        .scaleEffect(animateIn ? 1 : 0.95)
                        .opacity(animateIn ? 1 : 0)
                        .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.4), value: animateIn)
                        
                        // Author & Call to Action
                        VStack(spacing: 16) {
                            HStack {
                                Image(systemName: "person.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.orange)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("info.author.title", bundle: .main, comment: "Author title")
                                        .font(.headline)
                                    Text("info.author.subtitle", bundle: .main, comment: "Author subtitle")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 16)
                            
                            Text("info.author.bio", bundle: .main, comment: "Author bio")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineSpacing(4)
                                .padding(.horizontal, 20)
                            
                            // Call to Action
                            Text("info.author.cta", bundle: .main, comment: "CTA")
                                .font(.body.bold())
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 20)
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color(UIColor.secondarySystemBackground))
                                )
                                .padding(.horizontal, 20)
                            
                            // Connect Links
                            VStack(alignment: .leading, spacing: 12) {
                                Text("info.connect", bundle: .main, comment: "Connect")
                                    .font(.subheadline.bold())
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal, 20)
                                
                                VStack(spacing: 8) {
                                    LinkButton(
                                        icon: "camera.fill",
                                        iconColor: .purple,
                                        title: "Instagram",
                                        subtitle: "@tofuswang",
                                        url: "https://www.instagram.com/tofuswang/"
                                    )
                                    
                                    LinkButton(
                                        icon: "newspaper.fill",
                                        iconColor: .blue,
                                        title: "info.media.title",
                                        subtitle: "info.media.source",
                                        url: "https://www.gvm.com.tw/article/120015"
                                    )
                                }
                            }
                            .padding(.bottom, 8)
                        }
                        .padding(.vertical, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 24)
                                .fill(.ultraThinMaterial)
                                .shadow(color: .black.opacity(0.05), radius: 20, x: 0, y: 10)
                        )
                        .scaleEffect(animateIn ? 1 : 0.95)
                        .opacity(animateIn ? 1 : 0)
                        .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.5), value: animateIn)
                        
                        // Support Section
                        Link(destination: URL(string: "https://buymeacoffee.com/tofuswang")!) {
                            HStack(spacing: 16) {
                                ZStack {
                                    Circle()
                                        .fill(
                                            LinearGradient(
                                                colors: [Color.orange, Color.red],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .frame(width: 44, height: 44)
                                    
                                    Image(systemName: "cup.and.saucer.fill")
                                        .font(.system(size: 20))
                                        .foregroundColor(.white)
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("support.title", bundle: .main, comment: "Support title")
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    Text("support.subtitle", bundle: .main, comment: "Support subtitle")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "arrow.up.forward.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.orange)
                            }
                            .padding(20)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(.ultraThinMaterial)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(
                                                LinearGradient(
                                                    colors: [Color.orange.opacity(0.3), Color.red.opacity(0.3)],
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                ),
                                                lineWidth: 1
                                            )
                                    )
                            )
                            .shadow(color: .orange.opacity(0.1), radius: 20, x: 0, y: 10)
                        }
                        .buttonStyle(ScaleButtonStyle())
                        .scaleEffect(animateIn ? 1 : 0.95)
                        .opacity(animateIn ? 1 : 0)
                        .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.6), value: animateIn)
                        
                        // Footer
                        VStack(spacing: 8) {
                            Text("info.credit", bundle: .main, comment: "Credit")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                            
                            Text("v1.0")
                                .font(.caption)
                                .foregroundColor(Color(UIColor.tertiaryLabel))
                        }
                        .padding(.top, 24)
                        .padding(.bottom, 40)
                        .opacity(animateIn ? 1 : 0)
                        .animation(.easeOut(duration: 0.6).delay(0.7), value: animateIn)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .background(Color(UIColor.systemBackground))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundStyle(.secondary, Color(UIColor.tertiarySystemFill))
                    }
                }
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.1)) {
                animateIn = true
            }
        }
        .sheet(isPresented: $showingLetterSheet) {
            ConceptView()
        }
    }
}

// Info Card Component
struct InfoCard: View {
    let icon: String
    let iconColor: Color
    let title: LocalizedStringKey
    var content: LocalizedStringKey? = nil
    var items: [LocalizedStringKey]? = nil
    let delay: Double
    
    @State private var animateIn = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(iconColor)
                
                Text(title, bundle: .main)
                    .font(.headline)
                
                Spacer()
            }
            
            if let content = content {
                Text(content, bundle: .main)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineSpacing(4)
            }
            
            if let items = items {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(Array(items.enumerated()), id: \.offset) { _, item in
                        HStack(alignment: .top, spacing: 12) {
                            Circle()
                                .fill(iconColor.opacity(0.2))
                                .frame(width: 6, height: 6)
                                .offset(y: 6)
                            
                            Text(item, bundle: .main)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineSpacing(4)
                        }
                    }
                }
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(UIColor.secondarySystemBackground))
                .shadow(color: .black.opacity(0.03), radius: 20, x: 0, y: 10)
        )
        .scaleEffect(animateIn ? 1 : 0.95)
        .opacity(animateIn ? 1 : 0)
        .onAppear {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8).delay(delay)) {
                animateIn = true
            }
        }
    }
}


// Link Button Component
struct LinkButton: View {
    let icon: String
    let iconColor: Color
    let title: LocalizedStringKey
    let subtitle: LocalizedStringKey
    let url: String
    
    var body: some View {
        Link(destination: URL(string: url)!) {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(iconColor.opacity(0.1))
                        .frame(width: 40, height: 40)
                    
                    Image(systemName: icon)
                        .font(.system(size: 18))
                        .foregroundColor(iconColor)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title, bundle: .main)
                        .font(.subheadline.bold())
                        .foregroundColor(.primary)
                    Text(subtitle, bundle: .main)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "arrow.up.forward")
                    .font(.caption.bold())
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// Scale Button Style
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.spring(response: 0.2, dampingFraction: 0.8), value: configuration.isPressed)
    }
}

// Concept View - Letter to Audience
struct ConceptView: View {
    @Environment(\.dismiss) var dismiss
    @State private var animateIn = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    // Hero Header
                    VStack(spacing: 20) {
                        // Envelope animation
                        ZStack {
                            Circle()
                                .fill(
                                    RadialGradient(
                                        colors: [
                                            Color.purple.opacity(0.2),
                                            Color.clear
                                        ],
                                        center: .center,
                                        startRadius: 30,
                                        endRadius: 80
                                    )
                                )
                                .frame(width: 160, height: 160)
                                .blur(radius: 30)
                                .scaleEffect(animateIn ? 1.1 : 0.9)
                            
                            Image(systemName: "envelope.open.fill")
                                .font(.system(size: 60))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [Color.purple, Color.pink],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .scaleEffect(animateIn ? 1 : 0.8)
                                .rotationEffect(.degrees(animateIn ? 0 : -10))
                        }
                        .opacity(animateIn ? 1 : 0)
                        
                        VStack(spacing: 12) {
                            Text("concept.header", bundle: .main, comment: "Concept header")
                                .font(.system(size: 32, weight: .bold, design: .serif))
                                .multilineTextAlignment(.center)
                            
                            Text("info.letter.title", bundle: .main, comment: "Letter title")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .opacity(animateIn ? 1 : 0)
                        .offset(y: animateIn ? 0 : 20)
                    }
                    .padding(.top, 40)
                    .padding(.bottom, 40)
                    .padding(.horizontal, 24)
                    
                    // Letter Content
                    VStack(alignment: .leading, spacing: 24) {
                        Text("info.letter.content", bundle: .main, comment: "Letter content")
                            .font(.system(size: 18, weight: .regular, design: .serif))
                            .foregroundColor(.primary)
                            .lineSpacing(8)
                            .opacity(animateIn ? 1 : 0)
                            .animation(.easeOut(duration: 0.8).delay(0.3), value: animateIn)
                    }
                    .padding(.horizontal, 28)
                    .padding(.bottom, 80)
                    
                    // Signature
                    VStack(alignment: .trailing, spacing: 8) {
                        Text("— Tofus")
                            .font(.system(size: 20, weight: .medium, design: .serif))
                            .foregroundColor(.primary)
                        Text("2025")
                            .font(.system(size: 16, design: .serif))
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal, 28)
                    .padding(.bottom, 40)
                    .opacity(animateIn ? 1 : 0)
                    .animation(.easeOut(duration: 0.6).delay(0.5), value: animateIn)
                }
            }
            .background(
                LinearGradient(
                    colors: [
                        Color(UIColor.systemBackground),
                        Color(UIColor.secondarySystemBackground)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            )
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text(" ")  // Empty text for spacing
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundStyle(.secondary, Color(UIColor.tertiarySystemFill))
                    }
                }
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.8).delay(0.1)) {
                animateIn = true
            }
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}