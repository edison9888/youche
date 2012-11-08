//
//  CommentsViewController.m
//  youche
//
//  Created by Coolin 006 on 12-11-8.
//
//

#import "CommentsViewController.h"

@interface CommentsViewController ()

@end

@implementation CommentsViewController

@synthesize tbComments;
@synthesize tfComments;
@synthesize vComments;

@synthesize btnShare;
@synthesize btnDigg;
@synthesize btnSendComments;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
