//
//  StoriesViewController.m
//  stories
//
//  Created by Brian Moseley on 11/18/10.
//  Copyright 2010 Outside.in. All rights reserved.
//

#import "StoriesViewController.h"


@implementation StoriesViewController

@synthesize keyField;
@synthesize secretField;
@synthesize locationField;
@synthesize resultLabel;

@synthesize key;
@synthesize secret;
@synthesize location;

- (IBAction)fetchStories:(id)sender {
	self.key = keyField.text;
	self.secret = secretField.text;
	self.location = locationField.text;
	
	// XXX: validate that key, secret and location were all provided
	
	// XXX: delegate to a StoryFetcher object to return a list of stories
	
	resultLabel.text = [[[NSString alloc] initWithFormat:@"%d stories found in %@.", 0, location] autorelease];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

- (void)dealloc {
    [super dealloc];
}


@end
