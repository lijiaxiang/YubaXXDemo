//
//  YubaXXMainViewController.m
//  YubaXXDemo
//
//  Created by XXViper on 17/9/20.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "YubaXXMainViewController.h"
#import "YubaXXRNMainViewController.h"

@interface YubaXXMainViewController ()

@end

@implementation YubaXXMainViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor yellowColor];
  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
- (IBAction)oneClick:(id)sender {
  NSLog(@"one click");
  YubaXXRNMainViewController *rnMainVC = [[YubaXXRNMainViewController alloc] init];
  rnMainVC.bridgeName = @"one";
  UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:rnMainVC];
  [self presentViewController:navi animated:YES completion:nil];
}
- (IBAction)twoClick:(id)sender {
  NSLog(@"two click");
  YubaXXRNMainViewController *rnMainVC = [[YubaXXRNMainViewController alloc] init];
  rnMainVC.bridgeName = @"two";
  UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:rnMainVC];
  [self presentViewController:navi animated:YES completion:nil];
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
