//
//  ContentView.swift
//  CovidStat
//
//  Created by Amory Rouault on 27/04/2020.
//  Copyright © 2020 Amory Rouault. All rights reserved.
//

import SwiftUI

struct TimeSeries: Decodable {
    let Argentina: [DayData]
    let Australia: [DayData]
    let Belgium: [DayData]
    let Brazil: [DayData]
    let Canada: [DayData]
    let China: [DayData]
    let Colombia: [DayData]
    let Cuba: [DayData]
    let Denmark: [DayData]
    let Egypt: [DayData]
    let Finland: [DayData]
    let France: [DayData]
    let Germany: [DayData]
    let India: [DayData]
    let Ireland: [DayData]
    let Italy: [DayData]
    let Luxembourg: [DayData]
    let Mexico: [DayData]
    let Monaco: [DayData]
    let Morocco: [DayData]
    let Norway: [DayData]
    let Portugal: [DayData]
    let Romania: [DayData]
    let Russia: [DayData]
    let Somalia: [DayData]
    let Spain: [DayData]
    let Sweden: [DayData]
    let Thailand: [DayData]
    let US: [DayData]
    let Vietnam: [DayData]
}

struct DayData: Decodable, Hashable {
    let date: String
    let confirmed: Int
    let deaths: Int
    let recovered: Int
}

class DateHandler {
    
    // Specific for timeseries date
    static func convert(date: String) -> String {
        
        var day: String = ""
        var month: String = ""
        var year: String = ""
        
        // Date format YYYY-M(M)-D(D)
        var selector = 0
        
        // Separate year, month and day
        for c in date {
            if (c == "-") {
                selector += 1
            } else {
                switch selector {
                case 0:
                    year.append(c as Character)
                    break
                case 1:
                    month.append(c as Character)
                    break
                case 2:
                    day.append(c as Character)
                    break
                default:
                    print("Error converting date with selector : \(selector)")
                    return "Error converting date"
                }
            }
        }
        
        return "\(day) \(self.getMonth(monthNumber: month)) \(year)"
    }
    
    private static func getMonth(monthNumber: String) -> String {
        
        switch monthNumber {
        case "1", "01":
            return "January"
        case "2", "02":
            return "February"
        case "3", "03":
            return "March"
        case "4", "04":
            return "April"
        case "5", "05":
            return "May"
        case "6", "06":
            return "June"
        case "7", "07":
            return "July"
        case "8", "08":
            return "August"
        case "9", "09":
            return "September"
        case "10":
            return "October"
        case "11":
            return "November"
        case "12":
            return "December"
        default:
            print("Error getting month : \(monthNumber)")
            return "Error month"
        }

    }
    
}

class CovidStatistics: ObservableObject {
    
    @Published var data: [String:[DayData]] = [:]
    
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
                    
                    self.data["Argentina"] = timeSeries.Argentina
                    self.data["Australia"] = timeSeries.Australia
                    self.data["Belgium"] = timeSeries.Belgium
                    self.data["Brazil"] = timeSeries.Brazil
                    self.data["Canada"] = timeSeries.Canada
                    self.data["China"] = timeSeries.China
                    self.data["Colombia"] = timeSeries.Colombia
                    self.data["Cuba"] = timeSeries.Cuba
                    self.data["Denmark"] = timeSeries.Denmark
                    self.data["Egypt"] = timeSeries.Egypt
                    self.data["Finland"] = timeSeries.Finland
                    self.data["France"] = timeSeries.France
                    self.data["Germany"] = timeSeries.Germany
                    self.data["India"] = timeSeries.India
                    self.data["Ireland"] = timeSeries.Ireland
                    self.data["Italy"] = timeSeries.Italy
                    self.data["Luxembourg"] = timeSeries.Luxembourg
                    self.data["Mexico"] = timeSeries.Mexico
                    self.data["Monaco"] = timeSeries.Monaco
                    self.data["Morocco"] = timeSeries.Morocco
                    self.data["Norway"] = timeSeries.Norway
                    self.data["Portugal"] = timeSeries.Portugal
                    self.data["Romania"] = timeSeries.Romania
                    self.data["Russia"] = timeSeries.Russia
                    self.data["Somalia"] = timeSeries.Somalia
                    self.data["Spain"] = timeSeries.Spain
                    self.data["Sweden"] = timeSeries.Sweden
                    self.data["Thailand"] = timeSeries.Thailand
                    self.data["US"] = timeSeries.US
                    self.data["Vietnam"] = timeSeries.Vietnam
                    
                }

            } catch {
                print("JSON Decode failed: ", error)
            }

        }.resume()
    }
    
    func getDayData(of place: String, data: String) -> [DayData] {
        
        if let dataForPlace =  self.data[place] {
            
            let treshold = 200
            var filteredData: [DayData] = []
            
            switch data {
            case "Infected":
                filteredData = dataForPlace.filter {
                    $0.confirmed > treshold
                }
                break
            case "Deaths":
                filteredData = dataForPlace.filter {
                    $0.deaths > treshold
                }
                break
            case "Recovered":
                filteredData = dataForPlace.filter {
                    $0.recovered > treshold
                }
                break
            default:
                print("Wrong data : \(data) for get day data")
                return []
            }
            
            return filteredData
        } else {
            return []
        }
        
    }
    
    func getMax(of place: String, data: String) -> Int {
        switch data {
        case "Infected":
            return self.getMaxInfected(of: place)
        case "Deaths":
            return self.getMaxDeaths(of: place)
        case "Recovered":
            return self.getMaxRecovered(of: place)
        default:
            print("Wrong data : \(data) for max")
            return -1
        }
    }
    
    func getInfection(of place: String) -> Int {
        if !self.data.isEmpty {
            return self.data[place]!.last!.confirmed
        } else {
            return 0
        }
    }
    
    private func getMaxInfected(of place: String) -> Int {
        
        if let dataForPlace =  self.data[place] {
            return dataForPlace.max(by: { (day1: DayData, day2: DayData) -> Bool in
                                            return day2.confirmed > day1.confirmed
                                            })?.confirmed ?? 0
        } else {
            return 0
        }
        
    }
    
    func getDeaths(of place: String) -> Int{
        if !self.data.isEmpty {
            return self.data[place]!.last!.deaths
        } else {
            return 0
        }
    }
    
    private func getMaxDeaths(of place: String) -> Int {
        
        if let dataForPlace =  self.data[place] {
            return dataForPlace.max(by: { (day1: DayData, day2: DayData) -> Bool in
                                            return day2.deaths > day1.deaths
                                            })?.deaths ?? 0
        } else {
            return 0
        }
        
    }
    
    func getRecovered(of place: String) -> Int{
        if !self.data.isEmpty {
            return self.data[place]!.last!.recovered
        } else {
            return 0
        }
    }
    
    private func getMaxRecovered(of place: String) -> Int {
        
        if let dataForPlace =  self.data[place] {
            return dataForPlace.max(by: { (day1: DayData, day2: DayData) -> Bool in
                                            return day2.recovered > day1.recovered
                                            })?.recovered ?? 0
        } else {
            return 0
        }
        
    }
    
    func getLastDate() -> String {
        
        // I take US as an example
        if let lastDate = self.data["US"]?.last!.date {
            return DateHandler.convert(date: lastDate)
        }

        return "..."
        
    }
    
    func color(for data: String) -> Color {
        switch data {
        case "Infected":
            return Color.orange
        case "Deaths":
            return Color.red
        case "Recovered":
            return Color.green
        default:
            print("Wrong stat : \(data) for color")
            return Color.black
        }
    }
    
}

struct Place: Identifiable, Hashable {

    let id = UUID()
    var name: String = ""

    init(name: String) {
        self.name = name
    }
}


class SelectedPlace: ObservableObject {
    @Published var place = Place(name: "France")
}

struct SelectionRow: View {
    var place: Place
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var selectedPlace: SelectedPlace

    var isSelected : Bool {
        // Name is not a good way to identify places
        return self.selectedPlace.place.name == self.place.name
    }

    var body: some View {

        Button(action: {
            self.selectedPlace.place = self.place
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Text(self.place.name)
                Spacer()
                if self.isSelected {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
        }.foregroundColor(.primary)

    }
}

struct SelectionView: View {
    
    var places = [
        Place(name: "Argentina"),
        Place(name: "Australia"),
        Place(name: "Belgium"),
        Place(name: "Brazil"),
        Place(name: "Canada"),
        Place(name: "China"),
        Place(name: "Colombia"),
        Place(name: "Cuba"),
        Place(name: "Denmark"),
        Place(name: "Egypt"),
        Place(name: "Finland"),
        Place(name: "France"),
        Place(name: "Germany"),
        Place(name: "India"),
        Place(name: "Ireland"),
        Place(name: "Italy"),
        Place(name: "Luxembourg"),
        Place(name: "Mexico"),
        Place(name: "Monaco"),
        Place(name: "Morocco"),
        Place(name: "Norway"),
        Place(name: "Portugal"),
        Place(name: "Romania"),
        Place(name: "Russia"),
        Place(name: "Somalia"),
        Place(name: "Spain"),
        Place(name: "Sweden"),
        Place(name: "Thailand"),
        Place(name: "US"),
        Place(name: "Vietnam"),
    ]
    
    @EnvironmentObject var selectedPlace: SelectedPlace
    
    var body: some View {
        List(self.places) { place in
            SelectionRow(place: place).environmentObject(self.selectedPlace)
        }.navigationBarTitle("Select a place", displayMode: .inline)
    }
    
}

struct SelectButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .frame(minWidth: 0, maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(Color.gray, lineWidth: 0.8)
            )
            .background(Color.white)
//            .foregroundColor(.blue)
    }
}

struct ContentView: View {
    
    @ObservedObject var selectedPlace = SelectedPlace()
    @ObservedObject var statistics = CovidStatistics()
    
    @State private var selectedGraph = 0
    @State var showingAbout = false
    @State var showingCredits = false
    @State var isSelectingPlace = false
    
    var graphs = ["Infected", "Deaths", "Recovered"]
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                // Header
                ZStack {
                    
                    // Image
                    Image("virus")
                        .resizable()
                        .scaledToFit()
                    
                    // Dr
                    VStack {
                        Spacer()
                        Image("drcorona")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 130)
                            .offset(x: -95)
                    }
                        
                    
                    // Text
                    Text("Stay safe at home")
                        .font(.title)
                        .foregroundColor(Color.white)
                        .offset(x: 70)
                    
                }
                .frame(width: UIScreen.main.bounds.width, height: 200)
                .background(LinearGradient(gradient: Gradient(colors: [
                    Color(red: 23/255, green: 74/255, blue: 136/255),
                    Color(red: 41/255, green: 116/255, blue: 201/255)]), startPoint: .leading, endPoint: .trailing)
                )
                
                ScrollView {
                    
                    // Place selector
                    VStack {
                        
                        // Head text
                        HStack {
                            Text("Select a place")
                                .fontWeight(.bold)
                            Spacer()
                        }.padding(.bottom, 10)
                        
                        // Selector
                        NavigationLink(destination: SelectionView().environmentObject(self.selectedPlace), isActive: self.$isSelectingPlace) { EmptyView() }

                        Button(action:  {
                            self.isSelectingPlace = true
                        }) {
                            HStack {
                                Image("location")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20)
                                    .padding(.trailing, 5)
                                
                                Text(self.selectedPlace.place.name)
                                
                                Spacer()
                                
                                Image("forward")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 10)
                            }
                        }
                        .buttonStyle(SelectButtonStyle())
                        
                        
                    }
                    .padding(.top)
                    .padding(.horizontal)
                    
                    // Case update
                    VStack {
                        
                        // Head text
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Case update")
                                    .fontWeight(.bold)
                                Text("Newest update")
                                    .font(.callout)
                                    .foregroundColor(Color.gray)
                            }
                            Spacer()
                        }.padding(.bottom, 10)
                        
                        // Case digits
                        HStack {
                            Spacer()
                            
                            // Infected
                            VStack {
                                Text("\(self.statistics.getInfection(of: self.selectedPlace.place.name))")
                                    .fontWeight(.bold)
                                    .foregroundColor(self.statistics.color(for: "Infected"))
                                Text("Infected")
                                    .font(.caption)
                                    .foregroundColor(Color.gray)
                            }
                            .frame(width: 100)

                            // Deaths
                            VStack {
                                Text("\(self.statistics.getDeaths(of: self.selectedPlace.place.name))")
                                    .fontWeight(.bold)
                                    .foregroundColor(self.statistics.color(for: "Deaths"))
                                Text("Deaths")
                                    .font(.caption)
                                    .foregroundColor(Color.gray)
                            }
                            .frame(width: 100)

                            // Recovered
                            VStack {
                                Text("\(self.statistics.getRecovered(of: self.selectedPlace.place.name))")
                                    .fontWeight(.bold)
                                    .foregroundColor(self.statistics.color(for: "Recovered"))
                                Text("Recovered")
                                .font(.caption)
                                .foregroundColor(Color.gray)
                            }
                            .frame(width: 100)
                            
                            Spacer()
                        }
                        .frame(height: 75)
                        .background(Color.white)
                        .cornerRadius(8)
                        .clipped()
                        .shadow(radius: 4, x: 0, y: 4)
                        
                        
                    }.padding()
                    
                    // Virus evolution
                    VStack {
                        
                        // Head text
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Virus evolution")
                                    .fontWeight(.bold)
                                Text("From January to \(self.statistics.getLastDate())")
                                    .font(.callout)
                                    .foregroundColor(Color.gray)
                            }
                            Spacer()
                        }
                        
                        // Picker
                        Picker(selection: $selectedGraph, label: Text("Strength")) {
                            ForEach(0 ..< graphs.count) {
                                Text(self.graphs[$0])
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        // Graph
                        HStack {
                            Spacer()
                            
                            if self.statistics.getDayData(of: self.selectedPlace.place.name, data: self.graphs[self.selectedGraph]).isEmpty {
                                Text("No Data")
                                    .foregroundColor(self.statistics.color(for: self.graphs[self.selectedGraph]))
                            } else {
                                
                                ScrollView(.horizontal) {
                                    HStack(alignment: .bottom, spacing: 4) {
                                        ForEach(self.statistics.getDayData(of: self.selectedPlace.place.name, data: self.graphs[self.selectedGraph]), id: \.self) { (day: DayData) in
                                            HStack {
                                                Spacer()
                                            }
                                            .frame(width: 8,
                                                   height: 100.0 * CGFloat(self.getDataFor(day: day, data: self.graphs[self.selectedGraph])) / CGFloat(self.statistics.getMax(of: self.selectedPlace.place.name, data: self.graphs[self.selectedGraph]))
                                            )
                                            .background(self.statistics.color(for: self.graphs[self.selectedGraph]))
                                        }
                                    }
                                }
                                
                            }
                            
                            Spacer()

                        }
                        .frame(height: 130)
                        .background(Color.white)
                        .cornerRadius(8)
                        .clipped()
                        .shadow(radius: 4, x: 0, y: 4)
                        
                        
                    }.padding()
                    
                    // Credits
                    HStack {
                        
                        VStack(alignment: .leading) {
                            Button(action: {
                                self.showingAbout.toggle()
                            }) {
                                Text("About Covid-19")
                            }
                            .sheet(isPresented: self.$showingAbout) {
                                    About()
                            }.padding(.bottom, 15)
                            
                            Button("Credits", action: {
                                self.showingCredits.toggle()
                            })
                            .sheet(isPresented: self.$showingCredits) {
                                    Credits()
                            }
                        }

                        Spacer()
                        
                    }.padding(.horizontal)
                }
                
                Spacer()
            }
            .frame(maxWidth: UIScreen.main.bounds.width)
            .edgesIgnoringSafeArea(.all)
            
        }
        .statusBar(hidden: true) // I can't make it light
    }
    
    private func getDataFor(day: DayData, data: String) -> Int {
        switch data {
        case "Infected":
            return day.confirmed
        case "Deaths":
            return day.deaths
        case "Recovered":
            return day.recovered
        default:
            print("Wrong data : \(data) for max")
            return -1
        }
    }
    
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
