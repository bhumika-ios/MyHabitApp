//
//  TabView.swift
//  MyHabitApp
//
//  Created by Bhumika Patel on 16/01/23.
//

import SwiftUI

struct TabView: View {
    var body: some View {
        VStack{
           TabHomeView()
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView()
    }
}

struct TabHomeView: View{
    
    var body: some View{
        VStack(spacing: 0){
            GeometryReader{_ in
                ZStack{
                    ///-Tabs....
                
                }
            }
            ///- Tabview
            HStack(spacing: 0){
                ForEach(tabs, id: \.self){tab in
                    
                }
            }
        }
    }
}
// Both Title Image name
var tabs = ["Today","Habit","Task","Setting"]
