//
//  StockAppTableViewCell.m
//  SimpleStockApp
//
//  Created by Eric on 12/1/14.
//  Copyright (c) 2014 Eric. All rights reserved.
//

#import "StockAppTableViewCell.h"

@implementation StockAppTableViewCell

//added to remove the separator inset
- (UIEdgeInsets)layoutMargins
{
    return UIEdgeInsetsZero;
}

@end
