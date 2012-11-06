//
//  CityListViewController.m
//  oschina
//
//  Created by Alvin.liu on 12-11-1.
//
//

#import "CityListViewController.h"
#import "NSDictionary-MutableDeepCopy.h"

@interface CityListViewController ()

@end

@implementation CityListViewController

@synthesize searchBarCity;
@synthesize tbCityList;

@synthesize arrAllCityKeys;
@synthesize dicRoot;
@synthesize dicRootTemp;
@synthesize isSearching;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"选择城市";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self resetSearch];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) back:(id) sender {
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return ([self.arrAllCityKeys count] > 0) ? [self.arrAllCityKeys count] : 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 44.f;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	
	if ([self.arrAllCityKeys count] == 0)
        return 0;
    NSString *key = [self.arrAllCityKeys objectAtIndex:section];
    NSArray *nameSection = [self.dicRootTemp objectForKey:key];
    return [nameSection count];
}

//索引键值关键字
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
	
	NSMutableArray *array = [NSMutableArray arrayWithArray:self.arrAllCityKeys];
	
	for (int i = 0; i < [array count]; i++) {
        //[array replaceObjectAtIndex:0 withObject:@"已选"];
        if ([array count] > 1) {
            [array replaceObjectAtIndex:0 withObject:@"热点"];
        }
		
	}
	
	return array;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
							 SectionsTableIdentifier];
    //if (cell == nil) {
    cell = [[UITableViewCell alloc]
            initWithStyle:UITableViewCellStyleDefault
            reuseIdentifier:SectionsTableIdentifier];
    //}
    
	NSUInteger section = [indexPath section];
	NSUInteger row = [indexPath row];
	
	NSString *key = [self.arrAllCityKeys objectAtIndex:section];
	NSArray *nameSection = [self.dicRootTemp objectForKey:key];
	
    
//    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bar_01.png"]];
//    cell.backgroundColor = [UIColor clearColor];
    
    NSDictionary *theDic = [nameSection objectAtIndex:row];
    NSString * theStr = [theDic objectForKey:@"name"];
    cell.textLabel.text = theStr;
    
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//	// create the parent view that will hold header Label
//    UIImage *pointBar=[UIImage imageNamed:@""];//pointbar_01.png
//	UIImageView* customView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, pointBar.size.width, pointBar.size.height)];
//	customView.image=pointBar;
//	// create the button object
//	UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0,pointBar.size.width, pointBar.size.height)];
//	headerLabel.backgroundColor = [UIColor clearColor];
//	//headerLabel.textColor = [UIColor];
//	headerLabel.font = [UIFont systemFontOfSize:12.0];
//    [customView addSubview:headerLabel];
//	
//	if ([self.arrAllCityKeys count]) {
//		NSString *key = [self.arrAllCityKeys objectAtIndex:section];
//		
//		if ([key isEqualToString:@"0"]) {
//			headerLabel.text = @"热点";
//		}else {
//			headerLabel.text = key;//
//		}
//	}else {
//		return nil;
//	}
//	
//	
//    
//	return customView;
//}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString *strTitle = @"";
    if ([self.arrAllCityKeys count]) {
    	NSString *key = [self.arrAllCityKeys objectAtIndex:section];
    
    	if ([key isEqualToString:@"0"]) {
    		strTitle = @"热点";
    	}else {
    		strTitle = key;//
    	}
    }else {
    	return nil;
    }
    
    return strTitle;
}


//- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//	return 22.0;//[UIImage imageNamed:@"pointbar_01.png"].size.height;
//}


#pragma mark -
#pragma mark Custom Methods
- (void)resetSearch {
	
	NSString *myFilePath = [[NSBundle mainBundle] pathForResource:@"CityList" ofType:@"plist"];
	NSDictionary *_dicRoot = [NSDictionary dictionaryWithContentsOfFile:myFilePath];
	self.dicRoot = _dicRoot;
	NSArray *allKey = [self.dicRoot allKeys];
	
	
	// 排序
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
	
    NSArray *sortedArray = [allKey sortedArrayUsingDescriptors:sortDescriptors];
	
	self.arrAllCityKeys = [NSMutableArray arrayWithArray:sortedArray];
	
    NSMutableDictionary *allNamesCopy = [self.dicRoot mutableDeepCopy];
    self.dicRootTemp = allNamesCopy;
}

- (void)handleSearchForTerm:(NSString *)searchTerm {
	
	NSMutableArray *keyToRemove = [[NSMutableArray alloc] init];
	
    [self resetSearch];
    
    for (NSString *key in self.arrAllCityKeys) {
		NSMutableArray *dicToRemove = [[NSMutableArray alloc] init];
        
        if ([key isEqualToString:@"-1"]) {
            continue;
        }
		NSMutableArray *dicArray = [self.dicRootTemp valueForKey:key];
        
		for (int i = 0; i < [dicArray count]; i++) {
			NSDictionary *dic2 = [dicArray objectAtIndex:i];
			NSMutableArray *nameToReMove = [[NSMutableArray alloc] init];
			
			for (NSString *name in dic2) {
				
				NSString *X = [dic2 objectForKey:name];
                
				if ([X rangeOfString:searchTerm options:NSCaseInsensitiveSearch].location == NSNotFound) {
					[nameToReMove addObject:name];
				}
			}
			if ([dic2 count] == [nameToReMove count]) {
				[dicToRemove addObject:dic2];
			}
		}
		if ([dicArray count] == [dicToRemove count]) {
			[keyToRemove addObject:key];
		}
		[dicArray removeObjectsInArray:dicToRemove];
	}
	
    [self.arrAllCityKeys removeObjectsInArray:keyToRemove];
    [self.tbCityList reloadData];
}

#pragma mark -
#pragma mark Search Bar Delegate Methods
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *searchTerm = [self.searchBarCity text];
	NSLog(@"searchTerm = %@", searchTerm);
    [self handleSearchForTerm:searchTerm];
	[searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar
    textDidChange:(NSString *)searchTerm {
    if ([searchTerm length] == 0) {
        [self resetSearch];
		//NSLog(@"searchTerm2 = %@", searchTerm);
        [self.tbCityList reloadData];
        return;
    }
    [self handleSearchForTerm:searchTerm];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    isSearching = NO;
    self.searchBarCity.text = @"";
	[self resetSearch];
    [self.tbCityList reloadData];
    [self.searchBarCity resignFirstResponder];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    isSearching = YES;
    [self.tbCityList reloadData];
}

#pragma mark -
#pragma mark uiscrollView delete
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //[tooles playMusic:@"listscroll.caf"];
}


@end
