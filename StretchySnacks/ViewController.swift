//
//  ViewController.swift
//  StretchySnacks
//
//  Created by Eric Gregor on 2018-03-01.
//  Copyright © 2018 Eric Gregor. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var navBarViewHeight: NSLayoutConstraint!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var stackView : UIStackView = UIStackView()
    var navLabel = UILabel()

    var snacks = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
 
        stackView.axis = UILayoutConstraintAxis.horizontal
        stackView.distribution = UIStackViewDistribution.equalSpacing
        stackView.alignment = UIStackViewAlignment.bottom
        stackView.spacing = 8.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alpha = 0

        navBarView.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: navBarView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: navBarView.bottomAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: navBarView.bottomAnchor).isActive = true
        
        let imageArray = [["title" : "Oreos", "image" : "oreos"],
                          ["title" : "Pizza Pockets", "image" : "pizza_pockets"],
                          ["title" : "Pop Tarts", "image" : "pop_tarts"],
                          ["title" : "Popsicle", "image" : "popsicle"],
                          ["title" : "Ramen", "image" : "ramen"]]

        for i in 0..<imageArray.count {
            let imageView = UIImageView()
            imageView.heightAnchor.constraint(equalToConstant: 75).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
            
            imageView.image = UIImage(named: imageArray[i]["image"]!)
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapGestureRecognizer)
            imageView.accessibilityIdentifier = imageArray[i]["title"]

            stackView.addArrangedSubview(imageView)
        }
        
        navLabel.text = "SNACKS"
        navLabel.sizeToFit()
        navLabel.translatesAutoresizingMaskIntoConstraints = false
        
        navBarView.addSubview(navLabel)
        
        navLabel.centerXAnchor.constraint(equalTo: navBarView.centerXAnchor).isActive = true
        navLabel.centerYAnchor.constraint(equalTo: navBarView.centerYAnchor).isActive = true

    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        snacks.append(tappedImage.accessibilityIdentifier!)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func plusButtonPressed(_ sender: UIButton) {
        navBarStretch()
    }
    
    func navBarStretch() {
        self.stackView.alpha = self.stackView.alpha == 0 ? 1 : 0

        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            if self.navBarViewHeight.constant == 200 {
                self.navBarViewHeight.constant = 66
                self.plusButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
            } else {
                self.navBarViewHeight.constant = 200
                self.plusButton.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4)
            }
            self.view.layoutIfNeeded()
       }, completion: nil)
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snacks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomTableViewCell  else {
            fatalError("The dequeued cell is not an instance of UITableViewCell.")
        }
        
        cell.snackLabel.text = snacks[indexPath.row]
        cell.snackLabel.sizeToFit()
        
        return cell
    }
    
}

