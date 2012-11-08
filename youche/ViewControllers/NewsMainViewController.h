//
//  RootViewController.h
//  HorizontalMenu
//
//  Created by Mugunth on 25/04/11.
//  Copyright 2011 Steinlogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKHorizMenu.h"

#import "NewsModel.h"
#import "NewsDetailViewController.h"

#import "News.h"
#import "NewsDetail.h"
#import "BlogUnit.h"
#import "ShareView.h"

#import "NewsCell.h"
#import "NewsBase.h"

#import "MessageSystemView.h"
#import "ASIProgressDelegate.h"
#import "MBProgressHUD.h"


@interface NewsMainViewController : UIViewController <MKHorizMenuDataSource, MKHorizMenuDelegate,UITableViewDelegate,UITableViewDataSource,EGORefreshTableHeaderDelegate,MBProgressHUDDelegate, UITabBarControllerDelegate,UIAlertViewDelegate>

{

    MKHorizMenu *_horizMenu;
    NSMutableArray *_items;   
    
    
    NSMutableArray * news;
    BOOL isLoading;
    BOOL isLoadOver;
    int allCount;
    //下拉刷新
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    
}

@property (nonatomic, retain) IBOutlet MKHorizMenu *horizMenu;
@property (nonatomic, retain) NSMutableArray *items;

@property (strong, nonatomic) IBOutlet UITableView *tableNews;
@property (strong, nonatomic) NewsDetailViewController *newsDetailView;
@property int catalog;
- (void)reloadType:(int)ncatalog;
- (void)reload:(BOOL)noRefresh;

//清空
- (void)clear;

//下拉刷新
- (void)refresh;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
