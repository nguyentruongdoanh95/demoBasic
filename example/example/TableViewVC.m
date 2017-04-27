//
//  Screen2VC.m
//  example
//
//  Created by NguyenTruongDoanh on 4/21/17.
//  Copyright © 2017 NguyenTruongDoanh. All rights reserved.
//

#import "TableViewVC.h"
#import "NSURLSessionVC.h"


@implementation TableViewVC


// MARK: Life cycle
-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    [self createData];
    //[self loadJsonWithURLString: ];
}

// MARK: CreateUI
-(void)createUI {
    // Configure Navigation
    [self configureNavigationController];
    // Create tableview
    [self createMyTableView];
    // Create searchController
    [self createMySearchController];
    
}
-(void)configureNavigationController {
    self.view.backgroundColor = [UIColor yellowColor];
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.hidesBackButton = YES;
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
}

-(void)createMyTableView {
    self.myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    [self.view addSubview:self.myTableView];
}
-(void)createMySearchController {
    self.mySearchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.mySearchController.searchResultsUpdater = self;
    [self.mySearchController setDimsBackgroundDuringPresentation:NO];
    [self.mySearchController setHidesNavigationBarDuringPresentation:NO];
    [self.mySearchController.searchBar sizeToFit];
    self.definesPresentationContext = YES;
    self.mySearchController.searchBar.placeholder = @"Enter your search...";
    self.mySearchController.searchBar.delegate = self;
    self.navigationItem.titleView = self.mySearchController.searchBar;
}

-(void)createData {
    self.myData = [[NSMutableArray alloc] init]; // Init
    [self.myData addObject:@"Apples"];
    [self.myData addObject:@"Oranges"];
    [self.myData addObject:@"Pears"];
    [self.myData addObject:@"Grapes"];
    [self.myData addObject:@"Grapefruits"];
    [self.myData addObject:@"Lemons"];
    [self.myData addObject:@"Peaches"];
    [self.myData addObject:@"Pineapples"];
    [self.myData addObject:@"Cherries"];
    [self.myData addObject:@"Bananas"];
    [self.myData addObject:@"Watermelons"];
    [self.myData addObject:@"Cantaloupes"];
    [self.myData addObject:@"Limes"];
    [self.myData addObject:@"Strawberries"];
    [self.myData addObject:@"Blueberries"];
    [self.myData addObject:@"Raspberries"];
    self.myDataAfterFilter = [[NSMutableArray alloc] init]; // Init
    [self loadJsonWithURLString];
}


-(void)loadJsonWithURLString {
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"https://itunes.apple.com/search?term=apple&media=software"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"%lu", (unsigned long)[json count]);
    }];
    
    [dataTask resume];
}


// MARK: UITableviewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.mySearchController isActive] && (![self.mySearchController.searchBar.text  isEqual: @""])) {
        return [self.myDataAfterFilter count];
    }
    return [self.myData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    if ([self.mySearchController isActive] && (![self.mySearchController.searchBar.text  isEqual: @""])) {
        cell.textLabel.text = [self.myDataAfterFilter objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [self.myData objectAtIndex:indexPath.row];
    }
    return cell;
}

//MARK: UITableviewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSURLSessionVC *nsURLSessionVC = [[NSURLSessionVC alloc] init];
    if ([self.mySearchController isActive] && (![self.mySearchController.searchBar.text  isEqual: @""])) {
        nsURLSessionVC.content = [self.myDataAfterFilter objectAtIndex:indexPath.row];
    } else {
        nsURLSessionVC.content = [self.myData objectAtIndex:indexPath.row];
    }
    [self.navigationController pushViewController:nsURLSessionVC animated:YES];
}


// MARK: UISearchController
-(void)filterContentForSearchText:(NSString *)searchText{
    [self.myDataAfterFilter removeAllObjects];
    for (NSString *str in self.myData) {
        if ([str localizedCaseInsensitiveContainsString:searchText] == YES) {
            [self.myDataAfterFilter addObject:str];
        }
    }
    [self.myTableView  reloadData];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    [self filterContentForSearchText:self.mySearchController.searchBar.text];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}


@end
