//
//  Screen4VC.h
//  example
//
//  Created by NguyenTruongDoanh on 4/25/17.
//  Copyright © 2017 NguyenTruongDoanh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface PlayVideoVC : UIViewController <NSURLSessionDelegate, NSURLSessionDownloadDelegate>

@property UIButton *playButton;
@property NSString *progess;
@property BOOL firtDownload;
@property NSURL *urlString;


-(void)downloadVideoWithURLString;

@end
