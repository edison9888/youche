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

@synthesize newsContent;
@synthesize articleid;

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

    
    [self loadNewsDetail];
}


- (void)loadNewsDetail
{

    //self.uvNewsDetail.delegate = self;
    [self.uvNewsDetail loadHTMLString:@"" baseURL:nil];
    
    if ([Config Instance].isNetworkRunning)
    {
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
        [Tool showHUD:@"正在加载" andView:self.view andHUD:hud];
        
        NSString *strDataType = @"xml";
        int intArticleid = self.articleid;
        NSString *url = [NSString stringWithFormat:@"%@%@?datatype=%@&articleid=%d", kServerRoot,kAPIGetArticles, strDataType, intArticleid];
        
        NSLog(@"Articles = %@", url);
        
        [[AFOSCClient sharedClient] getPath:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"Article content =%@", operation.responseString);
            
            [Tool getOSCNotice2:operation.responseString];
            [hud hide:YES];
            
            self.newsContent = [Tools readStrNewsContent:operation.responseString];
            if (self.newsContent == nil) {
                [Tool ToastNotification:@"加载失败" andView:self.view andLoading:NO andIsBottom:NO];
                return;
            }
            [self reloadData:self.newsContent];
            
            //如果有网络 则缓存它
            if ([Config Instance].isNetworkRunning)
            {
                [Tool saveCache:1 andID:self.newsContent.articleid andString:operation.responseString];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [hud hide:YES];
            if ([Config Instance].isNetworkRunning) {
                [Tool ToastNotification:@"错误 网络无连接" andView:self.view andLoading:NO andIsBottom:NO];
            }
            
        }];
    }
    else
    {
        NSString *value = [Tool getCache:1 andID:self.newsContent.articleid];
        if (value) {
            self.newsContent = [Tools readStrNewsContent:value];
            [self reloadData:self.newsContent];
        }
        else {
            [Tool ToastNotification:@"错误 网络无连接" andView:self.view andLoading:NO andIsBottom:NO];
        }
    }
}

//显示网页 和调整
- (void)reloadData:(NewsContent *)news
{
    
    NSString *strOld = @"<img src=\"/md/";
    //NSString *tmp = @"<a href='pic:huoxing.jpg'>";
    NSString *strNew = [NSString stringWithFormat:@"<img width=\"250\" height=\"200\" src=\"%@/md/", kServerIP];
    
    //调整高度
    NSString *html = [NSString stringWithFormat:@"%@%@",news.content, HTML_Bottom];
  
    NSString *result = [Tools replaceHtmoldStr:strOld byNewStr:strNew intoContent:html];
    
    //NSLog(@"html1 = %@", result);
    
    [self.uvNewsDetail loadHTMLString:result baseURL:nil];
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
#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//	NSString *picName = [[request URL] absoluteString];
//	NSLog(@"picName is %@",picName);
//	if ([picName hasPrefix:@"pic:"]) {
//		[self showBigImage:[picName substringFromIndex:4]];
//		return NO;
//	}else {
//		return YES;
//	}
    return YES;
}
#pragma mark -
//显示大图片
-(void)showBigImage:(NSString *)imageName{
	//创建灰色透明背景，使其背后内容不可操作
	UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
	[bgView setBackgroundColor:[UIColor colorWithRed:0.3
											   green:0.3
												blue:0.3
											   alpha:0.7]];
	[self.view addSubview:bgView];

	
	//创建边框视图
	UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BIG_IMG_WIDTH+16, BIG_IMG_HEIGHT+16)];
	//将图层的边框设置为圆脚
    borderView.layer.cornerRadius = 8;
	borderView.layer.masksToBounds = YES;
    //给图层添加一个有色边框
	borderView.layer.borderWidth = 8;
	borderView.layer.borderColor = [[UIColor colorWithRed:0.9
													green:0.9
													 blue:0.9
													alpha:0.7] CGColor];
	[borderView setCenter:bgView.center];
	[bgView addSubview:borderView];
	
	//创建关闭按钮
	UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[closeBtn setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
	[closeBtn addTarget:self action:@selector(removeBigImage:) forControlEvents:UIControlEventTouchUpInside];
	NSLog(@"borderview is %@",borderView);
	[closeBtn setFrame:CGRectMake(borderView.frame.origin.x+borderView.frame.size.width-20, borderView.frame.origin.y-6, 26, 27)];
	[bgView addSubview:closeBtn];
	
	//创建显示图像视图
	UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, BIG_IMG_WIDTH, BIG_IMG_HEIGHT)];
	[imgView setImage:[UIImage imageNamed:imageName]];
	[borderView addSubview:imgView];
    
}
//移除大图片
-(void)removeBigImage:(UIButton *)btn{
	[[btn superview] removeFromSuperview];
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
