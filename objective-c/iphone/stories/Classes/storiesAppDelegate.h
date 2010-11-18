//
//  storiesAppDelegate.h
//  stories
//
//  Created by Brian Moseley on 11/18/10.
//  Copyright 2010 Outside.in. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StoriesViewController;

@interface storiesAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	StoriesViewController *storiesViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) StoriesViewController *storiesViewController;

@end
