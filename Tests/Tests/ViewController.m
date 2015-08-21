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
   QuadTreeView *qvt = (QuadTreeView *)self.view;
   CGPoint translationPoint = [recognizer translationInView:qvt];
   CGFloat x = recognizer.view.center.x + translationPoint.x;
   CGFloat y = recognizer.view.center.y + translationPoint.y;
   CGPoint newCenterPoint = CGPointMake(x, y);
   NSLog(@"translationPoint: %f %f", translationPoint.x, translationPoint.y);
   [qvt highlightSlotviewAtPoint:newCenterPoint];
   
   /*
    [recognizer locationInView:self.view] = coordinates of finger
    
    recognizer.view = dragging view
    */
}

@end
