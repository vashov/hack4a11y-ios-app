//
//  LogoBackgroundView.swift
//  Objectiver
//
//  Created by Борис Вашов on 24.10.2021.
//

import SwiftUI

struct LogoBackgroundView: View {
    var body: some View {
        Image("LogoBackground")
            .resizable()
            .scaledToFit()
            .padding()
    }
}

struct LogoBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        LogoBackgroundView()
    }
}
