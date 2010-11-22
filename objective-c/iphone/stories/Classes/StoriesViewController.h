//
//  StoriesViewController.h
//  stories
//
//  Created by Brian Moseley on 11/18/10.
//  Copyright 2010 Outside.in. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const BASE_URL;

@interface StoriesViewController : UIViewController<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource> {
    UITextField *keyField;
    UITextField *secretField; // XXX: replace with password field
    UITextField *locationField;
    UITableView *tableView;
	
    NSString *key;
    NSString *secret;
    NSString *location;
    NSArray *stories;
}

@property (nonatomic, retain) IBOutlet UITextField *keyField;
@property (nonatomic, retain) IBOutlet UITextField *secretField;
@property (nonatomic, retain) IBOutlet UITextField *locationField;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *secret;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, retain) NSArray *stories;

- (IBAction)goPressed:(id)sender;
- (NSArray *)fetchStoriesInLocation:(NSString *)theLocation;
- (NSDictionary *)request:(NSString *)relativePath;
- (NSURL *)sign:(NSString *)relativePath;

@end
