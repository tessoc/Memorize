//
//  CardView.swift
//  Memorize
//
//  Created by Christophe on 27/10/2023.
//

import SwiftUI


struct CardView: View {
    
    typealias Card = MemoryGame<String>.Card
    let card: Card
    
    init( _ card: MemoryGame<String>.Card) {
        self.card = card
    }
        
    var body: some View {
        Pie(endAngle: .degrees(240))
            .opacity(Constants.Pie.opacity)
            .overlay(
                Text(card.content)
                // https://youtu.be/4CkEVfdqjLw?t=3350
                    .font(.system(size: Constants.FontSize.largest))
                    .minimumScaleFactor(Constants.FontSize.scaleFactor)
                    .aspectRatio(1,contentMode: .fit)
                    .padding(Constants.Pie.inset)
                    .rotationEffect(.degrees(card.isMatched ? 360 : 0))
                    .animation(.spin(duration: 2), value: card.isMatched)
            )
            .padding(Constants.inset)
            .cardify(isFaceUp: card.isFaceUp)
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
    
    private struct Constants {
//        static let cornerRadius: CGFloat = 12
//        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
        struct Pie {
            static let opacity: CGFloat = 0.4
            static let inset: CGFloat = 5
        }
    }
}

extension Animation {
    static func spin(duration: TimeInterval) -> Animation {
        .linear(duration: 1).repeatForever(autoreverses: false)
    }
}




#Preview("CardView") {
    VStack {
        HStack {
            CardView(CardView.Card(isFaceUp: true, content: "W", id: "test1"))
            CardView(CardView.Card(content: "X", id: "test2"))
        }
        HStack {
            CardView(CardView.Card(isFaceUp: true, content: "Y", id: "test1"))
            CardView(CardView.Card(isMatched: true, content: "X", id: "test2"))
        }
    }
    .padding()
    .foregroundColor(.green)
}
