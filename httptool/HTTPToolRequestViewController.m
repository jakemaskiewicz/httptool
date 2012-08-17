//
//  HTTPToolRequestViewController.m
//  httptool
//
//  Created by Jacob Maskiewicz on 8/16/12.
//  Copyright (c) 2012 Jacob Maskiewicz. All rights reserved.
//

#import <RestKit/RestKit.h>

#import "HTTPToolRequestViewController.h"
#import "HTTPToolParamsTableViewController.h"

@interface HTTPToolRequestViewController ()

@end

@implementation HTTPToolRequestViewController

@synthesize headers = _headers;

@synthesize baseURL = _baseURL, uriPath = _uriPath;
@synthesize protocol = _protocol, requestType = _requestType;
@synthesize ignoreSSL = _ignoreSSL, followRedirect = _followRedirect;
@synthesize headerTable = _headerTable;
@synthesize outputView = _outputView;
@synthesize paramController = _paramController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //
    }
    
    return self;
}

- (void)awakeFromNib {
    self.headers = [NSArray array];
}

- (IBAction)go:(id)sender {
    
    if ([self isInputValid]) {
        
        [self configureRKClient];
        
        //Request uri
        NSString* uri = self.uriPath.stringValue;
        
        //Create params dictionary
        //TODO
        NSDictionary* params = [self.paramController getParamsDictionary];
        
        //Create Request
        RKRequest* theRequest = [[RKClient sharedClient]
                                 requestWithResourcePath:uri];
        
        //Configure Request
        theRequest.delegate = self;
        theRequest.method = RKRequestMethodTypeFromName([self.requestType
                                                         titleOfSelectedItem]);
        
        theRequest.followRedirect = (self.followRedirect.state == NSOnState);
        
        theRequest.params = params;
        
        //Send Request
        NSLog(@"%@ Request to %@\n",self.requestType.titleOfSelectedItem, uri);
        
        [theRequest send];
    } else {
        NSLog(@"Invalid Input");
    }
}

- (void)configureRKClient {
    NSString* baseURL = [NSString stringWithFormat:@"%@%@",
                         self.protocol.titleOfSelectedItem,
                         self.baseURL.stringValue];
    
    [RKClient setSharedClient:[RKClient clientWithBaseURLString:baseURL]];
    
    [RKClient sharedClient].disableCertificateValidation = (self.ignoreSSL.state
                                                            == NSOnState);
    
    printf("\n\n");

}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    NSLog(@"Headers count: %ld",[self.headers count]);
    return [self.headers count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:
(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    NSDictionary* d = [self.headers objectAtIndex:row];
    
    return [d objectForKey:[tableColumn identifier]];
    
}

- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response {
    
    printf("\n\n");
    NSLog(@"RESPONSE RECIEVED!");
    
    NSArray* keys = [response.allHeaderFields allKeys];
    
    NSMutableArray* headers = [NSMutableArray array];
        
    [headers addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                        [NSString stringWithFormat: @"%ld %@",
                       response.statusCode, response.localizedStatusCodeString],
                        @"value",
                        @"Status",@"key",
                        nil]];
    
    for (id key in keys) {
        NSDictionary* d = [NSDictionary dictionaryWithObjectsAndKeys:
                           key,@"key",
                        [response.allHeaderFields objectForKey:key] ,@"value",
                           nil];
        [headers addObject:d];
    }
        
    self.headers = headers;
    
    [self.headerTable reloadData];
    
    NSString* body = response.bodyAsString;

    NSError* e = nil;
    
    id json = [NSJSONSerialization JSONObjectWithData:response.body options:NSJSONWritingPrettyPrinted error:&e];
    
    if (!json) {
        NSLog(@"json parse error: %@",e);
    } else {
        body = [NSString stringWithFormat:@"%@",json];
    }

    [[self.outputView textStorage] setAttributedString: [[NSAttributedString alloc] initWithString:body]];
    
    [[self.outputView textStorage] setFont:[NSFont fontWithName:@"Menlo" size:13.0]];
    
    
}

- (BOOL)isInputValid {
    
    BOOL valid = true;
    
    NSLog(@"Base Url: %@",self.baseURL.stringValue);
    
    valid = valid && [self.baseURL.stringValue length] > 0;
    
    if ([self.uriPath.stringValue length] == 0) {
        self.uriPath.stringValue = @"/";
    }
    
    return valid;
    
}

@end
