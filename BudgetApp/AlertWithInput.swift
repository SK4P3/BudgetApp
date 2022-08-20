//
//  AlertWithInput.swift
//  BudgetApp
//
//  Created by Alex Schnabl on 20.08.22.
//

import SwiftUI

struct alertTextField: Identifiable {
    var id = UUID()
    var hintText: String
    var keyboardType: UIKeyboardType = .default
}

extension View {
    func alertTF(title: String, message: String, textFields: [alertTextField],
                 primaryTitle: String, secondaryTitle: String,
                 primaryAction: @escaping ([String])->(), secondaryAction: @escaping ()->())
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for tf in textFields {
            alert.addTextField() { field in
                field.placeholder = tf.hintText
                field.keyboardType = tf.keyboardType
            }
        }
        
        alert.addAction(.init(title: secondaryTitle, style: .default, handler: { _ in secondaryAction()
        }))
        
        alert.addAction(.init(title: primaryTitle, style: .default, handler: { _ in
            var returnList = [String]()
            
            for idx in 0...(alert.textFields!.count-1) {
                returnList.append(alert.textFields![idx].text!)
            }
            
            primaryAction(returnList)
        }))
        
        rootController().present(alert, animated: true, completion: nil)
    }
    
    func rootController()->UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return .init()
        }
        
        return root
    }
}
