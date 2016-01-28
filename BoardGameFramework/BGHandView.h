//
//  BGHandView.h
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2015-10-09.
//  Copyright © 2015 Benjamin Wishart. All rights reserved.
//

/*
 pangesture dragging of cardviews should happen inside of the handview rather than the cardviews themselves
 makes things easier/less memory
 
 a hand view should always be attached to or contained in a slotviewcollectionview
 */

#import <UIKit/UIKit.h>
#import "CardView.h"

#define MIN_LONG_PRESS_DURATION         1.0

@interface BGHandView : UIView <UIGestureRecognizerDelegate>
{
    CardView *draggingCardView;
    NSMutableArray *cardViews;
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

@end
