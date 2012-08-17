//
//  HTTPToolParamsTableViewController.h
//  httptool
//
//  Created by Jacob Maskiewicz on 8/16/12.
//  Copyright (c) 2012 Jacob Maskiewicz. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HTTPToolParamsTableViewController : NSViewController <NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *paramTable;

@property (strong) NSMutableArray* list;

- (IBAction)add:(id)sender;

- (IBAction)remove:(id)sender;

- (NSDictionary*)getParamsDictionary;

@end
