//
//  NewsDetailViewController.h
//  youche
//
//  Created by Alvin.liu on 12-11-8.
//
//

#import <UIKit/UIKit.h>
#import "CommentsViewController.h"

#import "NewsContent.h"

//限定大图片尺寸
#define BIG_IMG_WIDTH 264
#define BIG_IMG_HEIGHT 300

enum{
    kBtnToComments = 10000,
    kBtnToArticle
}BtnRight;

@interface NewsDetailViewController : UIViewController<UITextFieldDelegate>


@property (copy, nonatomic) NSString *strLeftBar;
@property (copy, nonatomic) NSString *strComments;


@property (strong, nonatomic) IBOutlet UIWebView *uvNewsDetail;
@property (strong, nonatomic) IBOutlet UITextField *tfComments;
@property (strong, nonatomic) IBOutlet UIView *vComments;

@property (strong, nonatomic) IBOutlet UIButton *btnShare;
@property (strong, nonatomic) IBOutlet UIButton *btnDigg;
@property (strong, nonatomic) IBOutlet UIButton *btnSendComments;

@property int articleid;
@property (strong, nonatomic) CommentsViewController *commentsView;

@property (strong, nonatomic) NewsContent *newsContent;

- (void)reloadData:(NewsContent *)news;

@end
