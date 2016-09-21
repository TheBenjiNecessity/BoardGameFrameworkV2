//
//  GameViewController.h
//  Tests
//
//  Created by Benjamin Wishart on 2016-02-14.
//  Copyright © 2016 Benjamin Wishart. All rights reserved.
//

#import "ViewController.h"

@interface GameViewController : ViewController

@property (weak, nonatomic) IBOutlet BGDeckView *deckView;
@property (weak, nonatomic) IBOutlet BGScrollingHandView *handView;

@end
