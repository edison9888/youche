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
    
    // Listen for keyboard.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];

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
        
        [UIView animateWithDuration:0.7 animations:^{
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
    
        [UIView animateWithDuration:0.7 animations:^{
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
    
    return YES;
}

//开始编辑文本
- (void)textFieldDidBeginEditing:(UITextField *)textField
{

}

#pragma mark Keyboard Notifications

- (void)keyboardWillShow:(NSNotification *)notification {
    
    self.btnSendComments.hidden = NO;
    self.btnShare.hidden = YES;
    self.btnDigg.hidden = YES;
    
    CGRect rect =  self.tfComments.frame;
    self.tfComments.frame = CGRectMake(rect.origin.x, rect.origin.y, 200.0, rect.size.height);
    
    
    [self resizeViewWithOptions:[notification userInfo]];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    self.btnSendComments.hidden = YES;
    self.btnShare.hidden = NO;
    self.btnDigg.hidden = NO;
    
    CGRect rect =  self.tfComments.frame;
    self.tfComments.frame = CGRectMake(rect.origin.x, rect.origin.y, 170.0, rect.size.height);
    
    
    [self resizeViewWithOptions:[notification userInfo]];
}

- (void)resizeViewWithOptions:(NSDictionary *)options {
    
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    
    CGRect keyboardEndFrame;
    [[options objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[options objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    [[options objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndFrame];
    
    
    CGRect keyboardFrameEndRelative = [self.view convertRect:keyboardEndFrame fromView:nil];
    //NSLog(@"keyboardFrameEndRelative: %@", NSStringFromCGRect(keyboardFrameEndRelative));
    CGFloat keyBoardHeight =  keyboardFrameEndRelative.origin.y;
    //NSLog(@"keyBoardHeight: %f", keyBoardHeight);
    
    
    [UIView animateWithDuration:animationDuration animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationTransition:UIViewAnimationOptionTransitionNone forView:self.view cache:NO];
        self.vComments.frame = CGRectMake(0.0, keyBoardHeight - 44, 320.0, 44.0);
        [UIView commitAnimations];
    }];
    
}

@end
