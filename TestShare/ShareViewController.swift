//
//  ShareViewController.swift
//  TestShare
//
//  Created by Laura Calinoiu on 01/03/16.
//  Copyright © 2016 3smurfs. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices
import Kanna

class ShareViewController: SLComposeServiceViewController {
  
  func fetchAndSetContentFromContext(){
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
            self.placeholder.appendContentsOf(unwrappedT+"\n")
          })
        }
      }
    }
  }

  override func presentationAnimationDidFinish() {
    super.presentationAnimationDidFinish()
    fetchAndSetContentFromContext()
  }
  
  override func isContentValid() -> Bool {
    return true
  }
  
  override func didSelectPost() {
    // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
    // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
    self.extensionContext!.completeRequestReturningItems([], completionHandler: nil)
  }
  
  override func configurationItems() -> [AnyObject]! {
    // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
    return []
  }
  
}
