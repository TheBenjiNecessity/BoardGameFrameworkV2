//
//  Card.m
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2015-02-19.
//  Copyright (c) 2015 Benjamin Wishart. All rights reserved.
//

#import "Card.h"

@implementation Card
@synthesize displayTitle;
@synthesize displayDescription;

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super init]) {
        displayTitle = [dictionary objectForKey:@"title"];
        displayDescription = [dictionary objectForKey:@"description"];
    }
    return self;
}

-(id)initWithDisplayTitle:(NSString *)title
              description:(NSString *)description
{
    if (self = [super init])
    {
       displayTitle = title;
       displayDescription = description;
    }
    
    return self;
}

@end
