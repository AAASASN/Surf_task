//
//  SheetViewController.swift
//  testTaskForSurf
//
//  Created by Александр Мараенко on 13.02.2023.
//

import UIKit

protocol InfiniteCollectionViewDataSource {
    func cellForItemAtIndexPath(_ collectionView: UICollectionView,
                                dequeueIndexPath: IndexPath,
                           usableIndexPath: IndexPath) -> UICollectionViewCell
    
    func numberOfItems(_ collectionView: UICollectionView) -> Int
    
} // добавил в SheetViewController

protocol InfiniteCollectionViewDelegate {
    func didSelectCellAtIndexPath(_ collectionView: UICollectionView,
                                   usableIndexPath: IndexPath)
}




class SheetViewController: UIViewController {
    
    // нижнее view, его лейбл и кнопка
    var bottomView: UIView!
    var sendButton: UIButton!
    var labelLeftNearSendButton: UILabel!
    
    // заглавный лейбл
    var titleLabel: UILabel!

    // лейбы расположенные под collectionView
    var topLabel: UILabel!
    var bottomLabel: UILabel!

    // CollectionView
    let topCollectionView = TopCollectionView()
    
    /// let bottomCollectionView = BottomCollectionView()

    // Свойство для infiniteCollectionView вместо bottomCollectionView
    var infiniteCollectionView: InfiniteCollectionView!
    
//    let cellItems = ["iOS", "Android", "Kotlin", "Pyton", "Java", "Flutter", "Design", "QA", "PM", "React"]
        let cellItems = ["1", "2", "3", "4", "5", "6"]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // конфигурация элементов
        viewsSetting()
        
        // добавление элементов в иерархию view
        addAllSubviews()
        
        // верстка элементов при помощи констрейтнов
        setConstraintsForAllElements()
        
        view.backgroundColor = .white
        
        // при начальном отображении SheetViewController нижние лейбл и CollectionView скрыты
        // bottomLabel.isHidden = true
        
        /// bottomCollectionView.isHidden = true
        // infiniteCollectionView.isHidden = true
        
    }

}


// MARK: - view settings
extension SheetViewController {
    
    // MARK: - viewsSetting()
    private func viewsSetting() {
        
        // Свойство для infiniteCollectionView
        infiniteCollectionView = {
            
            // let flowLayout = UICollectionViewFlowLayout()
            
//            let infiniteCollectionView = InfiniteCollectionView(frame: CGRect(x: 100, y: 100, width: 250, height: 100))
            
           let infiniteCollectionView = InfiniteCollectionView(frame: .zero)

//            let infiniteCollectionView = InfiniteCollectionView(frame: CGRect(x: 0, y: 0, width: 300, height: 200), collectionViewLayout: flowLayout)
            
            infiniteCollectionView.backgroundColor = UIColor.systemYellow
            
            infiniteCollectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cellCollectionView")
            //infiniteCollectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cellCollectionView")
            
            infiniteCollectionView.infiniteDataSource = self
            infiniteCollectionView.infiniteDelegate = self
            infiniteCollectionView.reloadData()
            
            return infiniteCollectionView
            
        }()

        bottomView = {
            let bottomView = UIView()
            
//            let gradient = CAGradientLayer()
//            let whiteAlpha0 = UIColor(red: 255, green: 255, blue: 255, alpha: 0).cgColor
//            let whiteAlpha1 = UIColor(red: 255, green: 255, blue: 255, alpha: 1).cgColor
//            gradient.colors = [whiteAlpha0, whiteAlpha1]
//            gradient.locations = [0, 0.3, 1]
//            bottomView.layer.addSublayer(gradient)
//            gradient.frame = bottomView.frame
            
            bottomView.backgroundColor = .white
            return bottomView
            
        }()
        
        sendButton = {
            let sendButton = UIButton()
            sendButton.frame = CGRect(x: 100, y: 100, width: 219, height: 60)
            sendButton.backgroundColor = .black
            sendButton.layer.cornerRadius = sendButton.bounds.height / 2
            sendButton.setTitle("Отправить заявку", for: .normal)
            sendButton.titleLabel?.text = "Отправить заявку"
            sendButton.setTitleColor(.white, for: .normal)
            sendButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
            
            // добавление alertController при нажании
            sendButton.addAction(UIAction(handler: { _ in
                
                let alertController = UIAlertController(title: "Поздравляем!",
                                                        message: "Ваша заявка успешно отправлена!",
                                                        preferredStyle: UIAlertController.Style.alert)
                
                let alertAction = UIAlertAction(title: "Закрыть",
                                                style: UIAlertAction.Style.default)
                
                alertController.addAction(alertAction)
                self.present(alertController, animated: true)
                
            }), for: .allEvents)
            
            return sendButton
            
        }()
        
        labelLeftNearSendButton = {
            let labelLeftNearSendButton = UILabel()
            labelLeftNearSendButton.frame = CGRect(x: 20, y: 100, width: 120, height: 20)
            labelLeftNearSendButton.font = .init(name: "14_20_Regular SF", size: 14)
            labelLeftNearSendButton.textColor = .systemGray
            labelLeftNearSendButton.text = "Хочешь к нам?"
            return labelLeftNearSendButton
        }()
        
        titleLabel = {
            let titleLabel = UILabel()
            titleLabel.frame = CGRect(x: 20, y: 100, width: 214, height: 32)
            titleLabel.text = "Стажировка в Surf"
            titleLabel.font = .systemFont(ofSize: 23, weight: .bold)
            titleLabel.textColor = .black
            return titleLabel
        }()
        
        topLabel = {
            let topLabel = UILabel()
            topLabel.numberOfLines = 0
            topLabel.frame = CGRect(x: 20, y: 100, width: 335, height: 70)
            topLabel.textColor = .systemGray
            topLabel.font = .systemFont(ofSize: 14, weight: .regular)
            topLabel.text = "Работай над реальными задачами под руководством опытного наставника и получи возможность стать частью команды мечты."

            return topLabel
        }()
        
        bottomLabel = {

          let bottomLabel = UILabel()
            bottomLabel.numberOfLines = 0
            bottomLabel.frame = CGRect(x: 20, y: 100, width: 335, height: 50)
            bottomLabel.textColor = .systemGray
            bottomLabel.font = .systemFont(ofSize: 14, weight: .regular)
            bottomLabel.text = "Получай стипендию, выстраивай удобный график, работай на современном железе."

          return bottomLabel
      }()
        
        


    }
    
    // MARK: - addAllSubviews()
    private func addAllSubviews() {
        
        view.addSubview(titleLabel)
        view.addSubview(topCollectionView)
        
        ///view.addSubview(bottomCollectionView)
        view.addSubview(infiniteCollectionView)
        
        view.addSubview(topLabel)
        view.addSubview(bottomLabel)
        view.addSubview(bottomView)
        bottomView.addSubview(sendButton)
        bottomView.addSubview(labelLeftNearSendButton)


        
    }
    
    // MARK: - setConstraintsForAllElements()
    private func setConstraintsForAllElements() {
        
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        labelLeftNearSendButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
                
        infiniteCollectionView.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([

            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            bottomView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            bottomView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            bottomView.heightAnchor.constraint(equalToConstant: 120),
            
            sendButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -50),
            sendButton.leftAnchor.constraint(equalTo: labelLeftNearSendButton.rightAnchor, constant: 20),
            sendButton.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: -20),
            sendButton.heightAnchor.constraint(equalToConstant: 60),
            
            labelLeftNearSendButton.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 20),
            labelLeftNearSendButton.widthAnchor.constraint(equalToConstant: 120),
            labelLeftNearSendButton.heightAnchor.constraint(equalToConstant: 20),
            labelLeftNearSendButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -70),
            
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            titleLabel.widthAnchor.constraint(equalToConstant: 260),
            titleLabel.heightAnchor.constraint(equalToConstant: 32),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            
            topLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 17),
            topLabel.widthAnchor.constraint(equalToConstant: 335),
            topLabel.heightAnchor.constraint(equalToConstant: 70),
            
            topCollectionView.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 12),
            topCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            topCollectionView.heightAnchor.constraint(equalToConstant: 44),
            topCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            topCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
                        
            bottomLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            bottomLabel.heightAnchor.constraint(equalToConstant: 50),
            bottomLabel.widthAnchor.constraint(equalToConstant: 335),
            bottomLabel.topAnchor.constraint(equalTo: topCollectionView.bottomAnchor, constant: 24),
            
//            bottomCollectionView.topAnchor.constraint(equalTo: bottomLabel.bottomAnchor, constant: 12),
//            bottomCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
//            bottomCollectionView.heightAnchor.constraint(equalToConstant: 100),
//            bottomCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor)
            
            infiniteCollectionView.topAnchor.constraint(equalTo: bottomLabel.bottomAnchor, constant: 12),
            infiniteCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            infiniteCollectionView.heightAnchor.constraint(equalToConstant: 60),
            infiniteCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
            
//            infiniteCollectionView.topAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: 0),
//            infiniteCollectionView.leftAnchor.constraint(equalTo: bottomView.leftAnchor, constant: 0),
//            infiniteCollectionView.rightAnchor.constraint(equalTo: bottomView.rightAnchor, constant: 0),
//            infiniteCollectionView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: 0),

            
        ])
        
    }
    
}

// MARK: - расширение под протоколы InfiniteCollectionViewDataSource InfiniteCollectionViewDelegate
extension SheetViewController: InfiniteCollectionViewDataSource {
    
    func numberOfItems(_ collectionView: UICollectionView) -> Int {
        return cellItems.count
    }
    
    func cellForItemAtIndexPath(_ collectionView: UICollectionView, dequeueIndexPath: IndexPath, usableIndexPath: IndexPath)  -> UICollectionViewCell {
        let cell = infiniteCollectionView.dequeueReusableCell(withReuseIdentifier: "cellCollectionView", for: dequeueIndexPath) as! CollectionViewCell
        
//        cell.lbTitle.text = cellItems[usableIndexPath.row]
        cell.streamTitle.text = cellItems[usableIndexPath.row]
        
//        cell.lbTitle.textColor = .white
        cell.streamTitle.textColor = .white
        
//        cell.lbTitle.font = .systemFont(ofSize: 36)
        cell.streamTitle.font = .systemFont(ofSize: 36)
        
//        cell.backgroundImage.backgroundColor = .systemRed

        return cell
    }
} // добавил в SheetViewController

extension SheetViewController: InfiniteCollectionViewDelegate {
    func didSelectCellAtIndexPath(_ collectionView: UICollectionView, usableIndexPath: IndexPath) {
        print("\(cellItems[usableIndexPath.row])")
    }
}  // добавил SheetViewController
