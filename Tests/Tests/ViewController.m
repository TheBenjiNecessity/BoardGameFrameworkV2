//
//  ViewController.m
//  Tests
//
//  Created by Benjamin Wishart on 2015-06-27.
//  Copyright (c) 2015 Benjamin Wishart. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize handview;
@synthesize deckView;

- (void)viewDidLoad {
   [super viewDidLoad];
   // Do any additional setup after loading the view, typically from a nib.
    
    CardView *cardView = [[CardView alloc] init];
    cardView.layer.borderWidth = 1.0;
    cardView.layer.borderColor = [UIColor blackColor].CGColor;
    
    //[handview setPagingEnabled:YES];
    [handview setPagingEnabled:YES];
    [handview setCardMargin:10.0];
    [handview setCardSize:CGSizeMake(90.0, 140.0)];
    [handview addCardView:cardView];
    [handview addCardView:[[CardView alloc] init]];
    [handview addCardView:[[CardView alloc] init]];
    [handview addCardView:[[CardView alloc] init]];
    [handview addCardView:[[CardView alloc] init]];
    [handview addCardView:[[CardView alloc] init]];
    [handview addCardView:[[CardView alloc] init]];
    [handview addCardView:[[CardView alloc] init]];
    [handview addCardView:[[CardView alloc] init]];
    [handview addCardView:[[CardView alloc] init]];
    [handview refreshHand];
    
    CardView *nonRotatingCardView = [[CardView alloc] initWithFrame:CGRectMake(100.0, 400.0, 90.0, 140.0)];
    [nonRotatingCardView.layer setBorderColor:[UIColor blackColor].CGColor];
    [nonRotatingCardView.layer setBorderWidth:1.0];
    
    CardView *rotatingCardView = [[CardView alloc] initWithFrame:CGRectMake(100.0, 400.0, 90.0, 140.0)];
    [rotatingCardView.layer setBorderColor:[UIColor blackColor].CGColor];
    [rotatingCardView.layer setBorderWidth:1.0];
    
    //[rotatingCardView rotateAroundBottomCenterByDegrees:-30.0];
    
    CGPoint testPoint = CGPointMake(500, 500);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(testPoint.x, testPoint.y, 10, 10)];
    [view setBackgroundColor:[UIColor blackColor]];
    //[self.view addSubview:view];
    
    [rotatingCardView showBack];
    [rotatingCardView rotateSide:LEFT toFacePoint:testPoint];
    
    NSData *jsondata = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cards" ofType:@"json"]];
    Deck *deck = [[Deck alloc] initWithJSONFile:jsondata];
    [deck print];
    
    [deckView.layer setBorderColor:[UIColor blackColor].CGColor];
    [deckView.layer setBorderWidth:1.0];
    
//    [self.view addSubview:nonRotatingCardView];
//    [self.view addSubview:rotatingCardView];
    
    CGSize size = CGSizeMake(82, 118);
    UIImage *spriteSheetImage = [UIImage imageNamed:@"CardSpriteSheet.gif"];
    BGSpriteSheet *spriteSheet = [[BGSpriteSheet alloc] initWithImage:spriteSheetImage
                                                               atSize:size];
    UIImage *image = [spriteSheet imageAtPoint:CGPointMake(0.0, 0.0)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setFrame:CGRectMake(500, 500, size.width, size.height)];
    [imageView.layer setCornerRadius:5.0];
    //[self.view addSubview:imageView];
}

- (IBAction)dealCard:(UIButton *)sender {
    CGPoint dealPoint = CGPointMake(-100.0, -100.0);
    CGPoint facingPoint = CGPointMake(900.0, 10.0);
    Side side = LEFT;
    
    //[deckView dealToPoint:CGPointMake(-100.0, -100.0)];
    [deckView dealToPoint:dealPoint withSide:side facingPoint:facingPoint];
}

- (void)didReceiveMemoryWarning {
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}

- (void) view:(UIView *)view didStartDraggingWithGestureRecognizer:(UIPanGestureRecognizer *)recognizer {
   
}

- (void) view:(UIView *)view didEndDraggingWithGestureRecognizer:(UIPanGestureRecognizer *)recognizer {
   
}

- (void) view:(UIView *)view isDraggingWithGestureRecognizer:(UIPanGestureRecognizer *)recognizer {
    if ([self.view isKindOfClass:[SlotViewCollectionView class]]) {
        SlotViewCollectionView *svcv = (SlotViewCollectionView *)self.view;//what if this isn't true
        CGPoint translationPoint = [recognizer translationInView:svcv];
        CGFloat x = recognizer.view.center.x + translationPoint.x;
        CGFloat y = recognizer.view.center.y + translationPoint.y;
        CGPoint newCenterPoint = CGPointMake(x, y);
        
        SlotView *currentSlotView = [svcv slotViewAtPoint:newCenterPoint];
        [currentSlotView setHighlighted:YES];
    } else {
        
    }
}

@end
