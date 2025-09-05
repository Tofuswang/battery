import SwiftUI

struct InfoView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                // App Icon and Title Section
                Section {
                    VStack(spacing: 15) {
                        Image(systemName: "battery.100")
                            .font(.system(size: 60))
                            .foregroundStyle(.green.gradient)
                        
                        Text("info.title", bundle: .main, comment: "Info title")
                            .font(.title.bold())
                        
                        Text("info.subtitle", bundle: .main, comment: "Info subtitle")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                }
                .listRowBackground(Color.clear)
                
                // What is this?
                Section(header: Text("info.what.title", bundle: .main, comment: "Section header")) {
                    Text("info.what.description", bundle: .main, comment: "What description")
                }
                
                // How to use
                Section(header: Text("info.how.title", bundle: .main, comment: "Section header")) {
                    Label {
                        Text("info.how.adjust", bundle: .main, comment: "Feature")
                    } icon: {
                        Image(systemName: "slider.horizontal.3")
                            .foregroundColor(.blue)
                    }
                    
                    Label {
                        Text("info.how.sound", bundle: .main, comment: "Feature")
                    } icon: {
                        Image(systemName: "speaker.wave.3.fill")
                            .foregroundColor(.purple)
                    }
                    
                    Label {
                        Text("info.how.language", bundle: .main, comment: "Feature")
                    } icon: {
                        Image(systemName: "globe")
                            .foregroundColor(.green)
                    }
                }
                
                // Why this exists
                Section(header: Text("info.why.title", bundle: .main, comment: "Section header")) {
                    Text("info.why.description", bundle: .main, comment: "Why description")
                }
                
                // Letter to Audience
                Section(header: HStack {
                    Text("info.letter.title", bundle: .main, comment: "Letter title")
                    Spacer()
                    Image(systemName: "envelope.open")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }) {
                    Text("info.letter.content", bundle: .main, comment: "Letter content")
                        .font(.system(.body, design: .serif))
                        .lineSpacing(8)
                        .padding(.vertical, 10)
                }
                
                // Author & Call to Action
                Section(header: HStack {
                    Text("info.author.title", bundle: .main, comment: "Author title")
                    Spacer()
                    Image(systemName: "person.circle")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }) {
                    VStack(alignment: .leading, spacing: 20) {
                        // Author Name & Title
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Tofus Wang")
                                .font(.title3.bold())
                            Text("info.author.subtitle", bundle: .main, comment: "Author subtitle")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Divider()
                        
                        // Bio & Vision
                        Text("info.author.bio", bundle: .main, comment: "Author bio")
                            .font(.body)
                            .lineSpacing(6)
                        
                        // Call to Action
                        Text("info.author.cta", bundle: .main, comment: "Call to action")
                            .font(.body)
                            .lineSpacing(6)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 15)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.accentColor.opacity(0.1))
                            )
                        
                        // Links
                        VStack(alignment: .leading, spacing: 12) {
                            Text("info.connect", bundle: .main, comment: "Connect")
                                .font(.subheadline.bold())
                                .foregroundColor(.secondary)
                            
                            Link(destination: URL(string: "https://www.instagram.com/tofuswang/")!) {
                                Label {
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("Instagram")
                                            .font(.body)
                                        Text("@tofuswang")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                } icon: {
                                    Image(systemName: "camera.fill")
                                        .foregroundColor(.purple)
                                        .frame(width: 24)
                                }
                            }
                            
                            Link(destination: URL(string: "https://www.gvm.com.tw/article/120015")!) {
                                Label {
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text("info.media.title", bundle: .main, comment: "Media title")
                                            .font(.body)
                                        Text("info.media.source", bundle: .main, comment: "Media source")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                } icon: {
                                    Image(systemName: "newspaper.fill")
                                        .foregroundColor(.blue)
                                        .frame(width: 24)
                                }
                            }
                        }
                    }
                    .padding(.vertical, 10)
                }
                
                // Credit
                Section {
                    VStack(spacing: 10) {
                        Text("info.credit", bundle: .main, comment: "Credit")
                            .font(.footnote)
                            .frame(maxWidth: .infinity)
                        
                        Text("v1.0")
                            .font(.caption2)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.vertical, 5)
                }
                .listRowBackground(Color.clear)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("About")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}