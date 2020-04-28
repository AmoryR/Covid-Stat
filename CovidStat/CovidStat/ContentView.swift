//
//  ContentView.swift
//  CovidStat
//
//  Created by Amory Rouault on 27/04/2020.
//  Copyright © 2020 Amory Rouault. All rights reserved.
//

import SwiftUI

struct TimeSeries: Decodable {
    let US: [DayData]
}

struct DayData: Decodable, Hashable {
    let date: String
    let confirmed: Int
    let deaths: Int
    let recovered: Int
}

class ChartViewModel: ObservableObject {

    @Published var dataSet = [DayData]()

    var max: Int = 0
    var infected: Int = 0
    var deaths: Int = 0
    var recovered: Int = 0
    var lastData: String = ""

    init() {
        let urlString = "https://pomber.github.io/covid19/timeseries.json"
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            // Handle errors here

            guard let data = data else {
                return
            }

            do {
                let timeSeries = try JSONDecoder().decode(TimeSeries.self, from: data)
                
                DispatchQueue.main.async {
                    self.dataSet = timeSeries.US.filter { $0.deaths > 0 }

                    self.max = self.dataSet.max(by: { (day1: DayData, day2: DayData) -> Bool in
                        return day2.deaths > day1.deaths
                        })?.deaths ?? 0
                    
                    if !self.dataSet.isEmpty {
                        self.infected = self.dataSet.last!.confirmed
                        self.deaths = self.dataSet.last!.deaths
                        self.recovered = self.dataSet.last!.recovered
                        self.lastData = self.dataSet.last!.date
                    }
                    
                }

            } catch {
                print("JSON Decode failed: ", error)
            }

        }.resume()
    }

}

struct ContentView: View {
    
    @ObservedObject var vm = ChartViewModel()
    
    var graphs = ["Infected", "Deaths", "Recovered"]

    @State private var selectedGraph = 0


    var body: some View {
        VStack {
            
            // Header
            ZStack {
                
                // Virus
                Image("virus")
                
                
                VStack(alignment: .leading) {
                    Text("Stay safe at home")
                        .font(.title)
                        .foregroundColor(Color.white)
                    
                    Button("About Covid-19", action: {
                        print("Launch modal...")
                    })
                }
            }
            .frame(height: 200)
            .background(
            LinearGradient(gradient: Gradient(colors: [
                Color(red: 23/255, green: 74/255, blue: 136/255),
                Color(red: 41/255, green: 116/255, blue: 201/255)            ]), startPoint: .leading, endPoint: .trailing)
            )
            
            // Content
            ScrollView {
                
                
                VStack(spacing: 16) {
                    // Place
                    VStack {
                        
                        HStack {

                            Text("Select a place")
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.horizontal)
                            
                        Text("By default : US")
                    }

                    // Case Update
                    VStack {
                        
                        
                        HStack {
                            VStack {
                                Text("Case Update")
                                    .fontWeight(.bold)

//                                Text("Newest update \(self.vm.lastData)")
//                                    .font(.callout)
//                                    .foregroundColor(Color.gray)
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        
                        HStack {
                            
                            VStack {
                                Text("\(self.vm.infected)")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.orange)
                                Text("Infected")
                                    .font(.caption)
                                    .foregroundColor(Color.gray)
                            }
                            .frame(width: 100)
                            
                            VStack {
                                Text("\(self.vm.deaths)")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.red)
                                Text("Deaths")
                                    .font(.caption)
                                    .foregroundColor(Color.gray)
                            }
                            .frame(width: 100)
                            
                            VStack {
                                Text("\(self.vm.recovered)")
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.green)
                                Text("Recovered")
                                .font(.caption)
                                .foregroundColor(Color.gray)
                            }
                            .frame(width: 100)
                            
                        }
                        .frame(width: UIScreen.main.bounds.width, height: 75)
                        .background(Color.white)
                        .cornerRadius(8)
                        .clipped()
                        .shadow(radius: 4, x: 0, y: 4)
                    }

                    // Virus evolution
                    VStack {
                        
                        HStack {
                            VStack {
                                Text("Virus evolution")
                                    .fontWeight(.bold)
                                
//                                Text("From January to today")
//                                    .font(.callout)
//                                    .foregroundColor(Color.gray)
                            }
                            
                            Spacer()
                        }
                        .padding(.leading)
                        .padding(.trailing)
                        
                        Picker(selection: $selectedGraph, label: Text("Strength")) {
                            ForEach(0 ..< graphs.count) {
                                Text(self.graphs[$0])

                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal)
                        
                        
                        HStack {
                            Text("Draw : \(self.graphs[self.selectedGraph])")
//                            if !self.vm.dataSet.isEmpty {
//                                ScrollView(.horizontal) {
//                                    HStack(alignment: .bottom, spacing: 4) {
//                                        ForEach(vm.dataSet, id: \.self) { (day: DayData) in
//
//                                            HStack {
//                                                Spacer()
//                                            }.frame(width: 8, height: (CGFloat(day.deaths) / CGFloat(self.vm.max)) * 150).background(Color.red)
//
//                                        }
//                                    }
//                                }
//                            }
                        }
                        .frame(width: UIScreen.main.bounds.width, height: 200)
                        .background(Color.white)
                        .cornerRadius(8)
                        .clipped()
                        .shadow(radius: 4, x: 0, y: 4)
                    }
                    
                    // Credit
                    HStack {
                        Button("Credits", action: {
                            print("Show credits")
                        })
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                
                }
            }
            
            // Spacer
            Spacer()
            
        }
        .frame(maxWidth: UIScreen.main.bounds.width)
        .edgesIgnoringSafeArea(.all)
        // I can't make it light
        .statusBar(hidden: true)
        
        //.edgesIgnoringSafeArea(.top) side problem
//        .background(Color.gray)
    }

    
}

// GET DATA HERE
//class ChartViewModel: ObservableObject {
//
//    @Published var dataSet = [DayData]()
//
//    var max: Int = 0
//
//    init() {
//        let urlString = "https://pomber.github.io/covid19/timeseries.json"
//        guard let url = URL(string: urlString) else {
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { (data, resp, err) in
//            // Handle errors here
//
//            guard let data = data else {
//                return
//            }
//
//            do {
//                let timeSeries = try JSONDecoder().decode(TimeSeries.self, from: data)
//
//                DispatchQueue.main.async {
//                    self.dataSet = timeSeries.US.filter { $0.deaths > 0 }
//
//                    self.max = self.dataSet.max(by: { (day1: DayData, day2: DayData) -> Bool in
//                        return day2.deaths > day1.deaths
//                        })?.deaths ?? 0
//
//                }
//
//            } catch {
//                print("JSON Decode failed: ", error)
//            }
//
//        }.resume()
//    }
//
//}
//
//struct ContentView: View {
//
//    @ObservedObject var vm = ChartViewModel()
//
//    var body: some View {
//        VStack {
//            Text("Corona")
//            Text("Total deaths :")
//
//            if !self.vm.dataSet.isEmpty {
//                ScrollView(.horizontal) {
//                    HStack(alignment: .bottom, spacing: 4) {
//                        ForEach(vm.dataSet, id: \.self) { (day: DayData) in
//
//                            HStack {
//                                Spacer()
//                            }.frame(width: 8, height: (CGFloat(day.deaths) / CGFloat(self.vm.max)) * 200).background(Color.red)
//
//                        }
//                    }
//                }
//            }
//
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
