//
//  TopCollectionView.swift
//  testTaskForSurf
//
//  Created by Александр Мараенко on 13.02.2023.
//

import Foundation
import UIKit

class TopCollectionView: UICollectionView {

    private let flowLayout = UICollectionViewFlowLayout()
    private var labelData =  ["iOS", "Android", "Kotlin", "Pyton", "Java", "Flutter", "Design", "QA", "PM", "React"]
    private var shiftedName = ""
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: flowLayout)
        
        // настройка CollectionView
        viewSetting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // настройка CollectionView
    private func viewSetting() {

        flowLayout.minimumInteritemSpacing = 12
        flowLayout.scrollDirection = .horizontal
        
        backgroundColor = .none
        showsHorizontalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        bounces = false
        
        // датасурс и делегат
        delegate = self
        dataSource = self
        
        // регистрация ячейки
        register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
}
    
extension TopCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // количество ячеек
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labelData.count
    }
    
    // возвращает ячейку
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell {
            cell.streamTitle.text = labelData[indexPath.item]
            return cell
        }
        return UICollectionViewCell()
    }
    
    // при нажатии на ячейку она перемещается в начало массива
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        shiftedName = labelData[indexPath.item]
        labelData.remove(at: indexPath.item)
        labelData.insert(shiftedName, at: 0)
        
        collectionView.moveItem(at: indexPath, to: IndexPath(item: 0, section: 0))
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
    }
    
    // при нажатии на выделенную ячейку снимается выделение
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if collectionView.cellForItem(at: indexPath)?.isSelected ?? false {
            collectionView.deselectItem(at: indexPath, animated: true)
            return false
        }
        return true
    }
    
    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let font = UIFont(name: "Arial Bold", size: 14)
        let attributes = [NSAttributedString.Key.font : font as Any]
        let width = labelData[indexPath.item].size(withAttributes: attributes).width + 48

        return CGSize(width: width, height: 44)
    }
}

