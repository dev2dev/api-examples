//
//  StoriesViewController.m
//  stories
//
//  Created by Brian Moseley on 11/18/10.
//  Copyright 2010 Outside.in. All rights reserved.
//

#import "StoriesViewController.h"
#import "MD5.h"
#import "JSON.h"

NSString * const BASE_URL = @"http://hyperlocal-api.outside.in/v1.1";

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

    // clear display of existing stories
    self.stories = [NSArray array];
    [tableView reloadData];

    // fetch and show new stories
    self.stories = [self fetchStoriesInLocation:self.location];
    [tableView reloadData];
}

// story fetching

- (NSArray *)fetchStoriesInLocation:(NSString *)theLocation {
    NSString *escapedLocation = [theLocation stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSArray *locations = [[self request:[NSString stringWithFormat:@"/locations/named/%@", escapedLocation]] objectForKey:@"locations"];
    if ([locations count] == 0) {
        NSLog(@"No location named %@", theLocation);
        return [NSArray array];
    }
    NSString *uuid = [[locations objectAtIndex:0] objectForKey:@"uuid"];
    NSString *escapedUuid = [uuid stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return [[self request:[NSString stringWithFormat:@"/locations/%@/stories", escapedUuid]] objectForKey:@"stories"];
}

- (NSDictionary *)request:(NSString *)relativePath {
    NSDictionary* data = nil;
    NSURL *url = [self sign:relativePath];
    NSLog(@"Requesting %@", url);
    NSError *requestErr = nil;
    NSString* str = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&requestErr];
    if (requestErr == nil) {
        SBJsonParser *parser = [SBJsonParser new];
        NSError *parseErr = nil;
        data = [parser objectWithString:str error:&parseErr];
        if (parseErr != nil) {
            NSLog(@"Parse failed: %@", [parseErr localizedDescription]);
        }
        [parser release];
    } else {
        NSLog(@"Request failed: %@", [requestErr localizedDescription]);
    }
    return data;
}

- (NSURL *)sign:(NSString *)relativePath {
    long time = (long)[[NSDate date] timeIntervalSince1970];
    NSString* sig = [MD5 md5hex:[NSString stringWithFormat:@"%@%@%d", key, secret, time]];
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?dev_key=%@&sig=%@", BASE_URL, relativePath, key, sig]];
}

// UIView

- (void)viewDidLoad {
    self.stories = [NSArray array];
}

// UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

// UITableViewDataSource

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
    [keyField release];
    [secretField release];
    [locationField release];
    [tableView release];

    [key release];
    [secret release];
    [location release];
    [stories release];

    [super dealloc];
}


@end
