//
//  SHCellContentView.h
//
//  Created by Stephen Heaps on 11-08-10.
//  Copyright 2011 Steaps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHBadgeView.h"

@interface SHCellContentView : UIView {
	CGRect frontViewRect;
	CGRect backViewRect;
	CGFloat edgePadding;
	
	BOOL sliderCell;
}

@property(nonatomic, retain) NSString * cellTitle;

- (void)setCellTitle:(NSString *)string;
- (void)setEdgePadding:(CGFloat)edgePaddingFloat;
- (void)setFrontView:(CGRect)_frontViewRect backViewRect:(CGRect)_backViewRect;
- (void)setSliderCell:(BOOL)_sliderCell;

- (void)addBadge;

@end
