//
//  Screen4VC.m
//  example
//
//  Created by NguyenTruongDoanh on 4/25/17.
//  Copyright © 2017 NguyenTruongDoanh. All rights reserved.
//

#import "PlayVideoVC.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@implementation PlayVideoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.firtDownload = YES;
    [self createUI];
}

-(void)createUI {
    self.navigationItem.title = @"Download video";
    UIButton *downloadButton = [UIButton buttonWithType:UIButtonTypeSystem];
    float sizeButton = 100;
    downloadButton.frame = CGRectMake(self.view.frame.size.width / 2 - (sizeButton/2), self.view.frame.size.height - sizeButton, sizeButton, sizeButton);
    [downloadButton setTitle:@"Download" forState:UIControlStateNormal];
    [downloadButton addTarget:self action:@selector(handlerAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:downloadButton];
    
    self.playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.playButton.frame = CGRectMake(self.view.frame.size.width / 2 - (sizeButton/2), self.view.frame.size.height / 2 - (sizeButton/2), sizeButton, sizeButton/2);
    [self.playButton setTitle:@"Play" forState:UIControlStateNormal];
    self.playButton.backgroundColor = [UIColor redColor];
    [self.playButton setHidden:YES];
    [self.playButton addTarget:self action:@selector(handlerPlayVideoAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.playButton];
}

-(void)handlerPlayVideoAction:(id)sender {
    AVPlayer *avPlayer = [AVPlayer playerWithURL:self.urlString];
    AVPlayerViewController *avPlayerViewController = [[AVPlayerViewController alloc] init];
    avPlayerViewController.player = avPlayer;
    [self.view addSubview:avPlayerViewController.view];
    [self presentViewController:avPlayerViewController animated:YES completion:nil];
}

-(void)handlerAction:(id)sender {
    if (self.firtDownload) {
        [self downloadVideoWithURLString];
        self.firtDownload = NO;
    } else {
        NSLog(@"Đã từng download trước đó");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Thông báo" message:@"Video đang được download" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Download Video
-(void)downloadVideoWithURLString {
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:[NSURL URLWithString:@"https://s3-eu-west-1.amazonaws.com/alf-proeysen/Bakvendtland-MASTER.mp4"]];
    [downloadTask resume];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *urlDocuments = [fileManager URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL *fileURL = [urlDocuments URLByAppendingPathComponent:@"test.mp4"];
    [fileManager moveItemAtURL:location toURL:fileURL error:nil];
    
    NSLog(@"%@", fileURL);
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.progess isEqualToString:@"1.00"]) {
            self.urlString = fileURL;
            self.playButton.hidden = NO;
        }
    });
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    float myProgress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
    NSString *stringFormatter = [NSString stringWithFormat:@"%.02f", myProgress];
    self.progess = stringFormatter;
    NSLog(@"%@", self.progess);
}

@end
