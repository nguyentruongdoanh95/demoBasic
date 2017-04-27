//
//  Screen3VC.m
//  example
//
//  Created by NguyenTruongDoanh on 4/21/17.
//  Copyright © 2017 NguyenTruongDoanh. All rights reserved.
//

#import "NSURLSessionVC.h"
#import "PlayVideoVC.h"


@implementation NSURLSessionVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    [self downloadImageFromData];
}

-(void)createUI {
    self.navigationItem.title = @"Load hình";
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];

    [self.view addSubview:self.imgView];
    UIButton *clickButton = [UIButton buttonWithType:UIButtonTypeSystem];
    float sizeButton = 100;
    clickButton.frame = CGRectMake(self.view.frame.size.width / 2 - (sizeButton/2), self.view.frame.size.height - sizeButton, sizeButton, sizeButton);
    [clickButton setTitle:@"Click Me!" forState:UIControlStateNormal];
    [clickButton addTarget:self action:@selector(handlerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickButton];
}

-(void)handlerAction:(id)sender {
     PlayVideoVC *playVideoVC = [[PlayVideoVC alloc] init];
    [self.navigationController pushViewController:playVideoVC animated:YES];
}

-(void)downloadImageFromData {
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:[NSURL URLWithString:@"http://cdn.tutsplus.com/mobile/uploads/2013/12/sample.jpg"]];
    [downloadTask resume];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSData *data = [NSData dataWithContentsOfURL:location];
    if ([self.progess isEqualToString:@"1.00"]) {
        UIAlertController *myAlert = [UIAlertController alertControllerWithTitle:@"Thông báo" message:@"Download hình thành công !" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // Do something
        }];
        [myAlert addAction:okButton];
        [self presentViewController:myAlert animated:YES completion:^{
            // Do something
            dispatch_async(dispatch_get_main_queue(), ^{
                // [self.progressView setHidden:YES];
                [self.imgView setImage:[UIImage imageWithData:data]];
            });
            [session finishTasksAndInvalidate];
        }];
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    float myProgress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
    NSString *stringFormatter = [NSString stringWithFormat:@"%.02f", myProgress];
    self.progess = stringFormatter;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //[self.progressView setProgress:progress];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
