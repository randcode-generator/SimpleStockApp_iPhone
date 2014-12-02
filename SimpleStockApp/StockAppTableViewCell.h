//
//  StockAppTableViewCell.h
//  SimpleStockApp
//
//  Created by Eric on 12/1/14.
//  Copyright (c) 2014 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StockAppTableViewCell : UITableViewCell

@property (weak) IBOutlet UILabel *symbol;
@property (weak) IBOutlet UILabel *price;
@property (weak) IBOutlet UILabel *history;

@end
