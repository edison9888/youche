//
//  CityListViewController.h
//  oschina
//
//  Created by Alvin.liu on 12-11-1.
//
//

#import <UIKit/UIKit.h>

@interface CityListViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISearchBar *searchBarCity;
@property (strong, nonatomic) IBOutlet UITableView *tbCityList;

//add by liulei 11.10.28
@property (assign, nonatomic) BOOL isSearching;
@property (strong,nonatomic) NSMutableArray *arrAllCityKeys;
@property (strong,nonatomic) NSDictionary *dicRoot;
@property (strong,nonatomic) NSDictionary *dicRootTemp;

- (void)resetSearch;
- (void)handleSearchForTerm:(NSString *)searchTerm;
@end
