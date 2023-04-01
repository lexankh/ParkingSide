//
//  ContentView.swift
//  ParkingSide
//
//  Created by Алексей Хорошавин on 31.03.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        getSign()
    }
}

struct OddSign: View {
    var body: some View {
        Image("odd")
    }
}

struct EvenSign: View {
    var body: some View {
        Image("even")
    }
}

struct BothSign: View {
    var body: some View {
        HStack {
            Image("odd")
            Image("even")
        }
    }
}

func getSign() -> some View {
    let date = Date()
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    let dateNumber = calendar.component(.day, from: date)
    
    
    if(hour < 19) {
        if(dateNumber % 2 == 0) {
            return AnyView(EvenSign())
        } else {
            return AnyView(OddSign())
        }
    }
    return AnyView(BothSign())
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
