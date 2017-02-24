//
//  AppDelegate.h
//  HLBaiDuMap
//
//  Created by 杨海龙 on 2017/2/24.
//  Copyright © 2017年 杨海龙 趣高科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <BaiduMapAPI_Base/BMKMapManager.h>
#import "ViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (nonatomic, strong) BMKMapManager *mapManager;

@property (nonatomic, strong)ViewController *vc;

@property (nonatomic, strong)UINavigationController *nav;

- (void)saveContext;


@end

