//
//  ContentView.swift
//  swiftUICharacter
//
//  Created by Marina Roshchupkina on 24.05.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView{
            VStack(alignment: .center){
                CharacterImageView()
                
                HStack {
                    Text("Character Name").font(.title)
                    Image(systemName: "heart.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .padding()
                }
                
                InfoView(key: "Status:", value: "Alive").padding()
                InfoView(key: "Species:", value: "Human").padding()
                InfoView(key: "Gender:", value: "Male").padding()
                
                
                
                
            }
            
        }
    }
}
struct CharacterImageView: View {
    var body: some View {
        Image("picklepic")
            .resizable()
            .frame(width: 300, height: 300)
            .padding()
    }
}

struct InfoView: View {
    var Key : String
    var Value : String
    init(key:String, value: String){
        Key = key
        Value = value
    }
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text(Key).font(.title).foregroundColor(.gray)
                Spacer()
            }
            Text(Value).font(.title).foregroundColor(.black)
            Rectangle().fill(Color.black).frame(width: 370, height: 1, alignment: .center)
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
