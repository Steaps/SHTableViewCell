//
//  SHCellContentView.h
//  TableViewTests
//
//  Created by Stephen Heaps on 11-08-10.
//  Copyright 2011 Steaps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHCellContentView : UIView {
	CGRect frontViewRect;
	CGRect backViewRect;
	CGFloat edgePadding;
}

@property(nonatomic, retain) NSString * cellTitle;

- (void)setCellTitle:(NSString *)string;
- (void)setEdgePadding:(CGFloat)edgePaddingFloat;
- (void)setFrontView:(CGRect)_frontViewRect backViewRect:(CGRect)_backViewRect;

@end
