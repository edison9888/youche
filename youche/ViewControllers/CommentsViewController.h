//
//  CommentsViewController.h
//  youche
//
//  Created by Coolin 006 on 12-11-8.
//
//

#import <UIKit/UIKit.h>

@interface CommentsViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tbComments;
@property (strong, nonatomic) IBOutlet UITextField *tfComments;
@property (strong, nonatomic) IBOutlet UIView *vComments;

@property (strong, nonatomic) IBOutlet UIButton *btnShare;
@property (strong, nonatomic) IBOutlet UIButton *btnDigg;
@property (strong, nonatomic) IBOutlet UIButton *btnSendComments;

@end
