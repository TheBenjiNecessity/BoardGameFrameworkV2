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

- (void)viewDidLoad {
   [super viewDidLoad];
   // Do any additional setup after loading the view, typically from a nib.
   [card setDelegate:self];
    card.willDragAfterLongPress = NO;
    BGHandView *handView = [[BGHandView alloc] initWithFrame:CGRectMake(10.0, 400.0, 90.0 * 5 + 10, 170.0) pagingEnabled:NO];
    handView.backgroundColor = [UIColor darkGrayColor];
    handView.center = CGPointMake(self.view.frame.size.height - (handView.frame.size.height + 10), self.view.center.y);
    [self.view addSubview:handView];

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
