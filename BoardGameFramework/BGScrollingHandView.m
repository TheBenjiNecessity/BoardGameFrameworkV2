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
@synthesize cardSize, cardMargin;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.canCancelContentTouches = NO;
    cardViews = [[NSMutableArray alloc] init];
    [self setClipsToBounds:YES];
}

- (void)addCardView:(CardView *)cardView {
    [cardView.panGestureRecognizer setDelegate:self];
    [cardView.longPressRecognizer setDelegate:self];
    [self.panGestureRecognizer requireGestureRecognizerToFail:cardView.panGestureRecognizer];
    if (cardView.longPressRecognizer) {
        //[self.panGestureRecognizer requireGestureRecognizerToFail:cardView.longPressRecognizer];
        [cardView setWillDrag:NO];
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
    [self setContentSize:CGSizeMake((cardSize.width + cardMargin) * [cardViews count] + cardMargin, self.frame.size.height)];

    [cardViews enumerateObjectsUsingBlock:^(CardView * _Nonnull cardView, NSUInteger i, BOOL * _Nonnull stop) {
        cardView.frame = CGRectMake(cardMargin + (i * cardMargin) + (i * cardSize.width), (self.frame.size.height / 2) - (cardSize.height / 2), cardSize.width, cardSize.height);
        cardView.backgroundColor = [UIColor whiteColor];
        [self addSubview:cardView];
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
