//
//  ViewController.m
//  example
//
//  Created by NguyenTruongDoanh on 4/20/17.
//  Copyright © 2017 NguyenTruongDoanh. All rights reserved.
//

#import "LoginVC.h"
#import "TableViewVC.h"


@implementation LoginVC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    [self createUI];
}

-(void)createUI {
    UILabel *textTittle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    textTittle.backgroundColor = [UIColor redColor];
    textTittle.text = @"Nguyễn Trường Doanh";
    textTittle.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:textTittle];
    
    // TextField
    int setWidthMyTextField = 300; // width
    int setHeightMyTextField = 50; // height
    self.myUserName = [[UITextField alloc] initWithFrame:CGRectMake(self.view.center.x - setWidthMyTextField/2, textTittle.frame.origin.y + 60, setWidthMyTextField, setHeightMyTextField)];
    self.myUserName.borderStyle = UITextBorderStyleLine;
    self.myUserName.placeholder = @"Username";
    self.myUserName.tag = 1;
    self.myUserName.delegate = self;
    [self.view addSubview:self.myUserName];
    
    self.myPassword = [[UITextField alloc] initWithFrame:CGRectMake(self.myUserName.frame.origin.x, self.myUserName.frame.origin.y + 60, setWidthMyTextField, setHeightMyTextField)];
    self.myPassword.borderStyle = UITextBorderStyleLine;
    self.myPassword.placeholder = @"Password";
    self.myPassword.secureTextEntry = YES;
    self.myPassword.tag = 2;
    self.myPassword.delegate = self;
    [self.view addSubview:self.myPassword];
    
    // Button
    self.myLoginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.myLoginButton.frame = CGRectMake(self.myPassword.frame.origin.x, self.myPassword.frame.origin.y + setHeightMyTextField + 30, (setWidthMyTextField / 2) - 10, setHeightMyTextField);
    [self.myLoginButton setTitle:@"Login" forState:UIControlStateNormal];
    self.myLoginButton.backgroundColor = [UIColor redColor];
    [self.myLoginButton addTarget:self action:@selector(loginPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.myLoginButton];
    
    self.myRegisterButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.myRegisterButton.frame = CGRectMake(self.myLoginButton.frame.origin.x + 10 + setWidthMyTextField/2, self.myPassword.frame.origin.y + setHeightMyTextField + 30, (setWidthMyTextField / 2) - 10, setHeightMyTextField);
    [self.myRegisterButton setTitle:@"Register" forState:UIControlStateNormal];
    self.myRegisterButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.myRegisterButton];
    
}

// Làm gì đó khi nhấn login
-(void)loginPressed:(id)sender {
    if ([self.myUserName.text  isEqual: @"Admin"] && [self.myPassword.text  isEqual: @"123456789"]) {
        TableViewVC *tblVC = [[TableViewVC alloc] init];
        [self.navigationController pushViewController:tblVC animated:YES];
        self.countSyntax = 0;
    } else {
        self.countSyntax += 1;
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Thông báo" message:@"Tài khoản hoặc mật khẩu không đúng. Xin vui lòng kiểm tra lại." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self lockPassword];
            });
        }];
        [alert addAction:cancelButton];
        [self presentViewController:alert animated:YES completion:^{
            // Do something
        }];
    }
    self.myPassword.text = @"";
}

// Kiểm tra số lần nhập sai
-(void)lockPassword {
    switch (self.countSyntax) {
        case 3:
            self.myPassword.enabled = NO;
            self.autoTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handlerTimer:) userInfo:nil repeats:YES];
            [self showAlertWhenErrorSyntaxMoreTimes:3 times:@"5"];
            break;
        case 8:
            self.myPassword.enabled = NO;
            self.autoTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handlerTimer:) userInfo:nil repeats:YES];
            [self showAlertWhenErrorSyntaxMoreTimes:5 times:@"30"];
            break;
        default:
            break;
    }
}

// Tính toán timer
-(void)handlerTimer:(id)sender {
    self.time += 1;
    if (self.countSyntax == 3) {
        if (self.time == 10) {
            self.myPassword.enabled = YES;
            [self.autoTimer invalidate];
            self.autoTimer = nil;
            self.time = 0;
        }
    } else if (self.countSyntax == 8) {
        if (self.time == 900) {
            self.myPassword.enabled = YES;
            [self.autoTimer invalidate];
            self.autoTimer = nil;
            self.time = 0;
        }
    }
}

// Hiển thị alert thông báo số lần nhập sai và thời gian chờ
-(void)showAlertWhenErrorSyntaxMoreTimes:(int)count times:(NSString *)times{
    NSString *message = [NSString stringWithFormat:@"Nhập sai quá %d lần. Vui lòng nhập lại sau %@ phút", count, times];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Thông báo" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // Do something
    }];
    [alert addAction:cancelButton];
    [self presentViewController:alert animated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.tag == 1) {
        [self.myPassword becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
