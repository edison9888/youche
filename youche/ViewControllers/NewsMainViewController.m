//
//  RootViewController.m
//  HorizontalMenu
//
//  Created by Mugunth on 25/04/11.
//  Copyright 2011 Steinlogic. All rights reserved.
//

#import "NewsMainViewController.h"

@implementation NewsMainViewController

@synthesize horizMenu = _horizMenu;
@synthesize items = _items;
@synthesize selectionItemLabel = _selectionItemLabel;


- (void)viewDidLoad
{
    self.items = [NSArray arrayWithObjects:@"资讯", @"新闻", @"经验", @"保险", @"售后", @"保养", @"维修", nil];    
    [self.horizMenu reloadData];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}


-(void) viewDidAppear:(BOOL)animated
{
    [self.horizMenu setSelectedIndex:0 animated:YES];
}

- (void)dealloc
{
    [super dealloc];
}

#pragma mark -
#pragma mark HorizMenu Data Source
- (UIImage*) selectedItemImageForMenu:(MKHorizMenu*) tabMenu
{
    return [[UIImage imageNamed:@"ButtonSelected"] stretchableImageWithLeftCapWidth:16 topCapHeight:0];
}

- (UIColor*) backgroundColorForMenu:(MKHorizMenu *)tabView
{
    return [UIColor colorWithPatternImage:[UIImage imageNamed:@"MenuBar"]];
}

- (int) numberOfItemsForMenu:(MKHorizMenu *)tabView
{
    return [self.items count];
}

- (NSString*) horizMenu:(MKHorizMenu *)horizMenu titleForItemAtIndex:(NSUInteger)index
{
    return [self.items objectAtIndex:index];
}

#pragma mark -
#pragma mark HorizMenu Delegate
-(void) horizMenu:(MKHorizMenu *)horizMenu itemSelectedAtIndex:(NSUInteger)index
{        
    self.selectionItemLabel.text = [self.items objectAtIndex:index];
}
@end
