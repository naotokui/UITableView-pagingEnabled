//
//  NTPagedTableViewController.m
//  PagedTableView
//
//  Created by Nao Tokui on 5/1/13.
//  Copyright (c) 2013 Nao Tokui. All rights reserved.
//

#import "NTPagedTableViewController.h"

@interface NTPagedTableViewController ()

@end

@implementation NTPagedTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.decelerationRate = UIScrollViewDecelerationRateFast;
  //  self.centering = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 

-(void)scrollViewWillEndDragging:(UIScrollView*)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint*)targetContentOffset {
    NSIndexPath *selectedIndexPath;
    
    // Get index path for target row
    CGPoint offset = (*targetContentOffset);
    NSIndexPath* indexPath = [self.tableView indexPathForRowAtPoint:(*targetContentOffset)];
    selectedIndexPath = indexPath;
    
    int row = indexPath.row;
    int numberOfRow = [self tableView:(UITableView *)scrollView numberOfRowsInSection:(NSInteger)indexPath.section];
    
    CGRect rowRect = [self.tableView rectForRowAtIndexPath:indexPath];
    CGRect targetRect = rowRect;
    CGPoint origin = targetRect.origin;
    if (self.centering){
        
        origin.y -= (self.tableView.bounds.size.height * 0.5 - targetRect.size.height * 0.5);
        
    }

    if (row <= numberOfRow - 1 ){
        NSIndexPath *nextPath = [NSIndexPath indexPathForRow: row + 1 inSection: indexPath.section];
        CGRect nextRowRect = [self.tableView rectForRowAtIndexPath: nextPath];
        
        if (fabs(offset.y - nextRowRect.origin.y) < fabs(offset.y - origin.y)){
                                      targetRect = nextRowRect;
            selectedIndexPath = nextPath;
        }
    }
    
    origin = targetRect.origin;
    if (self.centering){
        origin.y -= (self.tableView.bounds.size.height * 0.5 - targetRect.size.height * 0.5);
    }
    NSLog(NSStringFromCGPoint(origin));
    
    (*targetContentOffset) = origin;
    
    [self.tableView selectRowAtIndexPath: selectedIndexPath animated: YES scrollPosition:UITableViewScrollPositionNone];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                                       reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %d", indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
