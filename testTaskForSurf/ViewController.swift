//
//  ViewController.swift
//  testTaskForSurf
//
//  Created by Александр Мараенко on 12.02.2023.
//
import UIKit

class ViewController: UIViewController {
    
    var viewBackground: UIImageView!
    let sheetViewController = SheetViewController()
    
    let smallId = UISheetPresentationController.Detent.Identifier("small")
    let mediumId = UISheetPresentationController.Detent.Identifier("medium")
    let largeId = UISheetPresentationController.Detent.Identifier("large")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSettings()
        sheetViewControllerDelegateSettings()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        present(sheetViewController, animated: true)
    }
    
}

// MARK: - scrollViewSettings()
extension ViewController {
    
    func viewSettings() {

        viewBackground = {
            let viewBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
            viewBackground.image = UIImage(named: "viewBackground")
            return viewBackground
        }()
        
        view.addSubview(viewBackground)
        
    }
}

// MARK: - sheetViewControllerDelegateSettings()
extension ViewController {
    
    // настройка фиксаторов для sheetViewController
    func sheetViewControllerDelegateSettings() {
        
        let smallDetent = UISheetPresentationController.Detent.custom(identifier: smallId) { context in
            return 330
        }
        
        let mediumDetent = UISheetPresentationController.Detent.custom(identifier: mediumId) { context in
            return 515
        }
        
        let largeDetent = UISheetPresentationController.Detent.custom(identifier: largeId) { context in
            return self.view.frame.maxY
        }
        
        guard let sheet = sheetViewController.sheetPresentationController else { return }
        sheet.detents = [mediumDetent, smallDetent, largeDetent]
        sheet.preferredCornerRadius = 24
        
        // назначение делегата
        sheet.delegate = self

    }
}

// MARK: - Sheet Delegate
extension ViewController: UISheetPresentationControllerDelegate {
    
    // метод для управления элементами sheetViewController при перемещении и фиксации контроллера
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
                
        if sheetPresentationController.selectedDetentIdentifier == largeId {
            
            /// sheetViewController.bottomCollectionView.isHidden = false
            sheetViewController.bottomLabel.isHidden = false
            
        } else if sheetPresentationController.selectedDetentIdentifier == mediumId {
            
            /// sheetViewController.bottomCollectionView.isHidden = false
            sheetViewController.bottomLabel.isHidden = false
            
        } else if sheetPresentationController.selectedDetentIdentifier == smallId {
            
            /// sheetViewController.bottomCollectionView.isHidden = true
            sheetViewController.bottomLabel.isHidden = true
            
        }
    }
}


