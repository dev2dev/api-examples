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
@synthesize tableView;

@synthesize key;
@synthesize secret;
@synthesize location;
@synthesize stories;

- (IBAction)goPressed:(id)sender {
    self.key = keyField.text;
    self.secret = secretField.text;
    self.location = locationField.text;
	
    // XXX: validate that key, secret and location were all provided

    [self clearStories];
    [tableView reloadData];

    [self fetchStories];
    [tableView reloadData];

    // [[[NSString alloc] initWithFormat:@"%d stories found", [storyFetcher.stories count] autorelease];
}

- (void)viewDidLoad {
    self.stories = [NSMutableArray arrayWithCapacity:10];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)fetchStories {
    NSMutableDictionary *story = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"This is a story", @"title", nil];
    [stories addObject:story];
}

- (void)clearStories {
    [stories removeAllObjects];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [stories count];
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"story";
    UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    cell.textLabel.text = [[stories objectAtIndex:indexPath.row] valueForKey:@"title"];
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)theTableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)dealloc {
    [stories dealloc];
    [super dealloc];
}


@end
