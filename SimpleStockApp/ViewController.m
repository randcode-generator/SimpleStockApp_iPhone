//
//  ViewController.m
//  SimpleStockApp
//
//  Created by Eric on 12/1/14.
//  Copyright (c) 2014 Eric. All rights reserved.
//

#import "ViewController.h"
#import "StockAppTableViewCell.h"

@implementation ViewController
NSMutableArray *stocksArray;
NSMutableDictionary *stocksDictionary;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    stocksArray = [[NSMutableArray alloc] init];
    stocksDictionary = [[NSMutableDictionary alloc] init];
    _stockView.dataSource = _stockView;
    _stockView.stocksArray = stocksArray;
    _stockView.stocksDictionary = stocksDictionary;
    _stockView.allowsMultipleSelection = NO;
    
    [SIOSocket socketWithHost: @"http://localhost:3000" response: ^(SIOSocket *socket) {
        [socket on: @"message" callback: ^(SIOParameterArray *args) {
            NSDictionary *stockDictionary = (NSDictionary*) [args firstObject];
            
            StockAppTableViewCell *cell = [stocksDictionary valueForKey:[stockDictionary valueForKey:@"symbol"]];
            if (cell != nil) {
                cell.symbol.text = [stockDictionary valueForKey:@"symbol"];
                cell.price.text = [[stockDictionary valueForKey:@"price"] stringValue];
                cell.history.text = [stockDictionary valueForKey:@"history"];
            } else {
                StockAppTableViewCell * cell = [_stockView dequeueReusableCellWithIdentifier: @"StockAppTableViewCell"];
                cell.symbol.text = [stockDictionary valueForKey:@"symbol"];
                cell.price.text = [[stockDictionary valueForKey:@"price"] stringValue];
                cell.history.text = [stockDictionary valueForKey:@"history"];
                [stocksArray addObject:cell];
                [stocksDictionary setValue:cell forKey:cell.symbol.text];
                
                NSArray *arr = [NSArray arrayWithObjects: [NSIndexPath indexPathForRow:stocksArray.count - 1 inSection:0], nil];
                [_stockView insertRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationBottom];
            }
        }];
        [socket on: @"delete" callback: ^(SIOParameterArray *args) {
            NSDictionary *stockDictionary = (NSDictionary*) [args firstObject];
            StockAppTableViewCell *cell = [stocksDictionary valueForKey:[stockDictionary valueForKey:@"symbol"]];
            NSUInteger index = [stocksArray indexOfObject: cell];
            [stocksArray removeObject: cell];
            [stocksDictionary removeObjectForKey: cell];
            NSArray *arr = [NSArray arrayWithObjects: [NSIndexPath indexPathForRow:index inSection:0], nil];
            [_stockView deleteRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationBottom];
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addButton:(id)sender {
    NSString *symbol = [_stockField text];
    NSMutableString *urlStr = [[NSMutableString alloc] initWithString: @"http://localhost:3000/add/"];
    [urlStr appendString: symbol];
    NSURL *url = [NSURL URLWithString: urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url];
    [NSURLConnection sendSynchronousRequest: request returningResponse: nil error:nil];
    [_stockField resignFirstResponder];
    [_stockField setText: @""];
}
@end
