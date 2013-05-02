//
//  NTViewController.m
//  PagedTableView
//
//  Created by Nao Tokui on 5/2/13.
//  Copyright (c) 2013 Nao Tokui. All rights reserved.
//

#import "NTViewController.h"
#import "NTPagedTableViewController.h"
@interface NTViewController ()

@end

@implementation NTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Paging TableView";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) buttonPressed: (UIButton *)sender
{
    
    NTPagedTableViewController *viewCtl = [[NTPagedTableViewController alloc] init];
    switch (sender.tag) {
        case 1:
            viewCtl.centering = YES;
            viewCtl.navigationItem.title = @"Paging w/ Centering";
            break;
        case 2:
            viewCtl.centering = NO;
            viewCtl.navigationItem.title = @"Paging w/o Centering";
            
            break;
        default:
            break;
    }
    [self.navigationController pushViewController: viewCtl animated:YES];
}

@end
