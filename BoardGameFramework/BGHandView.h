//
//  BGHandView.h
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2015-10-09.
//  Copyright © 2015 Benjamin Wishart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView.h"
#import "SlotView.h"
#import "SlotViewCollectionView.h"
#import "BGView.h"

#define MIN_LONG_PRESS_DURATION         0.25
#define SNAP_BACK_ANIMATION_DURATION    0.25

@interface BGHandView : BGView <UIGestureRecognizerDelegate>
{
    SlotView *currentSlotView;
    CardView *draggingCardView;
    NSMutableArray *cardViews;
    BOOL isDragging;
    CGPoint originalCenter;
    CardView *selectedCardView;
    SlotViewCollectionView *slotViewCollectionView;
}

@property (nonatomic) CGSize cardSize;
@property (nonatomic) UIPanGestureRecognizer *cardViewPanGestureRecognizer;

- (void)initialize;

- (void)addCardView:(CardView *)cardView;

- (void)removeCardViewAtIndex:(int)index;

- (void)removeCardView:(CardView *)cardView;

- (void)refreshHand;

- (void)cardIsDraggingWithPanGesture:(UIPanGestureRecognizer *)gestureRecognizer;

- (void)viewDidLongPress:(UILongPressGestureRecognizer*)gestureRecognizer;

- (void)setOriginalCenter;

@end
