//
//  SHTableViewCell.m
//
//  Created by Stephen Heaps on 11-08-10.
//  Copyright 2011 Steaps. All rights reserved.
//

#import "SHTableViewCell.h"

#define kEdgePadding 10
#define kEditingPadding 35
#define kDefaultAnimationSpeed 0.2

@implementation SHTableViewCell

@synthesize cellCopyString;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		edgePadding = kEdgePadding;
        editingPadding = kEditingPadding;
		animating = FALSE;
		
		copyable = FALSE;
		cellCopyString = nil;
		
		UILongPressGestureRecognizer * longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showCopyMenu)];
		[self addGestureRecognizer:longPressRecognizer];
		[longPressRecognizer release];
		
		if(sliderCell) {
			swiped = FALSE;
			
			cellContentView = [[SHCellContentView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width * 2, self.frame.size.height)];
			[cellContentView setEdgePadding:edgePadding];
			[self addSubview:cellContentView];
			
			frontViewRect = CGRectMake(0, 0, (cellContentView.frame.size.width / 2), cellContentView.frame.size.height);
			backViewRect = CGRectMake((cellContentView.frame.size.width / 2), 0, (cellContentView.frame.size.width / 2), cellContentView.frame.size.height);
			[cellContentView setFrontView:frontViewRect backViewRect:backViewRect];
			
			UISwipeGestureRecognizer * swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipeDetected:)];
			swipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
			[self addGestureRecognizer:swipeRecognizer];
			[swipeRecognizer release];
			swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeDetected:)];
			swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
			[self addGestureRecognizer:swipeRecognizer];
			[swipeRecognizer release];
			
			[cellContentView addBadge];
		} else {
			cellContentView = [[SHCellContentView alloc] initWithFrame:self.frame];
			[cellContentView setEdgePadding:edgePadding];
			[self addSubview:cellContentView];
			
			frontViewRect = cellContentView.frame;
			[cellContentView setFrontView:frontViewRect backViewRect:backViewRect];
		}
	}
	return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier sliderCell:(BOOL)_sliderCell {
	sliderCell = _sliderCell;
	self = [self initWithStyle:style reuseIdentifier:reuseIdentifier];
	return self;
}

static BOOL _fingerDown = FALSE;

- (void)showCopyMenu {
	NSLog(@"COPY");
	_fingerDown = !_fingerDown;
	
	if(_fingerDown) {
		NSLog(@"SHOW MENU: _fingerDown = TRUE");
		UIMenuController * menu = [UIMenuController sharedMenuController];
		[menu setTargetRect:self.bounds inView:self];
		[menu setMenuVisible:TRUE];
		
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	[super setEditing:editing animated:animated];
	if(self.editing && !swiped)
		// move content to editing padding
		[self scrollToPosition:CGPointMake(cellContentView.frame.origin.x - editingPadding, cellContentView.frame.origin.y) animated:YES];
	else if(self.editing && swiped) {
		// return the swipe and move the content to editing padding
		[self scrollToPosition:CGPointMake(self.frame.origin.x - editingPadding, self.frame.origin.y) animated:YES];
		swiped = FALSE;
	}
	else
		// return the content from editing
		[self scrollToPosition:CGPointMake(self.frame.origin.x, self.frame.origin.y) animated:YES];
}

- (void)setCellTitle:(NSString *)string {
	[cellContentView setCellTitle:[string copy]];
}

- (void)setEdgePadding:(CGFloat)edgePaddingFloat {
	[cellContentView setEdgePadding:edgePaddingFloat];
}

- (void)setEditngPadding:(CGFloat)editingPaddingFloat {
	editingPadding = editingPaddingFloat;
}

- (void)rightSwipeDetected:(UIGestureRecognizer *)sender {
	if(!animating && sliderCell) {
		if(swiped) {
			animating = TRUE;
			[self scrollToPosition:frontViewRect.origin animated:YES];
		}
	}
}

- (void)leftSwipeDetected:(UIGestureRecognizer *)sender {
	if(!animating && sliderCell) {
		animating = TRUE;
		if(!swiped) {
			[self scrollToPosition:backViewRect.origin animated:YES];
			swiped = TRUE;
		} else if(swiped) {
			[self scrollToPosition:frontViewRect.origin animated:YES];
			swiped = FALSE;
		}
	}
}

- (void)scrollToPosition:(CGPoint)_position animated:(BOOL)_animated {
	if(_animated) {
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationCurve:UIViewAnimationCurveLinear];
		[UIView setAnimationDuration:kDefaultAnimationSpeed];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(animationDidStop:)];
	}
	
	if(swiped)
		cellContentView.frame = CGRectMake(-_position.x, cellContentView.frame.origin.y, cellContentView.frame.size.width, cellContentView.frame.size.height);
	else 
		cellContentView.frame = CGRectMake(-_position.x, cellContentView.frame.origin.y, cellContentView.frame.size.width, cellContentView.frame.size.height);
	
	if(_animated)
		animating = TRUE;
	[UIView commitAnimations];
}

- (void)animationDidStop:(id)sender {
	animating = FALSE;
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
	
	CGContextRef c = UIGraphicsGetCurrentContext();
	
	/* Could just use self.backgroundColour, but if there's more custom drawing for the background it needs done in drawRect: */
	CGContextSetGrayFillColor(c, 1.0, 1.0);
	CGContextFillRect(c, frontViewRect);
}

#pragma mark ---
#pragma mark Copy Methods

- (void)setCopyable:(BOOL)_copyable {
	copyable = _copyable;
	
	UILongPressGestureRecognizer * longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(copyPressRecognizedWithRecognizer:)];
	[self addGestureRecognizer:longPressRecognizer];
	[longPressRecognizer release];
}

- (void)copyPressRecognizedWithRecognizer:(UILongPressGestureRecognizer *)_longPressRecognizer {
	if([_longPressRecognizer state] == UIGestureRecognizerStateBegan && [self canBecomeFirstResponder]) {
		[self becomeFirstResponder];
		
		UIMenuController * menu = [UIMenuController sharedMenuController];
		[menu setTargetRect:CGRectMake(self.bounds.origin.x, self.bounds.origin.y - 10, self.bounds.size.width, self.bounds.size.height) inView:self];
		[menu setMenuVisible:TRUE animated:TRUE];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self isFirstResponder]) {
        UIMenuController * menu = [UIMenuController sharedMenuController];
		[menu setMenuVisible:FALSE animated:TRUE];
		[menu update];
		
		[self resignFirstResponder];
	}
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(copy:)) {
        return YES;
    }
    return [super canPerformAction:action withSender:sender];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)copy:(id)sender {
	NSLog(@"COPY");
	if(cellCopyString != nil) {
		NSLog(@"cell content string not nil");
		[[UIPasteboard generalPasteboard] setString:cellCopyString];
	}
}	
	

- (void)dealloc {
    [super dealloc];
}

@end
