//
//  NewsDetailViewController.m
//  youche
//
//  Created by Alvin.liu on 12-11-8.
//
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController

@synthesize strLeftBar;
@synthesize strComments;
@synthesize uvNewsDetail;
@synthesize tfComments;
@synthesize vComments;

@synthesize btnShare;
@synthesize btnDigg;
@synthesize btnSendComments;

@synthesize commentsView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.hidesBottomBarWhenPushed = YES;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //返回按钮
    UIImage *imgBack = [UIImage imageNamed:@"l_L_03.png"];
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBack setTitle:self.strLeftBar forState:UIControlStateNormal];
    [btnBack setBackgroundImage:imgBack forState:UIControlStateNormal];
    [btnBack setFrame:CGRectMake(0.f, 0.f, imgBack.size.width, imgBack.size.height)];
    [btnBack addTarget:self action:@selector(actionBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnBack];
    self.navigationItem.leftBarButtonItem = backButtonItem;
    
    //评论按钮
    UIImage *imgComments = [UIImage imageNamed:@"l_R_12.png"];
    UIButton *btnComments = [UIButton buttonWithType:UIButtonTypeCustom];
    btnComments.tag = kBtnToComments;
    [btnComments setTitle:self.strComments forState:UIControlStateNormal];
    [btnComments setBackgroundImage:imgComments forState:UIControlStateNormal];
    [btnComments setFrame:CGRectMake(0.f, 0.f, imgComments.size.width, imgComments.size.height)];
    [btnComments addTarget:self action:@selector(actionComment:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *selectButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnComments];
    self.navigationItem.rightBarButtonItem = selectButtonItem;
    
    if (self.strComments == nil || [self.strComments isEqualToString:@"0评"]) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }

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

#pragma mark- Action methods

//返回新闻列表
- (void)actionBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

//进入评论页面
- (void)actionComment:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == kBtnToComments) {
        self.commentsView = [[CommentsViewController alloc] initWithNibName:@"CommentsViewController" bundle:nil];
        
        [UIView animateWithDuration:0.9 animations:^{
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:NO];
            [self.view addSubview:self.commentsView.view];
            [UIView commitAnimations];
        }];
        
        //评论按钮
        UIImage *imgComments = [UIImage imageNamed:@"l_R_12.png"];
        UIButton *btnComments = [UIButton buttonWithType:UIButtonTypeCustom];
        btnComments.tag = kBtnToArticle;
        [btnComments setTitle:@"文章" forState:UIControlStateNormal];
        [btnComments setBackgroundImage:imgComments forState:UIControlStateNormal];
        [btnComments setFrame:CGRectMake(0.f, 0.f, imgComments.size.width, imgComments.size.height)];
        [btnComments addTarget:self action:@selector(actionComment:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *selectButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnComments];
        self.navigationItem.rightBarButtonItem = selectButtonItem;
    }else if (btn.tag == kBtnToArticle){
    
        [UIView animateWithDuration:0.9 animations:^{
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:NO];
            [self.commentsView.view removeFromSuperview];
            [UIView commitAnimations];
        }];
        
        //评论按钮
        UIImage *imgComments = [UIImage imageNamed:@"l_R_12.png"];
        UIButton *btnComments = [UIButton buttonWithType:UIButtonTypeCustom];
        btnComments.tag = kBtnToComments;
        [btnComments setTitle:self.strComments forState:UIControlStateNormal];
        [btnComments setBackgroundImage:imgComments forState:UIControlStateNormal];
        [btnComments setFrame:CGRectMake(0.f, 0.f, imgComments.size.width, imgComments.size.height)];
        [btnComments addTarget:self action:@selector(actionComment:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *selectButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btnComments];
        self.navigationItem.rightBarButtonItem = selectButtonItem;
    }

    

}

#pragma mark- UITextField delegate method

//收回键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if (self.tfComments == textField) {
        [self.tfComments resignFirstResponder];
    }
    
    
    self.vComments.frame = CGRectMake(0.0, 480 - 44 -44 -20, 320.0, 44.0);
    CGRect rect =  self.tfComments.frame;
    self.tfComments.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width - 30, rect.size.height);
    
    self.btnSendComments.hidden = YES;
    self.btnShare.hidden = NO;
    self.btnDigg.hidden = NO;
    
    return YES;
}

//开始编辑文本
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.vComments.frame = CGRectMake(0.0, 100.0, 320.0, 44.0);
    CGRect rect =  self.tfComments.frame;
    self.tfComments.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width+30, rect.size.height);
   
    self.btnSendComments.hidden = NO;
    self.btnShare.hidden = YES;
    self.btnDigg.hidden = YES;
}


@end
