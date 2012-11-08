//
//  FourMainViewController.h
//  youche
//
//  Created by Liu Lei on 12-11-8.
//
//

#import <UIKit/UIKit.h>
#import "CityListViewController.h"

@interface FourMainViewController : UIViewController


@property (strong, nonatomic) IBOutlet UITableView *tb4sList;
@property (strong, nonatomic) CityListViewController *cityListView;
@end
