//
//  SHBadgeView.m
//
//  Created by Stephen Heaps on 11-08-10.
//  Copyright 2011 Steaps. All rights reserved.
//

#import "SHBadgeView.h"

@implementation SHBadgeView

@synthesize badgeString;

static int kPadding = 10;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		badgeString = [[NSString stringWithFormat:@"0"] retain];
		badgeColor = [[UIColor colorWithRed:0.529 green:0.596 blue:0.741 alpha:1.0f] retain];
		badgeTextColor = [UIColor whiteColor];
		selected = FALSE;
    }
    return self;
}

- (void)setBadgeString:(NSString *)_string {
	badgeString = [_string copy];
	
	CGSize size = [badgeString sizeWithFont:[UIFont boldSystemFontOfSize:14.0f]];
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width + (kPadding * 2), 18); // height must be 18, and width is adjusted based on text + sidepadding
	self.backgroundColor = [UIColor clearColor];
	
	[self setNeedsDisplay];
}

- (void)setSelected:(BOOL)_selected {
	selected = !selected;
	
	if(selected) {
		badgeColor = [UIColor whiteColor];
		badgeTextColor = [UIColor colorWithRed:0.529 green:0.596 blue:0.741 alpha:1.0f];
	} else {
		badgeColor = [UIColor colorWithRed:0.529 green:0.596 blue:0.741 alpha:1.0f];
		badgeTextColor = [UIColor whiteColor];
	}
	
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
 	/* Draw Badge */
	CGContextRef context = UIGraphicsGetCurrentContext();
	[badgeColor set];
	
	int radius = self.frame.size.height / 2;
	
	CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + radius);
	CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height - radius);
	CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + rect.size.height - radius, radius, M_PI, M_PI / 2, 1);
	CGContextAddLineToPoint(context, rect.origin.x + rect.size.width - radius, rect.origin.y + rect.size.height);
	CGContextAddArc(context, rect.origin.x + rect.size.width - radius, rect.origin.y + rect.size.height - radius, radius, M_PI / 2, 0.0f, 1);
	CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + radius);
	CGContextAddArc(context, rect.origin.x + rect.size.width - radius, rect.origin.y + radius, radius, 0.0f, -M_PI / 2, 1);
	CGContextAddLineToPoint(context, rect.origin.x + radius, rect.origin.y);
	CGContextAddArc(context, rect.origin.x + radius, rect.origin.y + radius, radius, -M_PI / 2, M_PI, 1);
	
	CGContextFillPath(context);
	
	if(badgeString != nil) {
		CGContextSetShadowWithColor(context, CGSizeMake(0, -1), 0, [UIColor darkGrayColor].CGColor);
		[badgeTextColor set];
		[badgeString drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) withFont:[UIFont boldSystemFontOfSize:14.0f] lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentCenter];
	}
}

- (void)dealloc {
	[badgeColor release];
	[badgeString release];
	[badgeTextColor release];
	
    [super dealloc];
}


@end
