//
//  StockAppTableView.h
//  SimpleStockApp
//
//  Created by Eric on 12/1/14.
//  Copyright (c) 2014 Eric. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StockAppTableView : UITableView <UITableViewDataSource>

@property NSMutableArray *stocksArray;
@property NSMutableDictionary *stocksDictionary;

@end
