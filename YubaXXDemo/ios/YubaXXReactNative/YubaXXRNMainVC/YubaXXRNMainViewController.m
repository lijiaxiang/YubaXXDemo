//
//  YubaXXRNMainViewController.m
//  YubaXXDemo
//
//  Created by XXViper on 17/9/20.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "YubaXXRNMainViewController.h"

#import "RCTBundleURLProvider.h"
#import "RCTRootView.h"
#import "DiffMatchPatch.h"

@interface YubaXXRNMainViewController ()<RCTBridgeDelegate>

@end

@implementation YubaXXRNMainViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setUpNavi];
  self.moduleName = @"YubaXXDemo";
  
  
  [self setUpReactRootView];
  // Do any additional setup after loading the view.
}
- (void)setUpNavi{
  self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(popToSuper)];
}
- (void)popToSuper{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
#pragma mark - ReactNative Demo重要部分
- (void)setUpReactRootView{
  
  RCTBridge *bridge = [[RCTBridge alloc]initWithDelegate:self launchOptions:nil];
  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge moduleName:self.moduleName initialProperties:nil];
  self.view = rootView;
}
- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
  NSString *url = [self getNewBundle];
  /** 读取本地rn服务代码 */
//  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index.ios" fallbackResource:nil];
  /** 读取本地rn包代码 */
  return [[NSBundle mainBundle] URLForResource:@"ios" withExtension:@"jsbundle"];
  /** 合并并读取本地沙盒合并后的rn包 */
//  return [NSURL URLWithString:[self getNewBundle]];
}


- (NSString *)getNewBundle
{
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *docDir = [paths objectAtIndex:0];
  NSString *filePath = [NSString stringWithFormat:@"%@/%@.jsbundle",docDir,self.bridgeName];

  BOOL exits = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
  //PS 本地已有  直接返回/甚至做一些逻辑处理
  if (exits) {
    NSLog(@"已找到本地有，所以不再合成，直接返回");
    return filePath;
  }
  
  NSString *commonBundlePath = [[NSBundle mainBundle] pathForResource:@"commont" ofType:@"jsbundle"];
  NSString *commonBundleJSCode = [[NSString alloc] initWithContentsOfFile:commonBundlePath encoding:NSUTF8StringEncoding error:nil];
  NSLog(@"commonBundleJSCode(基础包大小)___%tu",commonBundleJSCode.length);
  
  NSString *patch1Path = [[NSBundle mainBundle] pathForResource:self.bridgeName ofType:@"patch"];
  NSString *patch1JSCode = [[NSString alloc] initWithContentsOfFile:patch1Path encoding:NSUTF8StringEncoding error:nil];
  NSLog(@"patch1JSCode(补丁包大小)___%tu",patch1JSCode.length);
  
  NSError *err;
  NSArray *convertedPatches = patch_parsePatchesFromText(patch1JSCode, &err);
  
  NSString *resultJSCode = patch_applyPatchesToText(convertedPatches, commonBundleJSCode, 0);
  NSLog(@"resultJSCode(合成后大小)__%tu",resultJSCode.length);
  
  NSLog(@"XX_异步执行");
  NSLog(@"XX_异步开始");
  BOOL finishWrite = [resultJSCode writeToFile:filePath atomically:NO encoding:NSUTF8StringEncoding error:nil];
  if (finishWrite) {
    NSLog(@"XX_完成写入");
  }
  return filePath;
}
@end
