//
//  BGScrollingHandView.m
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2015-10-13.
//  Copyright © 2015 Benjamin Wishart. All rights reserved.
//

#import "BGScrollingHandView.h"
#import "SlotViewCollectionView.h"

@interface BGScrollingHandView ()
{
    SlotViewCollectionView *slotViewCollectionView;
}

@end

@implementation BGScrollingHandView
@synthesize cardSize, cardMargin;
@synthesize longPressGestureRecognizer;
@synthesize scrollView;

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
    [super initialize];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [scrollView setClipsToBounds:YES];
    
    longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(viewDidLongPress:)];
    [longPressGestureRecognizer setDelegate:self];
    [self addGestureRecognizer:longPressGestureRecognizer];
    
    [self addSubview:scrollView];
}

- (void)didMoveToSuperview {
    slotViewCollectionView = (SlotViewCollectionView *)self.superview;
    
    if (!slotViewCollectionView) {
        [NSException raise:@"Invalid parent view" format:@"Hand view must be a child of a SlotViewCollectionView"];
    }
}

- (void)addCardView:(CardView *)cardView {
    [cardView.panGestureRecognizer setEnabled:NO];
    [super addCardView:cardView];
    
}

- (void)refreshHand {
    [scrollView setContentSize:CGSizeMake((cardSize.width + cardMargin) * [cardViews count] + cardMargin,
                                          scrollView.frame.size.height)];

    [cardViews enumerateObjectsUsingBlock:^(CardView * _Nonnull cardView, NSUInteger i, BOOL * _Nonnull stop) {
        cardView.frame = CGRectMake(cardMargin + (i * cardMargin) + (i * cardSize.width), (scrollView.frame.size.height / 2) - (cardSize.height / 2), cardSize.width, cardSize.height);
        cardView.backgroundColor = [UIColor whiteColor];
        [scrollView addSubview:cardView];
    }];
}

- (void)cardIsDraggingWithPanGesture:(UIPanGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        if (draggingCardView) {
            [scrollView.panGestureRecognizer setEnabled:NO];
        }
    }
    
    [super cardIsDraggingWithPanGesture:gestureRecognizer];
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (draggingCardView) {
            [scrollView.panGestureRecognizer setEnabled:YES];
        }

        //TODO figure out if card is able to be planted
        //the slot should send a message (delegate?)
        
        draggingCardView = nil;
    }

}



@end
