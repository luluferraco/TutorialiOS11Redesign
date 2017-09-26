//
//  VideoController.swift
//  DEVPUCTutorial
//
//  Created by Lucas Ferraço on 21/07/17.
//

import UIKit

class DogViewController: UIViewController {

	@IBOutlet weak var imageView: UIImageView!
	var selectedDog: String?
	
	override func viewDidLoad() {
        super.viewDidLoad()
		navigationItem.title = selectedDog!
		
		navigationItem.largeTitleDisplayMode = .never
		
		imageView.image = UIImage(named: selectedDog!)
    }
	
}

