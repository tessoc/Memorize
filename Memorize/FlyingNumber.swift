//
//  FlyingNumber.swift
//  Memorize
//
//  Created by Christophe on 09/11/2023.
//

import SwiftUI

struct FlyingNumber: View {
    
    let number: Int
    
    var body: some View {
        if number != 0 {
            Text(number, format: .number)
        }
    }
}

#Preview {
    FlyingNumber(number: 12)
}
