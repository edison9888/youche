//
//  NewsMainViewController.h
//  oschina
//
//  Created by Coolin 006 on 12-11-5.
//
//

#import <UIKit/UIKit.h>
#import "MKHorizMenu.h"


@interface NewsMainViewController : UIViewController <MKHorizMenuDataSource,
MKHorizMenuDelegate>


@property (strong, nonatomic) IBOutlet MKHorizMenu *topMenu;
@property (nonatomic, assign) IBOutlet UILabel *selectionItemLabel;
@property (strong, nonatomic) NSMutableArray *arrMenuItems;


@end
