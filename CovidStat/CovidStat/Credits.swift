//
//  Credits.swift
//  CovidStat
//
//  Created by Amory Rouault on 29/04/2020.
//  Copyright © 2020 Amory Rouault. All rights reserved.
//

import SwiftUI

struct Credits: View {
    
    let thanksAbuanwar072 = "I want to thanks Abuanwar072 for the design inspiration. Check out and support the original project on Youtube and GitHub."
    let thanksBrian = "I want to thanks Brian for the base code and tutorials."
    let thanksPomber = "I want to thanks Pomber for the data about Coronavirus."
    
    var body: some View {
        
        VStack {
            
            // Header
            ZStack {
                Image("virus")
                Text("Credits")
                    .font(.title)
                    .foregroundColor(Color.white)
            }
            .frame(height: 200)
            .background(LinearGradient(gradient: Gradient(colors: [
                Color(red: 23/255, green: 74/255, blue: 136/255),
                Color(red: 41/255, green: 116/255, blue: 201/255)]), startPoint: .leading, endPoint: .trailing)
            )
            
            // Abuanwar072
            VStack {
                
                // Text
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text("Thanks Abuanwar072")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    Text(self.thanksAbuanwar072)
                        .foregroundColor(Color.gray)
                }
                
                // Buttons
                HStack(spacing: 100) {
                    Button("YouTube", action: {
                        self.openURL(urlStr: "https://www.youtube.com/watch?v=zx6uMCoW2gQ")
                    })
                    Button("GitHub", action: {
                        self.openURL(urlStr: "https://github.com/abuanwar072/Covid-19-Flutter-UI")
                    })
                }.padding(.top)
                
            }
            .frame(maxWidth: UIScreen.main.bounds.width)
            .padding()
            
            // Brian
            VStack {
                
                // Text
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text("Thanks Brian from Let's Build That App")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    Text(self.thanksBrian)
                        .foregroundColor(Color.gray)
                }
                
                // Button
                Button("YouTube", action: {
                    self.openURL(urlStr: "https://www.youtube.com/watch?v=aBsZRqtCBU4")
                })
                .padding(.top)
                
            }
            .frame(maxWidth: UIScreen.main.bounds.width)
            .padding()
            
            // Pomber
            VStack {
                
                // Text
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text("Thanks Pomber")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    
                    Text(self.thanksPomber)
                        .foregroundColor(Color.gray)
                }
                
                // Button
                Button("GitHub", action: {
                    self.openURL(urlStr: "https://github.com/pomber/covid19")
                })
                .padding(.top)
                
            }
            .frame(maxWidth: UIScreen.main.bounds.width)
            .padding()
            
            Spacer()
        }
        .frame(maxWidth: UIScreen.main.bounds.width)
        .edgesIgnoringSafeArea(.all)
        
    }
    
    // MARK: Open url
    private func openURL(urlStr: String) {
        if let url = URL(string: urlStr) {
            UIApplication.shared.open(url)
        }
    }
}

#if DEBUG
struct Credits_Previews: PreviewProvider {
    static var previews: some View {
        Credits()
    }
}
#endif
