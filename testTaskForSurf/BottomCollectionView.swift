//
//  BottomCollectionView.swift
//  testTaskForSurf
//
//  Created by Александр Мараенко on 13.02.2023.
//

import Foundation
import UIKit

class BottomCollectionView: UICollectionView {

    private let flowLayout = UICollectionViewFlowLayout()
    private var labelData =  ["iOS", "Android", "PM", "Design", "Flutter", "QA", "Pyton", "Kotlin", "Java", "React"]
   
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: flowLayout)

        viewSetting()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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


extension BottomCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // количество ячеек
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        labelData.count
    }
    
    // возвращает ячейку
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell {
            cell.streamTitle.text = labelData[indexPath.item]
            return cell
        }
        return UICollectionViewCell()
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

