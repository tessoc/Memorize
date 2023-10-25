//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Christophe on 25/10/2023.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    var items: [Item]
    var aspectRatio: CGFloat = 1
    var content: (Item) -> ItemView
    
    init(_ items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: items.count,
                size: geometry.size,
                atAspectRatio: aspectRatio
            )
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(items) { item in
                    content(item).aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }
    
    func gridItemWidthThatFits(
        count: Int,
        size: CGSize,
        atAspectRatio aspectRatio: CGFloat
    ) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        let sizeheight = 700.0 // pour debug : ne fonctionne pas avec size.height
        print("count: \(count), size.width: \(size.width), size.height: \(size.height)")
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < sizeheight {
                let fits = (size.width / columnCount).rounded(.down)
                print("gridItemWidthThatFits: \(fits)")
                return fits
            }
            columnCount += 1
        } while columnCount < count
        // FIXME: calcul incorrect ? ne fonctionne pas !
        let fits = min(size.width / Double(count), sizeheight * aspectRatio).rounded(.down)
        print("gridItemWidthThatFits: \(fits)")
        return fits
        
        return 85
    }
    
}
