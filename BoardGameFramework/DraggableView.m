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
@synthesize panGestureRecognizer;
@synthesize expandsOnTouch;
@synthesize willDrag;

- (void)initialize {
    panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                   action:@selector(cardDraggedWithRecognizer:)];
    [self addGestureRecognizer:panGestureRecognizer];
}

- (void)setIsHighlighted:(BOOL)isHighlighted {
    _isHighlighted = isHighlighted;
    
    if (_isHighlighted) {
        [self.layer setBackgroundColor:[UIColor blueColor].CGColor];
    } else {
        //TODO this should be the previous style which is unknown
        [self.layer setBackgroundColor:[UIColor whiteColor].CGColor];
    }
}

- (void)cardDraggedWithRecognizer: (UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        if ([self.delegate respondsToSelector:@selector(view:didStartDraggingWithGestureRecognizer:)]) {
            [self.delegate view:self didStartDraggingWithGestureRecognizer:sender];
        }
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
        && CGRectContainsPoint(self.superview.frame, CGPointMake(newCenterPoint.x - halfViewWidth, newCenterPoint.y)))
        || !staysWithinSuperView) {
        sender.view.center = newCenterPoint;
        [sender setTranslation:CGPointZero inView:self.superview];
    }

    
    if ([self.delegate respondsToSelector:@selector(view:isDraggingWithGestureRecognizer:)]) {
        [self.delegate view:self isDraggingWithGestureRecognizer:sender];
    }

    if (sender.state == UIGestureRecognizerStateEnded) {
        if ([self.delegate respondsToSelector:@selector(view:didEndDraggingWithGestureRecognizer:)]) {
            [self.delegate view:self didEndDraggingWithGestureRecognizer:sender];
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    NSLog(@"drag yes");
    return YES;
}

@end
