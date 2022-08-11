//
//  ContentView.swift
//  Course List
//
//  Created by Vladislavs Buzinskis on 31/07/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .onAppear(perform: {
                getCourses()
            })
    }
    
    func getCourses() {
        // https://zappycode.com/api/courses?format=json
        
        if let apiUrl = URL(string: "https://zappycode.com/api/courses?format=json") {
            var request = URLRequest(url: apiUrl)
            
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if error != nil {
                    print("There was an error")
                } else if data != nil {
                    print(String(data: data!, encoding: .utf8) ?? "Error")
                }
                
                    
                }.resume()
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
