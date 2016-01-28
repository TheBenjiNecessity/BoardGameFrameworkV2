//
//  ViewController.h
//  Tests
//
//  Created by Benjamin Wishart on 2015-06-27.
//  Copyright (c) 2015 Benjamin Wishart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BoardGameFramework/BoardGameFramework.h>

@interface ViewController : UIViewController <DraggableViewDelegate>

@property (weak, nonatomic) IBOutlet BGScrollingHandView *handview;

@end

