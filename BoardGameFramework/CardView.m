//
//  CardView.m
//  BoardGameFramework
//
//  Created by Benjamin Wishart on 2015-02-20.
//  Copyright (c) 2015 Benjamin Wishart. All rights reserved.
//

#import "CardView.h"

@implementation CardView

//the way cardview should work is it should create a draggable copy of itself rather than allow itself to be dragged.
//This will work when pulling the view out of a subview.

+(UIImage *)cardBackImage
{
    static UIImage *back;
    if (back == nil)
    {
        
    }
    return back;
}

@end
