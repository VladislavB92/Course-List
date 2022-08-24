//
//  ContentView.swift
//  Course List
//
//  Created by Vladislavs Buzinskis on 31/07/2022.
//

import SwiftUI

struct CourseListView: View {
    
    @State var courses: [Course] = []
    
    var body: some View {
        if courses.count == 0 {
            VStack {
                ProgressView()
                    .padding()
                Text("Loading courses")
                    .foregroundColor(.blue)
                    .onAppear(perform: {
                        getCourses()
                    })
            }
        } else {
            ScrollView {
                VStack {
                    ForEach(courses) { listedCourse in
                        AsyncImage(url: URL(string: listedCourse.image)) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                            default:
                                VStack {
                                    Image(systemName: "books.vertical")
                                        .font(.largeTitle)
                                        .padding(80)
                                    
                                }.frame(maxWidth: .infinity)
                                    .background(Color.gray)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func getCourses() {
        if let apiUrl = URL(string: "https://zappycode.com/api/courses?format=json") {
            var request = URLRequest(url: apiUrl)
            
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if error != nil {
                    // print("There was an error")
                } else if data != nil {
                    // print(String(data: data!, encoding: .utf8) ?? "Error")
                    
                    if let coursesFromAPI = try? JSONDecoder().decode(
                        [Course].self, from: data!
                    ) {
                        courses = coursesFromAPI
                    }
                }
            }.resume()
            
        }
    }
}


struct Course: Codable, Identifiable {
    var id: Int
    var title: String
    var subtitle: String
    var image: String
}


struct TempImage_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Image(systemName: "books.vertical")
                .font(.largeTitle)
                .padding(80)

        }.frame(maxWidth: .infinity)
            .background(Color.gray)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CourseListView()
    }
}
