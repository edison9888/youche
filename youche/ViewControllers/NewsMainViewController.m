//
//  NewsMainViewController.m
//  oschina
//
//  Created by Coolin 006 on 12-11-5.
//
//

#import "NewsMainViewController.h"
#import "MKHorizMenu.h"

@interface NewsMainViewController ()

@end

@implementation NewsMainViewController

@synthesize topMenu = _topMenu;
@synthesize arrMenuItems, selectionItemLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"新闻";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //初始化菜单数据
    self.arrMenuItems = [NSArray arrayWithObjects:@"资讯", @"新闻", @"事故", @"经验", @"博客", @"推荐", @"动态", nil];
    
    NSLog(@"xxx = %@", self.arrMenuItems);
    [self.topMenu reloadData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.topMenu setSelectedIndex:3 animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    return [self.arrMenuItems count];
}

- (NSString*) horizMenu:(MKHorizMenu *)horizMenu titleForItemAtIndex:(NSUInteger)index
{
    return [self.arrMenuItems objectAtIndex:index];
}

#pragma mark -
#pragma mark HorizMenu Delegate
-(void) horizMenu:(MKHorizMenu *)horizMenu itemSelectedAtIndex:(NSUInteger)index
{
    self.selectionItemLabel.text = [self.arrMenuItems objectAtIndex:index];
}

@end
