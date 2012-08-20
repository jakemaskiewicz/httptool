//
//  HTTPToolParamsTableViewController.m
//  httptool
//
//  Created by Jacob Maskiewicz on 8/16/12.
//  Copyright (c) 2012 Jacob Maskiewicz. All rights reserved.
//

#import "HTTPToolParamsTableViewController.h"

@interface HTTPToolParamsTableViewController ()

@end

@implementation HTTPToolParamsTableViewController
@synthesize paramTable = _paramTable;
@synthesize list = _list;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"initing with nib");
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //
    }
    
    return self;
}

- (void)awakeFromNib {
    self.list = [[NSMutableArray alloc] init];
}

- (IBAction)add:(id)sender {

    NSMutableDictionary* d = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                       @"Key",@"key",
                       @"Value",@"value",
                       nil];
    [self.list addObject:d];

    [self.paramTable reloadData];
}

- (IBAction)remove:(id)sender {
    NSInteger row = [self.paramTable selectedRow];
    
    [self.paramTable abortEditing];
    
    if(row >= 0 && row < [self.list count]) [self.list removeObjectAtIndex:row];
    [self.paramTable reloadData];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return [self.list count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:
(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    NSDictionary* d = [self.list objectAtIndex:row];
    
    return [d objectForKey:[tableColumn identifier]];
    
}

- (void)tableView:(NSTableView *)tableView setObjectValue:(id)object
   forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {

    NSMutableDictionary* d = [self.list objectAtIndex:row];
    
    [d setObject:object forKey:tableColumn.identifier];

}

- (NSDictionary*)getParamsDictionary {
    
    NSMutableDictionary* o = [NSMutableDictionary dictionary];
    
    for (NSDictionary* d in self.list) {
        [o setObject:[d objectForKey:@"value"] forKey:[d objectForKey:@"key"]];
    }
    
    return o;
}

@end
