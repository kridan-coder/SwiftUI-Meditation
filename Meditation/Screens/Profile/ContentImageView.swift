//
//  ContentImageView.swift
//  Meditation
//
//  Created by Daniel Krivelev on 19.01.2022.
//

import SwiftUI

struct ContentImageView: View {
  
  @State private var isScaled = false
  
  var isNavigationBarHidden = true
  
  var image: Image
  
  var body: some View {
    NavigationView {
      GeometryReader { screen in
        ZStack {
          Color("BackgroundColor")
            .ignoresSafeArea()
          
          VStack {
            Spacer()
            
            if isScaled {
              image
                .resizable()
                .scaledToFit()
                .onTapGesture(count: 2) {
                  isScaled.toggle()
                }
                .scaleEffect(2)
            } else {
              image
                .resizable()
                .scaledToFit()
                .onTapGesture(count: 2) {
                  isScaled.toggle()
                }
              
            }
            
            Spacer()
            HStack {
              Spacer()
              Button("удалить") {}
              Spacer()
              Button("закрыть") {}
              Spacer()
            }.padding(.bottom, 40)
              .font(.custom("Alegreya-Medium", size: 20))
              .foregroundColor(.white)
          }
        }
        
        
      }
      .navigationBarHidden(isNavigationBarHidden)
    }
  }
}

struct ContentImageView_Previews: PreviewProvider {
  static var previews: some View {
    ContentImageView(image: Image("Content1"))
  }
}

