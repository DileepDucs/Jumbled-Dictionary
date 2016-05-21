//
//  SearchResultTableViewController.m
//  DileepTestDemo
//
//  Created by cdp on 27/05/15.
//  Copyright (c) 2015 dileep. All rights reserved.
//

#import "SearchResultTableViewController.h"

@interface SearchResultTableViewController ()

@end

@implementation SearchResultTableViewController
@synthesize searchResult;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Search Result";
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [searchResult count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [searchResult objectAtIndex:indexPath.row];
    return cell;
}

@end
