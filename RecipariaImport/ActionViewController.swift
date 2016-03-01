//
//  ActionViewController.swift
//  RecipariaImport
//
//  Created by Laura Calinoiu on 01/03/16.
//  Copyright © 2016 3smurfs. All rights reserved.
//

import UIKit
import MobileCoreServices
import Kanna

class ActionViewController: UIViewController {

  @IBOutlet weak var textView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
    for item: AnyObject in self.extensionContext!.inputItems {
      let inputItem = item as! NSExtensionItem
      for provider: AnyObject in inputItem.attachments! {
        let itemProvider = provider as! NSItemProvider
        if itemProvider.hasItemConformingToTypeIdentifier(kUTTypePropertyList as String) {
          itemProvider.loadItemForTypeIdentifier(kUTTypePropertyList as String, options: nil, completionHandler: { (dict, error) in
            
            let itemDictionary = dict as! NSDictionary
            let javaScriptValues = itemDictionary[NSExtensionJavaScriptPreprocessingResultsKey] as! NSDictionary
            
            self.extractHTML(javaScriptValues)
          })
          break
        }
      }
    }
  }
  
  func extractHTML(javaScriptValues: NSDictionary) {
    if let doc = Kanna.HTML(html: javaScriptValues["body"] as! String, encoding: NSUTF8StringEncoding) {
      for link in doc.xpath("//*[preceding-sibling::*[contains(.,'Ne trebuie')] and following-sibling::*[contains(., 'Cum se fac')]]") {
        if let unwrappedT = link.text{
          dispatch_async(dispatch_get_main_queue(), {
            self.textView.text.appendContentsOf(unwrappedT+"\n")
          })
        }
      }
    }
  }
  
  @IBAction func done() {
    self.extensionContext!.completeRequestReturningItems(self.extensionContext!.inputItems, completionHandler: nil)
  }
  
}
