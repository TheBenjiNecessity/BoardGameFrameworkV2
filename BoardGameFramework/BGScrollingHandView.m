//
//  BGScrollingHandView.m
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2015-10-13.
//  Copyright © 2015 Benjamin Wishart. All rights reserved.
//

#import "BGScrollingHandView.h"

@implementation BGScrollingHandView
@synthesize cardViews;

- (id)initWithFrame:(CGRect)frame pagingEnabled:(BOOL)pagingEnabled
{
    if (self = [super initWithFrame:frame])
    {
        self.pagingEnabled = pagingEnabled;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.canCancelContentTouches = NO;
        cardViews = [[NSMutableArray alloc] initWithCapacity:self.subviews.count];
        
        [self addCardView:[[CardView alloc] init]];
        
        
        [self refreshHand];
    }
    
    return self;
}

- (void)addCardView:(CardView *)cardView {
    cardView.willDragAfterLongPress = YES;
    [cardView.panGestureRecognizer setDelegate:self];
    [cardView.longPressRecognizer setDelegate:self];
    [self.panGestureRecognizer requireGestureRecognizerToFail:cardView.panGestureRecognizer];
    if (cardView.longPressRecognizer) {
        [self.panGestureRecognizer requireGestureRecognizerToFail:cardView.longPressRecognizer];
    }
    [cardViews addObject:cardView];
    
}

- (void)removeCardViewAtIndex:(int)index {
    [cardViews removeObjectAtIndex:index];
}

- (void)removeCardView:(CardView *)cardView {
    [cardViews removeObject:cardView];
}

- (void)refreshHand {
    CGFloat cardWidth = 90.0;
    CGFloat cardHeight = 140.0;
    CGFloat cardMargin = 10.0;
    NSUInteger numberOfCards = [cardViews count];
    
    self.contentSize = CGSizeMake((cardWidth + cardMargin) * numberOfCards + cardMargin, self.frame.size.height);
    
    [cardViews enumerateObjectsUsingBlock:^(CardView * _Nonnull cardView, NSUInteger i, BOOL * _Nonnull stop) {
        cardView.frame = CGRectMake(cardMargin + (i * cardMargin) + (i * cardWidth), (self.frame.size.height / 2) - (cardHeight / 2), cardWidth, cardHeight);
        cardView.backgroundColor = [UIColor whiteColor];
        [self addSubview:cardView];
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
