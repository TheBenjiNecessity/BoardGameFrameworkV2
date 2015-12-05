//
//  ViewController.m
//  Tests
//
//  Created by Benjamin Wishart on 2015-06-27.
//  Copyright (c) 2015 Benjamin Wishart. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize card;
@synthesize handview;

- (void)viewDidLoad {
   [super viewDidLoad];
   // Do any additional setup after loading the view, typically from a nib.
   [card setDelegate:self];
    [card setWillLongPress:NO];
    
    CardView *cardView = [[CardView alloc] init];
    cardView.layer.borderWidth = 1.0;
    cardView.layer.borderColor = [UIColor blackColor].CGColor;
    [cardView setWillLongPress:YES];
    [cardView setWillDrag:NO];
    [cardView initialize];
    
    [handview setPagingEnabled:YES];
    [handview setCardMargin:10.0];
    [handview setCardSize:CGSizeMake(90.0, 140.0)];
    [handview addCardView:cardView];
    [handview addCardView:[[CardView alloc] init]];
    [handview addCardView:[[CardView alloc] init]];
    [handview addCardView:[[CardView alloc] init]];
    [handview addCardView:[[CardView alloc] init]];
    [handview addCardView:[[CardView alloc] init]];
    [handview addCardView:[[CardView alloc] init]];
    [handview addCardView:[[CardView alloc] init]];
    [handview addCardView:[[CardView alloc] init]];
    [handview addCardView:[[CardView alloc] init]];
    [handview refreshHand];
}

- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

- (void) view:(UIView *)view didStartDraggingWithGestureRecognizer:(UIPanGestureRecognizer *)recognizer {
   
}

- (void) view:(UIView *)view didEndDraggingWithGestureRecognizer:(UIPanGestureRecognizer *)recognizer {
   
}

- (void) view:(UIView *)view isDraggingWithGestureRecognizer:(UIPanGestureRecognizer *)recognizer {
    SlotViewCollectionView *svcv = (SlotViewCollectionView *)self.view;
    CGPoint translationPoint = [recognizer translationInView:svcv];
    CGFloat x = recognizer.view.center.x + translationPoint.x;
    CGFloat y = recognizer.view.center.y + translationPoint.y;
    CGPoint newCenterPoint = CGPointMake(x, y);
    
    SlotView *currentSlotView = [svcv slotViewAtPoint:newCenterPoint];
    [currentSlotView slotViewIsHighlighted:YES];
   /*
    [recognizer locationInView:self.view] = coordinates of finger
    
    recognizer.view = dragging view
    */
}

@end
