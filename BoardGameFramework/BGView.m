//
//  BGView.m
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2016-02-07.
//  Copyright © 2016 Benjamin Wishart. All rights reserved.
//

#import "BGView.h"

@implementation BGView

- (id)init {
    if (self = [super init]) {
        [self initialize];
    }
    
    return self;
}

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

- (void)initialize {}

@end
