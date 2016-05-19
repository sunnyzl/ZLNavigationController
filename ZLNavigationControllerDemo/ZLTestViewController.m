//
//  ZLTestViewController.m
//  CustomNavigationController
//
//  Created by zhaoliang on 15/11/12.
//  Copyright © 2015年 zhao. All rights reserved.
//

#import "ZLTestViewController.h"
#import "ZLCommonConst.h"

@interface ZLTestViewController ()

@property (nonatomic, weak) UIView *nightView;

@end

@implementation ZLTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
