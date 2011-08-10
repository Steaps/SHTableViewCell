//
//  SHCell.m
//  TableViewTests
//
//  Created by Stephen Heaps on 11-08-10.
//  Copyright 2011 Steaps. All rights reserved.
//

#import "SHTableViewCell.h"

@implementation SHTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		edgePadding = 10;
        editingPadding = 45;
		sliderOverlay = 20;
		animating = FALSE;
		swiped = FALSE;
		
		cellContentView = [[SHCellContentView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width * 2, self.frame.size.height)];
		[cellContentView setEdgePadding:edgePadding];
		[self addSubview:cellContentView];
		
		frontViewRect = CGRectMake(0, 0, (cellContentView.frame.size.width / 2), cellContentView.frame.size.height);
		backViewRect = CGRectMake((cellContentView.frame.size.width / 2), 0, (cellContentView.frame.size.width / 2), cellContentView.frame.size.height);
		[cellContentView setFrontView:frontViewRect backViewRect:backViewRect];
		
//		NSLog(@"Frontview x origin: %f", frontViewRect.origin.x);
//		NSLog(@"Frontview y origin: %f", frontViewRect.origin.y);
//		NSLog(@"Frontview width: %f", frontViewRect.size.width);
//		NSLog(@"Frontview height: %f", frontViewRect.size.height);
//		NSLog(@"Backview x origin: %f", backViewRect.origin.x);
//		NSLog(@"Backview y origin: %f", backViewRect.origin.y);
//		NSLog(@"Backview width: %f", backViewRect.size.width);
//		NSLog(@"Backview height: %f", backViewRect.size.height);
		
		UISwipeGestureRecognizer * swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeDetected:)];
		swipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
		[self addGestureRecognizer:swipeRecognizer];
		[swipeRecognizer release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setCellTitle:(NSString *)string {
	//cellTitle = [string copy];
	[cellContentView setCellTitle:[string copy]];
}

- (void)setEdgePadding:(CGFloat)edgePaddingFloat {
	//edgePadding = edgePaddingFloat;
	[cellContentView setEdgePadding:edgePaddingFloat];
}

- (void)setEditngPadding:(CGFloat)editingPaddingFloat {
	editingPadding = editingPaddingFloat;
}

- (void)setSliderOverlay:(CGFloat)sliderOverlayFloat {
	sliderOverlay = sliderOverlayFloat;
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
}

- (void)leftSwipeDetected:(UIGestureRecognizer *)sender {
	if(!animating) {
		animating = TRUE;
		if(!swiped) {
			[self scrollToPosition:backViewRect.origin animated:YES];
			swiped = TRUE;
		} else if(swiped) {
			
		}
	}
}

- (void)scrollToPosition:(CGPoint)_position animated:(BOOL)_animated {
	if(_animated) {
		animating = TRUE;
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		[UIView setAnimationDuration:0.2];
		[UIView setAnimationDidStopSelector:@selector(animationDidStop:)];
	}
	
	cellContentView.frame = CGRectMake(-_position.x, cellContentView.frame.origin.y, cellContentView.frame.size.width, cellContentView.frame.size.height);
	
	[UIView commitAnimations];
}

- (void)animationDidStop:(id)sender {
	animating = FALSE;
}

- (void)dealloc {
    [super dealloc];
}

@end
