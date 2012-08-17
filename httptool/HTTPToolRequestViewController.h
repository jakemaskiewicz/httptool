//
//  HTTPToolRequestViewController.h
//  httptool
//
//  Created by Jacob Maskiewicz on 8/16/12.
//  Copyright (c) 2012 Jacob Maskiewicz. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class HTTPToolParamsTableViewController;

@interface HTTPToolRequestViewController : NSViewController <NSTableViewDataSource,RKRequestDelegate>

@property (strong) NSArray* headers;

@property (weak) IBOutlet NSTextField *baseURL;
@property (weak) IBOutlet NSTextField *uriPath;

@property (weak) IBOutlet NSPopUpButton *protocol;
@property (weak) IBOutlet NSPopUpButton *requestType;

@property (weak) IBOutlet NSButton *ignoreSSL;
@property (weak) IBOutlet NSButton *followRedirect;

@property (weak) IBOutlet NSTableView *headerTable;

@property (unsafe_unretained) IBOutlet NSTextView *outputView;

@property (unsafe_unretained) IBOutlet HTTPToolParamsTableViewController* paramController;

- (IBAction)go:(id)sender;

- (BOOL)isInputValid;

- (void)configureRKClient;

@end
