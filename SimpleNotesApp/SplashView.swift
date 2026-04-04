import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var opacity = 0.0
    @State private var scale = 0.8

    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                Color(.systemBackground).ignoresSafeArea()
                VStack(spacing: 16) {
                    Image(systemName: "note.text")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.accentColor)
                    Text("SimpleNotes")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Catatan sederhana, hidup lebih teratur.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .scaleEffect(scale)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeOut(duration: 0.5)) {
                        opacity = 1.0
                        scale = 1.0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        withAnimation(.easeIn(duration: 0.3)) {
                            isActive = true
                        }
                    }
                }
            }
        }
    }
}
