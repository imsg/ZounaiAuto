//
//  ZAAppDelegate.m
//  ZounaiAuto
//
//  Created by Zhao Kun on 13-11-26.
//  Copyright (c) 2013年 Good Technology. All rights reserved.
//

#import "ZAAppDelegate.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "ZADrawerViewController.h"
#import "ZAViewController.h"
#import "CoreData+MagicalRecord.h"
#import "ZAPersistenceCenter.h"

@interface ZAAppDelegate()

@property (nonatomic, strong) MMDrawerController * drawerController;

@end

@implementation ZAAppDelegate
- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIStoryboard* tmmStoryBoard = [UIStoryboard storyboardWithName:@"drawer" bundle:nil];
    ZADrawerViewController *leftSideDrawerViewController = [tmmStoryBoard instantiateViewControllerWithIdentifier:@"leftDrawer"];
//    UIViewController * leftSideDrawerViewController = [[ZADrawerViewController alloc] init];
    
    UIViewController * centerViewController = [[ZAViewController alloc] init];
    
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:centerViewController];
    [navigationController setRestorationIdentifier:@"MMExampleCenterNavigationControllerRestorationKey"];
    
    self.drawerController = [[MMDrawerController alloc]
                             initWithCenterViewController:navigationController
                             leftDrawerViewController:leftSideDrawerViewController
                             rightDrawerViewController:nil];
    [self.drawerController setShowsShadow:NO];
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    [self.drawerController setMaximumRightDrawerWidth:200.0];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModePanningNavigationBar];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [self.drawerController setDrawerVisualStateBlock:[MMDrawerVisualState swingingDoorVisualStateBlock]];
    //    [self.drawerController
    //     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
    //         MMDrawerControllerDrawerVisualStateBlock block;
    //         block = [[MMExampleDrawerVisualStateManager sharedManager]
    //                  drawerVisualStateBlockForDrawerSide:drawerSide];
    //         if(block){
    //             block(drawerController, drawerSide, percentVisible);
    //         }
    //     }];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIColor * tintColor = [UIColor colorWithRed:29.0/255.0
                                          green:173.0/255.0
                                           blue:234.0/255.0
                                          alpha:1.0];
    [self.window setTintColor:tintColor];
    [self.window setRootViewController:self.drawerController];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [MagicalRecord setDefaultModelNamed:@"ZAModel.momd"];
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"ZAModel.sqlite"];
    [[ZAPersistenceCenter sharedInstance] saveStation];
    [[ZAPersistenceCenter sharedInstance] saveSquad];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
