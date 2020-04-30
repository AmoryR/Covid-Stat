//
//  About.swift
//  CovidStat
//
//  Created by Amory Rouault on 29/04/2020.
//  Copyright © 2020 Amory Rouault. All rights reserved.
//

import SwiftUI

struct About: View {
    
    var body: some View {
        
        VStack {
            
            // Header
            ZStack {
                
                // Image
                Image("virus")
                
                // Text
                Text("About Covid-19")
                    .font(.title)
                    .foregroundColor(Color.white)
                
            }
            .frame(width: UIScreen.main.bounds.width, height: 200)
            .background(LinearGradient(gradient: Gradient(colors: [
                Color(red: 23/255, green: 74/255, blue: 136/255),
                Color(red: 41/255, green: 116/255, blue: 201/255)]), startPoint: .leading, endPoint: .trailing)
            )
                        
            // Symptoms
            VStack {
                
                // Head text
                HStack {
                    Text("Symptoms")
                        .fontWeight(.bold)
                    Spacer()
                }
                
                // Symptoms
                HStack {
                    
                    // Headache
                    VStack {
                        Image("headache")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                        Text("Headache")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    .frame(width: UIScreen.main.bounds.width / 3.6, height: 85)
                    .background(Color.white)
                    .cornerRadius(8)
                    .clipped()
                    .shadow(radius: 4, x: 0, y: 4)
                    
                    Spacer()
                    
                    // Caugh
                    VStack {
                        Image("caugh")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                        Text("Caugh")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    .frame(width: UIScreen.main.bounds.width / 3.6, height: 85)
                    .background(Color.white)
                    .cornerRadius(8)
                    .clipped()
                    .shadow(radius: 4, x: 0, y: 4)
                    
                    Spacer()
                    
                    // Fever
                    VStack {
                        Image("fever")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                        Text("Fever")
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    .frame(width: UIScreen.main.bounds.width / 3.6, height: 85)
                    .background(Color.white)
                    .cornerRadius(8)
                    .clipped()
                    .shadow(radius: 4, x: 0, y: 4)
                    
                }
                
                
            }.padding()
            
            // Prevention
            VStack {
                
                // Head text
                HStack {
                    Text("Prevention")
                        .fontWeight(.bold)
                    Spacer()
                }
                
                // Wear a mask
                ZStack {
                    
                    // Text
                    HStack {

                        Spacer()
                            .frame(width: 130)
                        
                        VStack(alignment: .leading) {
                            Text("Wear face mask")
                                .fontWeight(.semibold)
                            Text("Anyone caught without a mask risks becoming a social pariah.")
                                .font(.footnote)
                                .foregroundColor(Color.gray)
                        }
                        
                        Spacer()
                    }
                    .frame(height: 130)
                    .background(Color.white)
                    .cornerRadius(8)
                    .clipped()
                    .shadow(radius: 4, x: 0, y: 4)
                    
                    // Image
                    HStack(alignment: .bottom) {
                        Image("wear_mask")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 140)
                        Spacer()
                    }.offset(y: 10)
                }
                
                // Wear a mask
                ZStack {
                    
                    // Text
                    HStack {

                        Spacer()
                            .frame(width: 130)
                        
                        VStack(alignment: .leading) {
                            Text("Wash your hands")
                                .fontWeight(.semibold)
                            Text("These diseases include gastrointestinal infections, such as Salmonella, and respiratory infections, such as influenza.")
                                .font(.footnote)
                                .foregroundColor(Color.gray)
                        }
                        
                        Spacer()
                    }
                    .frame(height: 130)
                    .background(Color.white)
                    .cornerRadius(8)
                    .clipped()
                    .shadow(radius: 4, x: 0, y: 4)
                    
                    // Image
                    HStack(alignment: .bottom) {
                        Image("wash_hands")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 140)
                        Spacer()
                    }.offset(y: 10)
                }
                
                
            }.padding()
            
            Spacer()
        }
        .frame(maxWidth: UIScreen.main.bounds.width)
        .edgesIgnoringSafeArea(.all)
        
    }
    
//    var body: some View {
//
//        VStack {
//
//            // Header
//            ZStack {
//                Image("virus")
//                Text("About Covid-19")
//                    .font(.title)
//                    .foregroundColor(Color.white)
//            }
//            .frame(height: 200)
//            .background(LinearGradient(gradient: Gradient(colors: [
//                Color(red: 23/255, green: 74/255, blue: 136/255),
//                Color(red: 41/255, green: 116/255, blue: 201/255)]), startPoint: .leading, endPoint: .trailing)
//            )
//
//            // Symptoms
//            HStack {
//
//                Text("Symptoms")
//                    .fontWeight(.bold)
//
//                Spacer()
//            }
//            .padding(.top)
//            .padding(.horizontal)
//
//            HStack(spacing: 12) {
//
//                VStack(spacing: -5) {
//                    Image("headache")
//                        .scaleEffect(0.7)
//                    Text("Headache")
//                        .font(.footnote)
//                        .fontWeight(.semibold)
//
//
//                }
//                .frame(width: 110, height: 100)
//                .background(Color.white)
//                .cornerRadius(8)
//                .clipped()
//                .shadow(radius: 4, x: 0, y: 4)
//
//
//                VStack(spacing: -5) {
//                    Image("caugh")
//                        .scaleEffect(0.7)
//                    Text("Caugh")
//                        .font(.footnote)
//                        .fontWeight(.semibold)
//                }
//                .frame(width: 110, height: 100)
//                .background(Color.white)
//                .cornerRadius(8)
//                .clipped()
//                .shadow(radius: 4, x: 0, y: 4)
//
//                VStack(spacing: -5) {
//                    Image("fever")
//                        .scaleEffect(0.7)
//                    Text("Fever")
//                        .font(.footnote)
//                        .fontWeight(.semibold)
//                }
//                .frame(width: 110, height: 100)
//                .background(Color.white)
//                .cornerRadius(8)
//                .clipped()
//                .shadow(radius: 4, x: 0, y: 4)
//
//
//            }
//
//            // Prevention
//            HStack {
//
//                Text("Prevention")
//                    .fontWeight(.bold)
//
//                Spacer()
//            }
//            .padding(.top)
//            .padding(.horizontal)
//
//            VStack {
//
//                HStack {
//                    Image("wear_mask")
//
//                    VStack(alignment: .leading) {
//                        Text("Wear a mask")
//                            .fontWeight(.semibold)
//                        Text("Lorem")
//                    }
//
//                    Spacer()
//                }
//                .frame(minWidth: 0, idealWidth: UIScreen.main.bounds.width, maxWidth: UIScreen.main.bounds.width, minHeight: 0, idealHeight: 130, maxHeight: 130)
//                .background(Color.white)
//                .cornerRadius(8)
//                .clipped()
//                .shadow(radius: 4, x: 0, y: 4)
//
//                HStack {
//                    Image("wash_hands")
//
//                    VStack(alignment: .leading) {
//                        Text("Wash your hands")
//                            .fontWeight(.semibold)
//                        Text("Lorem")
//                    }
//
//                    Spacer()
//                }
//                .frame(minWidth: 0, idealWidth: UIScreen.main.bounds.width, maxWidth: UIScreen.main.bounds.width, minHeight: 0, idealHeight: 130, maxHeight: 130)
//                .background(Color.white)
//                .cornerRadius(8)
//                .clipped()
//                .shadow(radius: 4, x: 0, y: 4)
//
//            }
//
//            Spacer()
//
//        }
//        .frame(maxWidth: UIScreen.main.bounds.width)
//        .edgesIgnoringSafeArea(.all)
//
//    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
