//
//  BGHandView.m
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2016-01-25.
//  Copyright © 2016 Benjamin Wishart. All rights reserved.
//

#import "BGHandView.h"
#import "SlotViewCollectionView.h"

@interface BGHandView ()
{
    SlotViewCollectionView *slotViewCollectionView;
    CGPoint originalCenter;
    CardView *selectedCardView;
}

@end

@implementation BGHandView
@synthesize cardViewPanGestureRecognizer;

- (void)initialize {
    cardViews = [[NSMutableArray alloc] init];
    
    cardViewPanGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                           action:@selector(cardIsDraggingWithPanGesture:)];
    [cardViewPanGestureRecognizer setDelegate:self];
    [self addGestureRecognizer:cardViewPanGestureRecognizer];
}

- (void)didMoveToSuperview {
    slotViewCollectionView = (SlotViewCollectionView *)self.superview;
    
    if (!slotViewCollectionView) {
        [NSException raise:@"Invalid parent view" format:@"Hand view must be a child of a SlotViewCollectionView"];
    }
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
    
    [currentSlotView setHighlighted:NO];
    
    currentSlotView = [slotViewCollectionView slotViewAtPoint:draggingCardView.frame.origin];
    
    [currentSlotView setHighlighted:YES];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        isDragging = NO;
        if (!currentSlotView) {//TODO this also needs to worry about if moving a card to this slotView is legal
            [UIView animateWithDuration:SNAP_BACK_ANIMATION_DURATION animations:^{
                draggingCardView.center = originalCenter;
            } completion:^(BOOL finished) {
                [selectedCardView setHidden:NO];
                [draggingCardView removeFromSuperview];
            }];
        }
    }
}

- (void)viewDidLongPress:(UILongPressGestureRecognizer*)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *selectedView = [self hitTest:[gestureRecognizer locationInView:self] withEvent:nil];
        
        if ([selectedView isKindOfClass:[CardView class]]) {
            selectedCardView = (CardView *)selectedView;
            
            CGPoint cardViewOriginInHandView = [selectedCardView convertPoint:selectedCardView.frame.origin
                                                                       toView:self.superview];
            
            cardViewOriginInHandView.x -= selectedCardView.frame.origin.x;
            cardViewOriginInHandView.y -= selectedCardView.frame.origin.y;
            
            [selectedCardView setHidden:YES];
            
            draggingCardView = [[CardView alloc] initWithFrame:CGRectMake(cardViewOriginInHandView.x,
                                                                          cardViewOriginInHandView.y,
                                                                          selectedCardView.frame.size.width,
                                                                          selectedCardView.frame.size.height)];
            
            isDragging = YES;
            
            originalCenter = [self convertPoint:selectedCardView.center toView:slotViewCollectionView];
            
            [draggingCardView.panGestureRecognizer setEnabled:NO];
            
    #warning take this out
            [draggingCardView.layer setBackgroundColor:[UIColor blueColor].CGColor];
            
            [self.superview addSubview:draggingCardView];
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
