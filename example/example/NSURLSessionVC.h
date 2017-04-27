//
//  Screen3VC.h
//  example
//
//  Created by NguyenTruongDoanh on 4/21/17.
//  Copyright © 2017 NguyenTruongDoanh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayVideoVC.h"

@interface NSURLSessionVC : UIViewController <NSURLSessionDelegate, NSURLSessionDownloadDelegate>

@property  (weak, nonatomic) NSString *content;
@property UIImageView *imgView;
@property NSString *progess;


-(void)downloadImageFromData;

@end
