//
//  ViewController.h
//  SimpleStockApp
//
//  Created by Eric on 12/1/14.
//  Copyright (c) 2014 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIOSocket.h"
#import "StockAppTableView.h"

@interface ViewController : UIViewController

@property (weak) IBOutlet StockAppTableView *stockView;

@property (weak) IBOutlet UITextField *stockField;
- (IBAction)addButton:(id)sender;

@end

