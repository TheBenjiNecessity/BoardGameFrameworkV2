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
@synthesize rows;

- (int)numberOfSlotsHigh {
    return (int)ceilf(self.frame.size.height / BOX_DIM);
}

- (int)numberOfSlotsWide {
    return (int)ceilf(self.frame.size.width / BOX_DIM);
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {

    }
    return self;
}

- (void)insertSlotView:(SlotView *)slotView {
    if (![rows count]) {
        rows = [[NSMutableArray alloc] initWithCapacity:[self numberOfSlotsHigh]];
        for (int i = 0; i < [self numberOfSlotsHigh]; i++) {
            NSMutableArray *column = [[NSMutableArray alloc] initWithCapacity:[self numberOfSlotsWide]];
            for (int j = 0; j < [self numberOfSlotsWide]; j++) {
                NSMutableArray *slotviews = [[NSMutableArray alloc] init];
                [column addObject:slotviews];
            }
            [rows addObject:column];
            
        }
    }
    
    for (int x = slotView.frame.origin.x; x - BOX_DIM <= slotView.frame.origin.x + slotView.frame.size.width; x += BOX_DIM) {
        for (int y = slotView.frame.origin.y; y - BOX_DIM <= slotView.frame.origin.y + slotView.frame.size.height; y += BOX_DIM) {
            BGIndices indices = [self getIndicesAtPoint:CGPointMake(x, y)];
            
            NSMutableArray *row = [rows objectAtIndex:indices.row];
            NSMutableArray *column = [row objectAtIndex:indices.column];
            
            [column addObject:slotView];
        }
    }
}

- (SlotView *)slotViewAtPoint:(CGPoint)point {
    BGIndices indices = [self getIndicesAtPoint:point];
    NSMutableArray *row = [rows objectAtIndex:indices.row];
    NSMutableArray *column = [row objectAtIndex:indices.column];
    
    for (SlotView *slotView in column) {
        if (CGRectContainsPoint(slotView.frame, point)) {
            return slotView;
        }
    }
    
    return nil;
}

- (BGIndices)getIndicesAtPoint:(CGPoint)point {
    int row = floorf(point.y / BOX_DIM);
    int column = floorf(point.x / BOX_DIM);
    return BGIndicesMake(row, column);
}

+ (NSArray *)arrayOfAllSlotViewCollectionViewsAsDescendantsOfView:(UIView *)view {
    if ([view.subviews count] == 0) {
        if ([view isKindOfClass:[SlotViewCollectionView class]]) {
            return [NSArray arrayWithObject:view];
        } else {
            return nil;
        }
    } else {
        NSMutableArray *resultingArray = [[NSMutableArray alloc] init];
        for (UIView *subview in view.subviews) {
            [resultingArray addObjectsFromArray:[self arrayOfAllSlotViewCollectionViewsAsDescendantsOfView:subview]];
        }
        return resultingArray;
    }
}

@end
