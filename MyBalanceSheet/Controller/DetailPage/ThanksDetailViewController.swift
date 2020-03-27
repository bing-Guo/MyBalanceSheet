//
//  ThanksDetailViewController.swift
//  MyBalanceSheet
//
//  Created by Bing Guo on 2020/3/27.
//  Copyright © 2020 Bing Guo. All rights reserved.
//

import UIKit

class ThanksDetailViewController: UIViewController {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var textView: UITextView!
    
    var thankVM: ThanksModelView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigation()
        setView()
        setTextView()
    }
    
    func setNavigation() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor._summary_background
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor._summary_text]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor._summary_text]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    func setView() {
        view.backgroundColor = UIColor._app_background
        container.layer.borderColor = UIColor.white.cgColor
        container.layer.borderWidth = 1
        container.layer.cornerRadius = 8
        container.clipsToBounds = true
    }
    
    func setTextView() {
        guard let thanks = thankVM else { return }
        
        textView.isEditable = false
        
        let textAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(17))]
        
        let format = NSAttributedString(string: thanks.format, attributes: textAttributes)
        let link0 = thanks.links[0]
        let link1 = thanks.links[1]
        
        let linkString0 = NSMutableAttributedString(string: link0.string, attributes: textAttributes)
        linkString0.addAttribute(.link, value: link0.link, range: NSRange(location: 0, length: linkString0.length))
        
        let linkString1 = NSMutableAttributedString(string: link1.string, attributes: textAttributes)
        linkString1.addAttribute(.link, value: link1.link, range: NSRange(location: 0, length: linkString1.length))

        textView.attributedText = NSAttributedString(format: format, args: linkString0, linkString1)
    }
}
