//
//  MasterViewLayout.swift
//  Platimi
//
//  Created by Božidar on 31/03/2017.
//  Copyright © 2017 Božidar. All rights reserved.
//

import UIKit

class MasterViewLayout: UICollectionViewFlowLayout {

    let desiredInset: CGFloat = DeviceType.isPad ? 33.0 : DeviceType.is4Inch ? 15.0 : 20.0
    fileprivate let desiredItemWidth: CGFloat = DeviceType.isPad ? 215.0 :  DeviceType.is4InchOrLess ? 120.0 : 140.0
    fileprivate let desiredInterItemSpacing: CGFloat = DeviceType.isPad ? 33.0 : 22.0
    fileprivate let desiredLineSpacing: CGFloat =  DeviceType.isPad ? 35.0 : 30.0

    fileprivate let cellWidthToHeightRatio: CGFloat = 212/140

    var cachedAttributes = [UICollectionViewLayoutAttributes]()

    override init() {
        super.init()
        scrollDirection = .horizontal
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        scrollDirection = .horizontal
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard cachedAttributes.isEmpty else {
            return cachedAttributes
        }

        guard let attributes = super.layoutAttributesForElements(in: rect), attributes.count > 1  else {
            return super.layoutAttributesForElements(in: rect)
        }


        var attributesCopy = attributes.flatMap { $0.copy() as? UICollectionViewLayoutAttributes }
        for i in 1..<attributesCopy.count {
            let current = attributesCopy[i]
            let previous = attributesCopy[i-1]

            let initialPosition = previous.frame.maxX
            if initialPosition + desiredInterItemSpacing + current.frame.size.width < self.collectionViewContentSize.width {
                current.frame.origin.x = initialPosition + desiredInterItemSpacing
            }
        }
        return attributesCopy
    }

    override func prepare() {
        super.prepare()

        guard let collectionView = collectionView, collectionView.frame.width > 0.0 else {
            return
        }

        guard collectionView.numberOfSections > 0 else {
            cachedAttributes.removeAll()
            return
        }

        let n = CGFloat(collectionView.numberOfItems(inSection: 0))
        let maxItemWidth = (collectionView.frame.width - (n+1)*desiredInset)/n
        let itemWidth = maxItemWidth < desiredItemWidth ? maxItemWidth : desiredItemWidth
        let itemHeight = DeviceType.isPad ? (itemWidth * cellWidthToHeightRatio) : itemWidth * cellWidthToHeightRatio

        let inset: CGFloat
        if n < 4 {
            inset = (collectionView.frame.width - n*itemWidth - (n-1)*desiredInterItemSpacing)/2
            minimumLineSpacing = desiredLineSpacing
        } else {
            inset = (collectionView.frame.width - n*itemWidth)/(n+1)
            minimumLineSpacing = inset
        }

        itemSize = CGSize(width: itemWidth, height: itemHeight)
        sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)


        let xOffset = collectionView.contentOffset.x
        let offsetIsInBounds = xOffset < 0 || xOffset > collectionView.contentSize.width - collectionView.frame.width
        if (offsetIsInBounds) {
            return
        }
        let currentSection = Int(xOffset/collectionView.frame.width)
        let offsetInSection = xOffset - collectionView.frame.width*CGFloat(currentSection)
        cachedAttributes.removeAll()
        for sectionIndex in 0..<collectionView.numberOfSections {
            let itemsCount = collectionView.numberOfItems(inSection: sectionIndex)
            for itemIndex in 0..<itemsCount {
                let indexPath = IndexPath(row: itemIndex, section: sectionIndex)
                if let attributesForItem = layoutAttributesForItem(at: indexPath) {
                    var transform = CGAffineTransform.identity
                    if (sectionIndex == currentSection) {
                        let item = itemsCount-itemIndex
                        let translation = -offsetInSection*pow(CGFloat(item), 2)*0.05
                        transform = CGAffineTransform(translationX: translation, y: 0)
                    } else if (sectionIndex == currentSection+1) {
                        if (offsetInSection > 0) {
                            let translation = (collectionView.frame.width-offsetInSection)*pow(CGFloat(itemIndex+1), 5/2)*0.05
                            transform = CGAffineTransform(translationX: translation, y: 0)
                        }
                    }
//                    if sectionIndex == currentSection || (sectionIndex == currentSection+1 && offsetInSection > 0) {
                        attributesForItem.transform = transform
                        cachedAttributes.append(attributesForItem)
//                    }
                }
            }
        }
    }
}
