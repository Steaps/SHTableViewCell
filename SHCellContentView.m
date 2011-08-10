//
//  SHCellContentView.m
//  TableViewTests
//
//  Created by Stephen Heaps on 11-08-10.
//  Copyright 2011 Steaps. All rights reserved.
//

#import "SHCellContentView.h"

@implementation SHCellContentView

@synthesize cellTitle;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)setCellTitle:(NSString *)string {
	cellTitle = [string copy];
}

- (void)setEdgePadding:(CGFloat)edgePaddingFloat {
	edgePadding = edgePaddingFloat;
	[self setNeedsDisplay];
}

- (void)setFrontView:(CGRect)_frontViewRect backViewRect:(CGRect)_backViewRect {
	frontViewRect = _frontViewRect;
	backViewRect = _backViewRect;
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	
	CGContextRef c = UIGraphicsGetCurrentContext();
	
	/* Draw Background View (backViewRect)  */
	[[UIImage imageNamed:@"mesh_pattern.png"] drawAsPatternInRect:backViewRect];
	
	/* Draw Front View (frontViewRect) */
	CGContextSetGrayFillColor(c, 1.0, 1.0);
	CGContextFillRect(c, frontViewRect);
	
	/* Draw Text */
	UIFont * cellFont = [UIFont boldSystemFontOfSize:18.0];
	int cellHeight = self.frame.size.height;
	int cellWidth = self.frame.size.width;
	CGSize cellTitleSize = [cellTitle sizeWithFont:cellFont constrainedToSize:CGSizeMake(self.frame.size.width, self.frame.size.height)];
	
	[[UIColor blackColor] set];
	[cellTitle drawInRect:CGRectMake(frontViewRect.origin.x + edgePadding, frontViewRect.origin.y + (cellHeight / 2) - (cellTitleSize.height / 2), cellWidth - 20, cellHeight - 5) withFont:cellFont lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentLeft];	
	
}

- (void)dealloc {
    [super dealloc];
}


@end
