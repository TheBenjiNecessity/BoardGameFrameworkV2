//
//  QuadTree.m
//  BoardGameLibrary
//
//  Created by Benjamin Wishart on 2015-04-13.
//  Copyright (c) 2015 Benjamin Wishart. All rights reserved.
//

#import "QuadTree.h"

@implementation QuadTree
@synthesize objects;
@synthesize bounds;

- (id)init {
   if (self = [super init]) {
      level = 0;
      objects = [[NSMutableArray alloc] init];
      nodes = [[NSMutableArray alloc] initWithCapacity:4];
   }
   
   return self;
}

-(id)initWithCurrentLevel:(int)currentLevel bounds:(CGRect)b {
   if (self = [super init]) {
      level = currentLevel;
      objects = [[NSMutableArray alloc] init];
      bounds = b;
      nodes = [[NSMutableArray alloc] initWithCapacity:4];
   }
   
   return self;
}

-(void)clear {
   [objects removeAllObjects];
   
   for (int i = 0; i < nodes.count; i++) {
      if ([nodes objectAtIndex:i] != nil) {
         QuadTree *nodeAtI = (QuadTree *)[nodes objectAtIndex:i];
         [nodeAtI clear];
         [nodes removeObjectAtIndex:i];
      }
   }
}

-(void)split {
   int subWidth = (int)(bounds.size.width / 2);
   int subHeight = (int)(bounds.size.height / 2);
   int x = (int)bounds.origin.x;
   int y = (int)bounds.origin.y;
   
   QuadTree *one = [[QuadTree alloc] initWithCurrentLevel:level + 1 bounds:CGRectMake(x, y, subWidth, subHeight)];
   QuadTree *two = [[QuadTree alloc] initWithCurrentLevel:level + 1 bounds:CGRectMake(x + subWidth, y, subWidth, subHeight)];
   QuadTree *three = [[QuadTree alloc] initWithCurrentLevel:level + 1 bounds:CGRectMake(x + subWidth, y + subHeight, subWidth, subHeight)];
   QuadTree *four = [[QuadTree alloc] initWithCurrentLevel:level + 1 bounds:CGRectMake(x, y + subHeight, subWidth, subHeight)];

   for (int i = 0; i < [objects count]; i++) {
      SlotView *sw = [objects objectAtIndex:i];
      if (CGRectIntersectsRect(sw.frame, one.bounds)) {
         [one.objects addObject:sw];
      }
      if (CGRectIntersectsRect(sw.frame, two.bounds)) {
         [two.objects addObject:sw];
      }
      if (CGRectIntersectsRect(sw.frame, three.bounds)) {
         [three.objects addObject:sw];
      }
      if (CGRectIntersectsRect(sw.frame, four.bounds)) {
         [four.objects addObject:sw];
      }
   }
   [objects removeAllObjects];
   
   [nodes addObject:one];
   [nodes addObject:two];
   [nodes addObject:three];
   [nodes addObject:four];
}

-(NSArray *)intersectionsByRect:(CGRect)rect {
   NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:4];

   CGPoint origin = bounds.origin;
   CGSize size = bounds.size;
   
   CGFloat halfWidth = (size.width / 2);
   CGFloat halfHeight = (size.height / 2);
   
   CGRect topLeftBounds = CGRectMake(origin.x, origin.y, halfWidth, halfHeight);
   CGRect bottomLeftBounds = CGRectMake(origin.x, origin.y + halfHeight, halfWidth, halfHeight);
   CGRect topRightBounds = CGRectMake(origin.x + halfWidth, origin.y, halfWidth, halfHeight);
   CGRect bottomRightBounds = CGRectMake(origin.x + halfWidth, origin.y + halfHeight, halfWidth, halfHeight);
   
   NSNumber *intersectsTopLeft = [NSNumber numberWithBool:CGRectIntersectsRect(rect, topLeftBounds)];
   NSNumber *intersectsTopRight = [NSNumber numberWithBool:CGRectIntersectsRect(rect, topRightBounds)];
   NSNumber *intersectsBottomLeft = [NSNumber numberWithBool:CGRectIntersectsRect(rect, bottomLeftBounds)];
   NSNumber *intersectsBottomRight = [NSNumber numberWithBool:CGRectIntersectsRect(rect, bottomRightBounds)];
   
   [result addObject:intersectsTopLeft];
   [result addObject:intersectsTopRight];
   [result addObject:intersectsBottomRight];
   [result addObject:intersectsBottomLeft];
   
   return result;
}

-(int)indexByPoint:(CGPoint)point {
   int subWidth = (int)(bounds.size.width / 2);
   int subHeight = (int)(bounds.size.height / 2);
   int x = (int)bounds.origin.x;
   int y = (int)bounds.origin.y;
   int xPlusWidth = x + subWidth;
   int yPlusHeight = y + subHeight;
   
   CGRect topLeft = CGRectMake(x, y, subWidth, subHeight);
   CGRect topRight = CGRectMake(xPlusWidth, y, subWidth, subHeight);
   CGRect bottomLeft = CGRectMake(x, yPlusHeight, subWidth, subHeight);
   CGRect bottomRight = CGRectMake(xPlusWidth, yPlusHeight, subWidth, subHeight);
   
   if (CGRectContainsPoint(topLeft, point)) {
      return 0;
   } else  if (CGRectContainsPoint(topRight, point)) {
      return 1;
   } else if (CGRectContainsPoint(bottomRight, point)) {
      return 2;
   } else if (CGRectContainsPoint(bottomLeft, point)) {
      return 3;
   } else {
      return -1;
   }
}

- (BOOL)hasNodes {
   return [nodes count] > 0;
}

- (BOOL)hasObjects {
   return [objects count] > 0;
}

-(void)insertSlotView:(SlotView *) slotView {
   //if this node has child nodes then go one step down the tree
   if ([self hasNodes]) {
      NSArray *intersections = [self intersectionsByRect:slotView.frame];
      
      for (int i = 0; i < [intersections count]; i++) {
         if ([[intersections objectAtIndex:i] boolValue]) {
            QuadTree *node = (QuadTree *)[nodes objectAtIndex:i];
            [node insertSlotView:slotView];
         }
      }
      return;
   }
   
   //if this node does not have children then just add the slotview as normal
   [objects addObject:slotView];
   
   //if adding this slotview causes objects to have a count greater than the
   //limit for a node then split the node into four
   if (objects.count > MAX_OBJECTS && level < MAX_LEVELS) {
      [self split];
   }
}

-(NSMutableArray *)objectsAtPoint:(CGPoint)point {
   return [self objects:nil atPoint:point];
}

-(NSMutableArray *)objects:(NSMutableArray *)returnObjects atPoint:(CGPoint)point {
   if (!returnObjects) {
      returnObjects = [[NSMutableArray alloc] init];
   }
   
   int index = [self indexByPoint:point];
   if (index != -1 && [self hasNodes]) {
      QuadTree *node = (QuadTree *)[nodes objectAtIndex:index];
      return [node objects:returnObjects atPoint:point];
   }
   
   return objects;
}

- (void)printTree:(NSString *)indent last:(BOOL)last {
   if (last)
   {
      printf("\\-");
      indent = [indent stringByAppendingString:@"  "];
   }
   else
   {
      printf("|-");
      indent = [indent stringByAppendingString:@"| "];
   }
   
   printf("%d\n", [objects count]);
   
   for (int i = 0; i < [nodes count]; i++) {
      QuadTree *node = [nodes objectAtIndex:i];
      [node printTree:indent last:i == [nodes count] - 1];
   }
   
}

@end
