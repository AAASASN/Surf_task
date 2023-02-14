//
//  InfiniteCollectionView.swift
//  testTaskForSurf
//
//  Created by Александр Мараенко on 14.02.2023.
//

import UIKit

class InfiniteCollectionView: UICollectionView {

    @IBInspectable var isHorizontalScroll: Bool = true
    
    var cellPadding: CGFloat = 0.0
    var cellWidth: CGFloat = 0.0
    var cellHeight: CGFloat = 0.0
    
    
    var indexOffset = 0
    var infiniteDataSource: InfiniteCollectionViewDataSource?
    var infiniteDelegate: InfiniteCollectionViewDelegate?
    
    private let flowLayout = UICollectionViewFlowLayout()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        dataSource = self
        delegate = self
        setupCellDimensions()
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        // настройка CollectionView
        dataSource = self
        delegate = self
        setupCellDimensions()
    }
    
    
    func setupCellDimensions() {
        let layout = self.collectionViewLayout as! UICollectionViewFlowLayout
        cellPadding = layout.minimumInteritemSpacing
        cellWidth = layout.itemSize.width
        cellHeight = layout.itemSize.height
        
        print(cellPadding)
        print(cellWidth)
        print(cellHeight)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isHorizontalScroll{
            centreIfNeeded()
        } else {
            centreVerticallyIfNeeded()
        }
    }

    func centreIfNeeded() {
        let currentOffset = contentOffset
        let contentWidth = getTotalContentWidth()

        print(contentWidth)
        
        let centerOffsetX: CGFloat = (3 * contentWidth - bounds.size.width) / 2
        let distFromCentre = centerOffsetX - currentOffset.x
        
        if (abs(distFromCentre) > (contentWidth / 4)) {
            let cellcount = distFromCentre/(cellWidth+cellPadding)
            
            let shiftCells = Int((cellcount > 0) ? floor(cellcount) : ceil(cellcount))
            
            let offsetCorrection = (abs(cellcount).truncatingRemainder(dividingBy: 1)) * (cellWidth+cellPadding)
            
            if (contentOffset.x < centerOffsetX) {
                contentOffset = CGPoint(x: centerOffsetX - offsetCorrection,
                                        y: currentOffset.y)
                contentOffset = CGPoint(x: centerOffsetX - offsetCorrection,
                                        y: currentOffset.y)
            } else if (contentOffset.x > centerOffsetX) {
                contentOffset = CGPoint(x: centerOffsetX + offsetCorrection,
                                        y: currentOffset.y)
            }
            shiftContentArray(getCorrectedIndex(shiftCells))
            reloadData()
        }
    }
    
    func centreVerticallyIfNeeded() {
        let currentOffset = contentOffset
        let contentHeight = getTotalContentHeight()
        
        let centerOffsetY: CGFloat = (3 * contentHeight ) / 2
        let distFromCentre = centerOffsetY - currentOffset.y
        
        if (abs(distFromCentre) > (contentHeight / 4)) {
            let cellcount = distFromCentre/(cellHeight + cellPadding)
            let shiftCells = Int((cellcount > 0) ? floor(cellcount) : ceil(cellcount))
            
            let offsetCorrection = (abs(cellcount).truncatingRemainder(dividingBy: 1)) * (cellHeight+cellPadding)
            
            if (contentOffset.y < centerOffsetY) {
                contentOffset = CGPoint(x: currentOffset.x,
                                        y: centerOffsetY - offsetCorrection)
            } else if (contentOffset.y > centerOffsetY) {
                contentOffset = CGPoint(x: currentOffset.x,
                                        y: centerOffsetY + offsetCorrection)
            }
            shiftContentArray(getCorrectedIndex(shiftCells))
            reloadData()
        }
    }

    func shiftContentArray(_ offset: Int) {
        indexOffset += offset
    }
    
    func getTotalContentWidth() -> CGFloat {
        let numberOfCells = infiniteDataSource?.numberOfItems(self) ?? 0
        return CGFloat(numberOfCells) * (cellWidth + cellPadding)
    }
    
    func getTotalContentHeight() -> CGFloat {
        let numberOfCells = infiniteDataSource?.numberOfItems(self) ?? 0
        return (CGFloat(numberOfCells) * (cellHeight + cellPadding)) - cellPadding
    }

}


extension InfiniteCollectionView {
    override var dataSource: UICollectionViewDataSource? {
        didSet {
            if (!self.dataSource!.isEqual(self)) {
                print("DataSource may not be modified.")
                self.dataSource = self
            }
        }
    }
    override var delegate: UICollectionViewDelegate? {
        didSet {
            if (!self.delegate!.isEqual(self)) {
                print("Delegate may not be modified.")
                self.delegate = self
            }
        }
    }
} // добавлены в отддельный файл InfiniteCollectionView


extension InfiniteCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItems = infiniteDataSource?.numberOfItems(self) ?? 0
        return  3 * numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return infiniteDataSource!.cellForItemAtIndexPath(self, dequeueIndexPath: indexPath, usableIndexPath: IndexPath(row: getCorrectedIndex(indexPath.row - indexOffset), section: 0))
    }
    
    func getCorrectedIndex(_ indexToCorrect: Int) -> Int {
        if let numberOfCells = infiniteDataSource?.numberOfItems(self) {
            if (indexToCorrect < numberOfCells && indexToCorrect >= 0) {
                return indexToCorrect
            } else {
                let countInIndex = Float(indexToCorrect) / Float(numberOfCells)
                let flooredValue = Int(floor(countInIndex))
                let offset = numberOfCells * flooredValue
                return indexToCorrect - offset
            }
        } else {
            return 0
        }
    }
} // добавлены в отддельный файл InfiniteCollectionView

extension InfiniteCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        infiniteDelegate?.didSelectCellAtIndexPath(self, usableIndexPath: IndexPath(row: getCorrectedIndex(indexPath.row - indexOffset), section: 0))
    }
} // добавлены в отддельный файл InfiniteCollectionView
