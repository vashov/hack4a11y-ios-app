//
//  CardView.swift
//  Objectiver
//
//  Created by Борис Вашов on 18.10.2021.
//

import SwiftUI

struct TaskCardView: View {
    let title: String
    let date: String
    let onPress: () -> Void
    
    var body: some View {
        Button(action: onPress, label: {
            VStack(alignment: .leading) {
                HStack {
//                    Image(systemName: "crown")
                    Text(title)
//                        .font(.headline)
                }
                .padding(.bottom)
                HStack {
                    Label(date.prefix(10), systemImage: "clock")
//                        .accessibilityElement(children: .ignore)
                    Spacer()
                    Label("1", systemImage: "rosette")
                        .padding(.trailing, 20)
                }
                
                .font(.caption)
            }
            .foregroundColor(Color.foregroundThird)
            .padding()
            .frame(width: UIScreen.main.bounds.width - 30)
        })
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.backgroundPrimary)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
//
                .frame(width: UIScreen.main.bounds.width - 30)
        )
        .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
        .frame(width: UIScreen.main.bounds.width - 30)
        .padding(.bottom)
    }
}

struct TaskCardView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCardView(title: "Help with moving", date: "2021/10/23") { }
    }
}
