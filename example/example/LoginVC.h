//
//  ViewController.h
//  example
//
//  Created by NguyenTruongDoanh on 4/20/17.
//  Copyright © 2017 NguyenTruongDoanh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewVC.h"

@interface LoginVC : UIViewController <UITextFieldDelegate>
{
    
}

@property  NSTimer *autoTimer;
@property  UITextField *myUserName;
@property  UITextField *myPassword;
@property  UIButton *myLoginButton;
@property  UIButton *myRegisterButton;
@property  int countSyntax;
@property  int time;

-(void)showAlertWhenErrorSyntaxMoreTimes:(int)count times:(NSString *)times;
@end

