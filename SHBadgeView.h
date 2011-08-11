//
//  SHBadgeView.h
//
//  Created by Stephen Heaps on 11-08-10.
//  Copyright 2011 Steaps. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SHBadgeView : UIView {
	UIColor * badgeColor;
	UIColor * badgeTextColor;
	BOOL selected;
}

@property (nonatomic, retain) NSString * badgeString;

- (void)setSelected:(BOOL)_selected;

@end
