//
//  ContentView.swift
//  MusicPlayer
//
//  Created by Phan Van Phu on 29/08/2024.
//

import SwiftUI
import AVKit

struct ContentView: View {
    let audioFile = "piano"
    
    @State private var player: AVAudioPlayer?
    @State private var isPlaying = false
    @State private var totalTime: TimeInterval = 0.0
    @State private var currentTime: TimeInterval = 0.0
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    ModifiedButtonView(image: "arrow.left")
                    
                    Spacer()
                    
                    ModifiedButtonView(image: "line.horizontal.3.decrease")
                }
                
                Text("Now Playing")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.black.opacity(0.8))
            }
            .padding(.all)
            
            Image("background")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 55)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .padding(.all, 8)
                .background(Color(#colorLiteral(red: 0.9, green: 0.95, blue: 1, alpha: 1)))
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .shadow(color: Color.black.opacity(0.35), radius: 8, x: 8, y:8)
                .shadow(color: Color.white, radius: 10, x: -10, y: -10)
                .padding(.top, 35)
            
            Text("Drift")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(.black.opacity(0.8))
                .padding(.top, 25)
            
            Text("Robot Hock fe nilu")
                .font(.caption)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(.black.opacity(0.8))
                .padding(.top, 2)
            
            VStack {
                HStack {
                    Text(timeString(time: currentTime))
                    Spacer()
                    Text(timeString(time: totalTime))
                }
                .font(.caption)
                .foregroundColor(.black.opacity(0.8))
                .padding([.top, .trailing, .leading], 20)
                
                Slider(value: Binding(get: {
                    currentTime
                }, set: {
                    newValue in audioTime(to: newValue)
                }), in: 0...totalTime)
                .padding([.top, .trailing, .leading], 20)
            }
            
            HStack(spacing: 20) {
                Button(action: {}, label: {
                    ModifiedButtonView(image: "backward.fill")
                })
                
                Button {} label: {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.system(size: 14, weight: .bold))
                        .padding(.all, 25)
                        .foregroundColor(.black.opacity(0.8))
                        .background(
                            ZStack {
                                Color(#colorLiteral(red: 0.9, green: 0.95, blue: 1, alpha: 1))
                                
                                Circle()
                                    .foregroundColor(.white)
                                    .blur(radius: 4)
                                    .offset(x: -8, y: -8)
                                
                                Circle()
                                    .fill(LinearGradient(gradient: /*@START_MENU_TOKEN@*/Gradient(colors: [Color.red, Color.blue])/*@END_MENU_TOKEN@*/, startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .padding(2)
                                    .blur(radius: 2)
                            }
                                .clipShape(Circle())
                                .shadow(color: Color.white, radius: 20, x: -20, y: -20))
                        .onTapGesture {
                            isPlaying ? stopAudio() : playAudio()
                        }
                }
                
                Button(action: {}, label: {
                    ModifiedButtonView(image: "forward.fill")
                })
            }
            .padding(.top, 25)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(#colorLiteral(red: 0.9, green: 0.95, blue: 1, alpha: 1)))
        .onAppear(perform: {
            setupAudio()
        })
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect(), perform: { _ in
                updateProgress()
        })
    }
    
    private func setupAudio() {
        guard let url = Bundle.main.url(forResource: audioFile, withExtension: "mp3") else {return}
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            totalTime = player?.duration ?? 0.0
        } catch {
            print("Error loading audio")
        }
    }
    
    private func playAudio() {
        player?.play()
        isPlaying = true
    }
    
    private func stopAudio() {
        player?.stop()
        isPlaying = false
    }
    
    private func updateProgress() {
        guard let player = player else {return}
        currentTime = player.currentTime
    }
    
    private func audioTime(to time: TimeInterval) {
        player?.currentTime = time
    }
    
    private func timeString(time: TimeInterval) -> String {
        let minute = Int(time) / 60
        let seconds = Int(time) & 60
        return String(format: "%02d:%02d", minute, seconds)
    }
}

#Preview {
    ContentView()
}

struct ModifiedButtonView: View {
    var image: String
    
    var body: some View {
        Button(action: {}, label: {
            Image(systemName: image)
                .font(.system(size: 14, weight: .bold))
                .padding(.all, 25)
                .foregroundColor(.black.opacity(0.8))
                .background(
                    ZStack {
                        Color(#colorLiteral(red: 0.9, green: 0.95, blue: 1, alpha: 1))
                        
                        Circle()
                            .foregroundColor(.white)
                            .blur(radius: 4)
                            .offset(x: -8, y: -8)
                        
                        Circle()
                            .fill(LinearGradient(gradient: /*@START_MENU_TOKEN@*/Gradient(colors: [Color.red, Color.blue])/*@END_MENU_TOKEN@*/, startPoint: .topLeading, endPoint: .bottomTrailing))
                            .padding(2)
                            .blur(radius: 2)
                    }
                        .clipShape(Circle())
                        .shadow(color: Color.white, radius: 20, x: -20, y: -20)
                )
        })
    }
}
