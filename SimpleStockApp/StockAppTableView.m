//
//  StockAppTableView.m
//  SimpleStockApp
//
//  Created by Eric on 12/1/14.
//  Copyright (c) 2014 Eric. All rights reserved.
//

#import "StockAppTableView.h"
#import "StockAppTableViewCell.h"

@implementation StockAppTableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    StockAppTableViewCell *cell = [_stocksArray objectAtIndex:[indexPath row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _stocksArray.count;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //send HTTP GET to nodeJS to delete stock
        StockAppTableViewCell *cell = (StockAppTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        NSMutableString *urlStr = [[NSMutableString alloc] initWithString: @"http://localhost:3000/delete/"];
        [urlStr appendString: cell.symbol.text];
        NSURL *url = [NSURL URLWithString: urlStr];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
        [NSURLConnection sendSynchronousRequest: request returningResponse: nil error:nil];
    }
}
@end
