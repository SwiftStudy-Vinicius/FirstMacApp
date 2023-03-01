//
//  ContentView.swift
//  FirstMacApp
//
//  Created by Vinícius Flores Ribeiro on 07/02/23.
//

import SwiftUI

struct Option: Hashable {
    let title: String
    let imageName: String
}

struct ContentView: View {

    @State var currentOption = 0

    let options: [Option] = [
        .init(title: "Home", imageName: "house"),
        .init(title: "About", imageName: "info.circle"),
        .init(title: "Settings", imageName: "gear"),
        .init(title: "Social", imageName: "message")
    ]

    var body: some View {
        NavigationView {
            ListView(options: options,
                     currentSelection: $currentOption
            )
            switch currentOption {
            case 1:
                Text("Test macOS app")
            default:
                MainView()
            }
        }
        .frame(minWidth: 600, minHeight: 400)
    }
}

struct ListView: View {

    let options: [Option]
    @Binding var currentSelection: Int

    var body: some View {
        VStack {
            let current = options[currentSelection]
            ForEach(options, id: \.self) { option in
                HStack {
                    Image(systemName: option.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                    Text(option.title)
                        .foregroundColor(current == option ? Color(.linkColor) : Color(.labelColor))
                    Spacer()
                }
                .padding(8)
                .onTapGesture {
                    if currentSelection == 1 {
                        currentSelection = 0
                    } else {
                        currentSelection = 1
                    }

                }
            }

            Spacer()
        }
    }
}

struct MainView: View {

    let cols: [GridItem] = [
        .init(.flexible()),
        .init(.flexible()),
        .init(.flexible())
    ]

    let dogImages = Array(1...3).map{ "dog\($0)" }

    var body: some View {
        VStack {
            Image("header")
                .resizable()
                .aspectRatio(contentMode: .fit)

            LazyVGrid(columns: cols) {
                ForEach(dogImages, id: \.self) { imageName in
                    VStack {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)

                        Text("Dog name here")
                            .bold()
                    }.padding()
                }
            }

            Spacer()

        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
