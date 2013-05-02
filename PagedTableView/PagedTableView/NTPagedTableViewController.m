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
{
    NSIndexPath *selectedIndexPath;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // You need to set pagingEnabled to NO in order to make -scrollViewWillEndDragging ... be called;
    // table view just igonres pagingEnabled anyway.
    self.tableView.pagingEnabled            = NO;
    
    // Make snapping fast
    self.tableView.decelerationRate = UIScrollViewDecelerationRateFast;
}

#pragma mark CORE LOGIC

-(void)scrollViewWillEndDragging:(UIScrollView*)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint*)targetContentOffset {    
    // Variables
    CGPoint offset              = (*targetContentOffset);
    NSIndexPath* indexPath      = [self.tableView indexPathForRowAtPoint:(*targetContentOffset)];   // Get index path for target row
    int numberOfRow = [self tableView:(UITableView *)scrollView numberOfRowsInSection:(NSInteger)indexPath.section];
    
    /* Find closest row at *targetContentOffset */
    
    // Row at *targetContentOffset
    CGRect rowRect      = [self.tableView rectForRowAtIndexPath:indexPath];

    // temporary assign
    selectedIndexPath = indexPath;
    CGRect targetRect   = rowRect;


    // Next Row
    if (indexPath.row < numberOfRow - 1 ){
        NSIndexPath *nextPath   = [NSIndexPath indexPathForRow: indexPath.row + 1 inSection: indexPath.section];
        CGRect nextRowRect      = [self.tableView rectForRowAtIndexPath: nextPath];
        
        // Compare distance
        // if next row is closer, set target rect 
        if (fabs(offset.y - CGRectGetMinY(nextRowRect)) < fabs(offset.y - CGRectGetMinY(rowRect))){
            targetRect          = nextRowRect;
            selectedIndexPath   = nextPath;
        }
    }
    
    /* Centering */ 
    offset = targetRect.origin;
    if (self.centering){
        offset.y -= (self.tableView.bounds.size.height * 0.5 - targetRect.size.height * 0.5);
    }
    
    // Assign return value
    (*targetContentOffset) = offset;
   
    // Snap speed
    // it seems it's better set it slow when the distance of target offset and current offset is small to avoid abrupt jumps
    float currentOffset = self.tableView.contentOffset.y;
    float rowH = targetRect.size.height;
    static const float thresholdDistanceCoef  = 0.25;
    if (fabs(currentOffset - (*targetContentOffset).y) > rowH * thresholdDistanceCoef){
        self.tableView.decelerationRate = UIScrollViewDecelerationRateFast;
    } else {
        self.tableView.decelerationRate = UIScrollViewDecelerationRateNormal;
    }
}

// Indicate the selected row - for the demonstration purpose
- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.tableView selectRowAtIndexPath: selectedIndexPath animated: YES scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1; // arbitrary number for this sample project
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;// arbitrary number for this sample project
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300; // arbitrary number for this sample project
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

@end
