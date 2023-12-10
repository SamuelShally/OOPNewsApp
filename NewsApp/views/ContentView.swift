//
//  ContentView.swift
//  NewsApp
//
//  Created by Samuel Shally on 12/2/23.
//

import SwiftUI

struct ContentView: View{
    
    @State private var selectedTabView = 1
    
    var body: some View{

        //Add a tab bar to the bottom of the screen
        TabView(selection: $selectedTabView){
            ViewMain()
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("Latest")
                }
                .tag(1)
            
            ViewBrief()
                .tabItem {
                    Image(systemName: "sun.max.fill")
                    Text("briefing")
                }
                .tag(2)
            
            ViewSettings()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
                .tag(3)
        }
        
    }
    
}



struct ViewMain: View {
    private var news = ApiCall()
    @State private var articlesArr: [Artical] = []
    
    private func fetchData(){
        news.getTopHeadlines { [self] articles in
            articlesArr = articles
        }
    }
    
    var body: some View {
        //Navigation View to get title at the top
        NavigationView{
            //Make the Vstack below scrollable
            ScrollView{
                VStack(alignment: .leading, spacing: 10) {
                    
                    //Display all of the articles pulled from the API
                    ForEach(articlesArr){ article in
                        
                        //Place each article in a rounded rectangle
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
                            .frame(width: UIScreen.main.bounds.width, height: 200)
                        
                        //Overlay is the actual content
                            .overlay(
                                
                                VStack(alignment: .leading){
                                    Text(article.title ?? "No Headline").bold()
                                    Text(article.source?.name ?? "No source")
                                    Text(toDate(dateStr : article.publishedAt ?? ""))
                                }
                                .onTapGesture {
                                    if let urlString = article.url, let url = URL(string: urlString){
                                        UIApplication.shared.open(url)
                                    }
                                }
                                .padding()
                                
                            )
                    }
                }
            }
            .onAppear{
                fetchData()
            }
        
            .navigationBarTitle("Latest Stories")
        }
    }
    
    //Convert date string to readable date
    func toDate(dateStr : String) -> String{
        
        //slice string to yyyy-mm-dd format
        let startIndex = dateStr.index(dateStr.startIndex, offsetBy: 0)
        let endIndex = dateStr.index(dateStr.startIndex, offsetBy: 10)
        let dateStr = String(dateStr[startIndex..<endIndex])
        
        print(dateStr)
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        
        if let date = format.date(from: dateStr){
            format.dateFormat = "dd-MM-yyyy"
            let formattedDate = format.string(from: date)
            return formattedDate
        }else{
            return "No Date"
        }
    }
}

struct ViewBrief: View{
    private var news = ApiCall()
    @State private var articlesArr: [Artical] = []
    
    private func fetchData(){
        news.createBriefing { [self] articles in
            articlesArr = articles
            print(articlesArr)
        }
    }
    
    var body: some View {
        NavigationView{
            //Make the Vstack below scrollable
            ScrollView{
                VStack(alignment: .leading, spacing: 10) {
                    
                    //Display all of the articles pulled from the API
                    ForEach(articlesArr){ article in
                        
                        //Place each article in a rounded rectangle
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
                            .frame(width: UIScreen.main.bounds.width, height: 200)
                        
                        //Overlay is the actual content
                            .overlay(
                                
                                VStack(alignment: .leading){
                                    Text(article.title ?? "No Headline").bold()
                                    Text(article.source?.name ?? "No source")
                                    Text(toDate(dateStr : article.publishedAt ?? ""))
                                }
                                .onTapGesture {
                                    if let urlString = article.url, let url = URL(string: urlString){
                                        UIApplication.shared.open(url)
                                    }
                                }
                                .padding()
                                
                            )
                    }
                }
            }
            .onAppear{
                fetchData()
            }
        
            .navigationBarTitle("Briefing")
        }
    }
    
    //Convert date string to readable date
    func toDate(dateStr : String) -> String{
        
        //slice string to yyyy-mm-dd format
        let startIndex = dateStr.index(dateStr.startIndex, offsetBy: 0)
        let endIndex = dateStr.index(dateStr.startIndex, offsetBy: 10)
        let dateStr = String(dateStr[startIndex..<endIndex])
        
        print(dateStr)
        
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        
        if let date = format.date(from: dateStr){
            format.dateFormat = "dd-MM-yyyy"
            let formattedDate = format.string(from: date)
            return formattedDate
        }else{
            return "No Date"
        }
    }
}


//Simple Settings page to select the sources to be shown in briefing
struct ViewSettings: View{
    @State private var wsj: Bool
    @State private var bbc: Bool
    @State private var cnn: Bool
    @State private var reuters: Bool
    
    init(){
        self.wsj = UserDefaults.standard.object(forKey: "wsj") as? Bool ?? true
        self.bbc = UserDefaults.standard.object(forKey: "bbc") as? Bool ?? true
        self.cnn = UserDefaults.standard.object(forKey: "cnn") as? Bool ?? true
        self.reuters = UserDefaults.standard.object(forKey: "reuters") as? Bool ?? true
    
        print(wsj)
        print(bbc)
        print(cnn)
        print(reuters)
        
    }
    
    var body: some View {
        
        NavigationView{
            VStack {
                Text("Customize Briefing Sources: ")
                    .padding()
                
                Toggle("WSJ", isOn: $wsj)
                    .padding()
                
                Toggle("BBC", isOn: $bbc)
                    .padding()
                
                Toggle("CNN", isOn: $cnn)
                    .padding()
                
                Toggle("Reuters", isOn: $reuters)
                    .padding()
                
                Spacer()
                
            }
            .navigationBarTitle("Settings")
            .onChange(of: wsj) { oldState, newState in
                UserDefaults.standard.set(newState, forKey: "wsj")
            }
            .onChange(of: bbc) { oldState, newState in
                UserDefaults.standard.set(newState, forKey: "bbc")
            }
            .onChange(of: cnn) { oldState, newState in
                UserDefaults.standard.set(newState, forKey: "cnn")
            }
            .onChange(of: reuters) { oldState, newState in
                UserDefaults.standard.set(newState, forKey: "reuters")
            }
        }
    }
}




#Preview {
    ContentView()
}
