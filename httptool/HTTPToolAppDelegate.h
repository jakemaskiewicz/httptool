//
//  HTTPToolAppDelegate.h
//  httptool
//
//  Created by Jacob Maskiewicz on 8/16/12.
//  Copyright (c) 2012 Jacob Maskiewicz. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface HTTPToolAppDelegate : NSObject <NSApplicationDelegate,RKRequestDelegate>

@property (assign) IBOutlet NSWindow *window;

@end
