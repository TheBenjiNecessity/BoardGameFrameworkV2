//
//  QuadTreeView.m
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2015-07-01.
//  Copyright (c) 2015 Benjamin Wishart. All rights reserved.
//

#import "SlotViewCollectionView.h"

struct BGIndices {
    int row;
    int column;
};
typedef struct BGIndices BGIndices;

BGIndices BGIndicesMake(int row, int column)
{
    BGIndices indices; indices.row = row; indices.column = column; return indices;
}

@implementation SlotViewCollectionView
@synthesize quadTree;
@synthesize selectedSlotview;
@synthesize rows;

- (void)insertSlotView:(SlotView *)slotView {
    if (!rows || [rows count] <= 0) {
        rows = [[NSMutableArray alloc] initWithCapacity:NUMBER_OF_SLOTS_HIGH];
        for (int i = 0; i < NUMBER_OF_SLOTS_HIGH; i++) {
            NSMutableArray *column = [rows objectAtIndex:i];
            column = [[NSMutableArray alloc] initWithCapacity:NUMBER_OF_SLOTS_WIDE];
        }
    }
    
    BGIndices indices = [self getIndicesAtPoint:slotView.frame.origin];
    NSMutableArray *column1 = [rows objectAtIndex:indices.row];
    NSMutableArray *column2 = [rows objectAtIndex:indices.row];
    NSMutableArray *objects = [column1 objectAtIndex:indices.column];
    if (!objects) {
        objects = [[NSMutableArray alloc] init];
    }
    
    [objects addObject:slotView];
}

- (SlotView *)objectAtPoint:(CGPoint)point {
    BGIndices indices = [self getIndicesAtPoint:point];
    NSMutableArray *column = [rows objectAtIndex:indices.row];
    for (SlotView *object in [column objectAtIndex:indices.column]) {
        if (CGRectContainsPoint(object.frame, point)) {
            return object;
        }
    }
    
    return nil;
}

- (void)insertIntoQuadTreeSlotView:(SlotView *)slotView {
   if (!quadTree) {
      quadTree = [[QuadTree alloc] initWithCurrentLevel:0 bounds:self.bounds];
   }
   
   [quadTree insertSlotView:slotView];
}

- (BGIndices)getIndicesAtPoint:(CGPoint)point {
    CGFloat widthOfBox = self.bounds.size.width / NUMBER_OF_SLOTS_WIDE;
    CGFloat heightOfBox = self.bounds.size.height / NUMBER_OF_SLOTS_HIGH;
    int row = (int)(point.y / heightOfBox);
    int column = (int)(point.x / widthOfBox);
    return BGIndicesMake(row, column);
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

@end
