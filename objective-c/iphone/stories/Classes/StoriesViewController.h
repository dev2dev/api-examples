//
//  StoriesViewController.h
//  stories
//
//  Created by Brian Moseley on 11/18/10.
//  Copyright 2010 Outside.in. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StoriesViewController : UIViewController<UITextFieldDelegate> {
	UITextField *keyField;
	UITextField *secretField; // XXX: replace with password field
	UITextField *locationField;
	
	UILabel *resultLabel; // XXX: replace or augment with a scrolling table
	
	NSString *key;
	NSString *secret;
	NSString *location;
}

@property (nonatomic, retain) IBOutlet UITextField *keyField;
@property (nonatomic, retain) IBOutlet UITextField *secretField;
@property (nonatomic, retain) IBOutlet UITextField *locationField;
@property (nonatomic, retain) IBOutlet UILabel *resultLabel;

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *secret;
@property (nonatomic, copy) NSString *location;

- (IBAction)fetchStories:(id)sender;

@end
