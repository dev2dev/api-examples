//
//  storiesAppDelegate.m
//  stories
//
//  Created by Brian Moseley on 11/18/10.
//  Copyright 2010 Outside.in. All rights reserved.
//

#import "storiesAppDelegate.h"
#import "StoriesViewController.h"

@implementation storiesAppDelegate

@synthesize window;
@synthesize storiesViewController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    StoriesViewController *aStoriesViewController = [[[StoriesViewController alloc] initWithNibName:@"StoriesViewController"
                                                                                             bundle:[NSBundle mainBundle]] autorelease];
    self.storiesViewController = aStoriesViewController;
    [window addSubview:[storiesViewController view]];

    [window makeKeyAndVisible];

    return YES;
}


- (void)dealloc {
    [window release];
    [storiesViewController release];
    [super dealloc];
}


@end
