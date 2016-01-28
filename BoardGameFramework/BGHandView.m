//
//  BGHandView.m
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2016-01-25.
//  Copyright © 2016 Benjamin Wishart. All rights reserved.
//

#import "BGHandView.h"

@implementation BGHandView
@synthesize cardViewPanGestureRecognizer;

- (void)initialize {
    cardViews = [[NSMutableArray alloc] init];
    
    cardViewPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                           action:@selector(cardIsDraggingWithPanGesture:)];
    [cardViewPanGestureRecognizer setDelegate:self];
    [self addGestureRecognizer:cardViewPanGestureRecognizer];
}

- (void)addCardView:(CardView *)cardView {
    [cardViews addObject:cardView];
}

- (void)removeCardViewAtIndex:(int)index {
    [cardViews removeObjectAtIndex:index];
}

- (void)removeCardView:(CardView *)cardView {
    [cardViews removeObject:cardView];
}

- (void)refreshHand{}

- (void)cardIsDraggingWithPanGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translationPoint = [gestureRecognizer translationInView:self];
    CGFloat x = draggingCardView.center.x + translationPoint.x;
    CGFloat y = draggingCardView.center.y + translationPoint.y;
    CGPoint newCenterPoint = CGPointMake(x, y);
    
    [draggingCardView setCenter:newCenterPoint];
    [gestureRecognizer setTranslation:CGPointZero inView:self];
}

- (void)viewDidLongPress:(UILongPressGestureRecognizer*)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        CardView *cardView = (CardView *)[self hitTest:[gestureRecognizer locationInView:self] withEvent:nil];
        
        CGPoint cardViewOriginInHandView = [cardView convertPoint:cardView.frame.origin toView:self.superview];
        
        cardViewOriginInHandView.x -= cardView.frame.origin.x;
        cardViewOriginInHandView.y -= cardView.frame.origin.y;
        
        [cardView removeFromSuperview];
        [cardView setHidden:YES];
        
        draggingCardView = [[CardView alloc] initWithFrame:CGRectMake(cardViewOriginInHandView.x,
                                                                      cardViewOriginInHandView.y,
                                                                      cardView.frame.size.width,
                                                                      cardView.frame.size.height)];
        NSLog(@"%@", NSStringFromCGRect(draggingCardView.frame));
        
        [draggingCardView.panGestureRecognizer setEnabled:NO];
        
#warning take this out
        [draggingCardView.layer setBackgroundColor:[UIColor blueColor].CGColor];
        
        [self.superview addSubview:draggingCardView];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
