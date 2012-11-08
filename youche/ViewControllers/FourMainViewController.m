//
//  FourMainViewController.m
//  youche
//
//  Created by Liu Lei on 12-11-8.
//
//

#import "FourMainViewController.h"

@interface FourMainViewController ()

@end

@implementation FourMainViewController

@synthesize tb4sList;
@synthesize cityListView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"4S店列表";
        
        //选择城市按钮
        UIImage *imgBack = [UIImage imageNamed:@"l_L_03.png"];
        UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnBack setTitle:@"城市" forState:UIControlStateNormal];
        [btnBack setBackgroundImage:imgBack forState:UIControlStateNormal];
        [btnBack setFrame:CGRectMake(0.f, 0.f, imgBack.size.width, imgBack.size.height)];
        [btnBack addTarget:self action:@selector(actionCity) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
        self.navigationItem.leftBarButtonItem = backButtonItem;
        
        //筛选按钮
        UIImage *imgComments = [UIImage imageNamed:@"l_R_12.png"];
        UIButton *btnComments = [UIButton buttonWithType:UIButtonTypeCustom];
        btnComments.tag = kBtnToComments;
        [btnComments setTitle:@"筛选" forState:UIControlStateNormal];
        [btnComments setBackgroundImage:imgComments forState:UIControlStateNormal];
        [btnComments setFrame:CGRectMake(0.f, 0.f, imgComments.size.width, imgComments.size.height)];
        [btnComments addTarget:self action:@selector(actionSift) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *selectButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnComments];
        self.navigationItem.rightBarButtonItem = selectButtonItem;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Action methods

//选择城市
- (void)actionCity
{
    self.cityListView = [[CityListViewController alloc] initWithNibName:@"CityListViewController" bundle:nil];
    [self.navigationController pushViewController:self.cityListView animated:YES];
}

//筛选
- (void)actionSift
{

}


@end
