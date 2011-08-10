//
//  SHCell.h
//  TableViewTests
//
//  Created by Stephen Heaps on 11-08-10.
//  Copyright 2011 Steaps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHCellContentView.h"

@interface SHTableViewCell : UITableViewCell {
	SHCellContentView * cellContentView;
	
	CGFloat sliderOverlay;
	CGFloat editingPadding;
	CGFloat edgePadding;
	CGRect frontViewRect;
	CGRect backViewRect;
	BOOL animating;
	BOOL swiped;
}

- (void)setCellTitle:(NSString *)string;
- (void)setEdgePadding:(CGFloat)edgePaddingFloat;
- (void)setEditngPadding:(CGFloat)editingPaddingFloat;
- (void)setSliderOverlay:(CGFloat)sliderOverlayFloat;

- (void)scrollToPosition:(CGPoint)_position animated:(BOOL)_animated;
- (void)animationDidStop:(id)sender;

@end
