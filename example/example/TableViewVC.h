//
//  Screen2VC.h
//  example
//
//  Created by NguyenTruongDoanh on 4/21/17.
//  Copyright © 2017 NguyenTruongDoanh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSURLSessionVC.h"
@interface TableViewVC : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate>

@property (strong, nonatomic) UITableView *myTableView;
@property (strong, nonatomic) NSMutableArray *myData;
@property (strong, nonatomic) NSMutableArray *myDataAfterFilter;
@property (strong, nonatomic) UISearchController *mySearchController;

-(void)loadJsonWithURLString;
-(void)createUI;
@end
