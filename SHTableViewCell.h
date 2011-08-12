//
//  SHTableViewCell.h
//
//  Created by Stephen Heaps on 11-08-10.
//  Copyright 2011 Steaps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHCellContentView.h"

@interface SHTableViewCell : UITableViewCell {
	SHCellContentView * cellContentView;
	BOOL sliderCell;
	
	CGFloat edgePadding;
	CGFloat editingPadding;
	CGRect frontViewRect;
	CGRect backViewRect;
	BOOL animating;
	BOOL swiped;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier sliderCell:(BOOL)_sliderCell;

- (void)setCellTitle:(NSString *)string;
- (void)setEdgePadding:(CGFloat)edgePaddingFloat;
- (void)setEditngPadding:(CGFloat)editingPaddingFloat;

- (void)scrollToPosition:(CGPoint)_position animated:(BOOL)_animated;
- (void)animationDidStop:(id)sender;

@end
