//
//  SecondaryButtonStyle.swift
//  VRSN
//
//  Created by Enrique on 30-04-21.
//

import Foundation
import SwiftUI

struct SecondaryButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
            .foregroundColor(Color.white)
            .frame(maxWidth: .infinity, maxHeight: 44)
                .background(Color(#colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1)).opacity(
                    configuration.isPressed ? 0.5: 1
                ))
            .cornerRadius(10)
    }
}
