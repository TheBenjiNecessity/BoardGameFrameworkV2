 //
//  DraggableView.m
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2015-02-28.
//  Copyright (c) 2015 Benjamin Wishart. All rights reserved.
//

#import "DraggableView.h"

@implementation DraggableView
@synthesize staysWithinSuperView;
@synthesize lockX, lockY;
@synthesize willLongPress, willDrag;
@synthesize panGestureRecognizer;
@synthesize longPressRecognizer;
@synthesize expandsOnTouch;

-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }

   return self;
}

-(id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    
    return self;
}

- (void)initialize {
    self.userInteractionEnabled = YES;
    panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(cardIsBeingDraggedWithPanGestureRecognizer:)];
    panGestureRecognizer.cancelsTouchesInView = NO;
    [self addGestureRecognizer:panGestureRecognizer];
    
    longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(cardIsBeingLongPressedWithLongPressGestureRecognizer:)];
    [longPressRecognizer setMinimumPressDuration:1.0];
    longPressRecognizer.cancelsTouchesInView = NO;
    longPressRecognizer.enabled = YES;
    [self addGestureRecognizer:longPressRecognizer];
}

-(void)cardIsBeingLongPressedWithLongPressGestureRecognizer: (UILongPressGestureRecognizer *)sender {
    longPressRecognizer.enabled = NO;
    willDrag = YES;
}

-(void)cardIsBeingDraggedWithPanGestureRecognizer: (UIPanGestureRecognizer *)sender {
    if (willDrag) {
        if (sender.state == UIGestureRecognizerStateBegan) {
          [self.delegate view:self didStartDraggingWithGestureRecognizer:sender];
        }
       
        CGPoint translationPoint = [sender translationInView:self.superview];
        CGFloat x = lockX ? sender.view.center.x : sender.view.center.x + translationPoint.x;
        CGFloat y = lockY ? sender.view.center.y : sender.view.center.y + translationPoint.y;
        CGPoint newCenterPoint = CGPointMake(x, y);
        CGFloat halfViewWidth = self.frame.size.width / 2;
        CGFloat halfViewHeight = self.frame.size.height / 2;

        if ((staysWithinSuperView
            && CGRectContainsPoint(self.superview.frame, CGPointMake(newCenterPoint.x, newCenterPoint.y + halfViewHeight))
            && CGRectContainsPoint(self.superview.frame, CGPointMake(newCenterPoint.x, newCenterPoint.y - halfViewHeight))
            && CGRectContainsPoint(self.superview.frame, CGPointMake(newCenterPoint.x + halfViewWidth, newCenterPoint.y))
            && CGRectContainsPoint(self.superview.frame, CGPointMake(newCenterPoint.x - halfViewWidth, newCenterPoint.y))) || !staysWithinSuperView) {
            sender.view.center = newCenterPoint;
            [sender setTranslation:CGPointZero inView:self.superview];
        }

        
        if ([self.delegate respondsToSelector:@selector(view:isDraggingWithGestureRecognizer:)]) {
            [self.delegate view:self isDraggingWithGestureRecognizer:sender];
        }

        if (sender.state == UIGestureRecognizerStateEnded) {
            [self.delegate view:self didEndDraggingWithGestureRecognizer:sender];
        }
    }
}

@end
