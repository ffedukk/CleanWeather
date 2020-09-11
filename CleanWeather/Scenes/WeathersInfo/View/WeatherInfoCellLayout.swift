//
//  TownCellLayout.swift
//  CleanWeather
//
//  Created by 18592232 on 11.09.2020.
//  Copyright © 2020 18592232. All rights reserved.
//

import UIKit

class WeatherInfoCellLayout: UICollectionViewLayout {
    
    //    MARK: Properties
    
    private var cache: [UICollectionViewLayoutAttributes] = []
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        return collectionView.bounds.width
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    //    MARK: Prepare
    
    override func prepare() {
        guard let collectionView = collectionView, cache.isEmpty else { return }
        var yOffset: CGFloat = 0
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            var itemHeight: CGFloat = 70
            if item == 0 {
                itemHeight = 300
            } else if item == 1 {
                itemHeight = 100
            }
            
            let frame = CGRect(x: 0,
                               y: yOffset,
                               width: contentWidth,
                               height: itemHeight)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            cache.append(attributes)
            
            yOffset += itemHeight
            contentHeight = yOffset
        }
    }
    
    //    MARK: LayoutAttributesForElement
    
    override func layoutAttributesForElements(in rect: CGRect)
        -> [UICollectionViewLayoutAttributes]? {
            var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
            
            // Loop through the cache and look for items in the rect
            for attributes in cache {
                if attributes.frame.intersects(rect) {
                    visibleLayoutAttributes.append(attributes)
                }
            }
            return visibleLayoutAttributes
    }
    
    //    MARK: LayoutAttributesForItem
    
    override func layoutAttributesForItem(at indexPath: IndexPath)
        -> UICollectionViewLayoutAttributes? {
            return cache[indexPath.item]
    }
    
    //    MARK: InvalidateLayout
    
    override func invalidateLayout() {
        cache = []
    }
    
}
