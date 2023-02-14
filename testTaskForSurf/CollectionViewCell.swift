//
//  CollectionViewCell.swift
//  testTaskForSurf
//
//  Created by Александр Мараенко on 13.02.2023.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    let streamTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = self.isSelected ? .black : .systemGray5
            streamTitle.textColor =  self.isSelected ? .white : .black
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setView()
        constraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView(){
        backgroundColor = .systemGray5
        layer.cornerRadius = 11
        addSubview(streamTitle)
    }
    
    private func constraints(){
        NSLayoutConstraint.activate([
            streamTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            streamTitle.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

