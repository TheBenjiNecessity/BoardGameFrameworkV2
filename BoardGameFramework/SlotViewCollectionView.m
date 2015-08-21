//
//  QuadTreeView.m
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2015-07-01.
//  Copyright (c) 2015 Benjamin Wishart. All rights reserved.
//

#import "SlotViewCollectionView.h"

@implementation SlotViewCollectionView
@synthesize quadTree;
@synthesize selectedSlotview;

- (void)insertIntoQuadTreeSlotView:(SlotView *)slotView {
   if (!quadTree) {
      quadTree = [[QuadTree alloc] initWithCurrentLevel:0 bounds:self.bounds];
   }
   
   [quadTree insertSlotView:slotView];
}

- (void)highlightSlotviewAtPoint: (CGPoint)point {
   if (!CGRectContainsPoint(selectedSlotview.frame, point)) {
      if (selectedSlotview) {
         [selectedSlotview slotViewIsHighlighted:NO];
         selectedSlotview = nil;
      }
      
      NSArray *objects = [quadTree objectsAtPoint:point];
      
      for (SlotView *slotview in objects) {
         if (CGRectContainsPoint(slotview.frame, point)) {
            [slotview slotViewIsHighlighted:YES];
            selectedSlotview = slotview;
         }
      }
   }
}

- (void)didMoveToSuperview {
   [quadTree printTree:@"" last:YES];
   NSDate *methodStart = [NSDate date];
   for (int i = 0; i < 1000; i++)
      [quadTree testPoint:CGPointMake(220.0, 110.0)];
   
   NSDate *methodFinish = [NSDate date];
   
   NSTimeInterval executionTime = [methodFinish timeIntervalSinceDate:methodStart];
   NSLog(@"executionTime = %f", (executionTime * 1000));
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
