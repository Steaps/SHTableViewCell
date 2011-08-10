//
//  TableViewTestsAppDelegate.h
//  TableViewTests
//
//  Created by Stephen Heaps on 11-08-07.
//  Copyright 2011 Steaps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewTestsAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;

@end

