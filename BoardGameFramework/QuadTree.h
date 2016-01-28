//
//  QuadTree.h
//  BoardGameLibrary
//
//  Created by Benjamin Wishart on 2015-04-13.
//  Copyright (c) 2015 Benjamin Wishart. All rights reserved.
//

#define MAX_OBJECTS        3
#define MAX_LEVELS         100

#import <Foundation/Foundation.h>
#import "SlotView.h"

@interface QuadTree : NSObject
{
   int level;
   NSMutableArray *nodes;
}

@property (nonatomic) NSMutableArray *objects;
@property (nonatomic,readonly) CGRect bounds;

-(id)initWithCurrentLevel:(int)currentLevel
                   bounds:(CGRect)b;

- (BOOL)hasNodes;
- (BOOL)hasObjects;
- (void)printTree:(NSString *)indent last:(BOOL)last;
- (void)insertSlotView:(SlotView *)slotView;
- (void)clear;
- (NSMutableArray *)objectsAtPoint:(CGPoint)point;

@end
