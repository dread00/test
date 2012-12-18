//
//  RootViewController.m
//  test
//
//  Created by biubiu on 12-12-17.
//  Copyright (c) 2012年 biubiu. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController
@synthesize scoreLabel,ball,paddle;
-(void)dealloc
{
    [scoreLabel release];
    [ball release];
    [paddle release];
    [super dealloc];
}
-(void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    float newX=paddle.center.x+(acceleration.x*12);
    if (newX>30&&newX<290) {
        paddle.center=CGPointMake(newX, paddle.center.y);
    }
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIAccelerometer *theAccel=[UIAccelerometer sharedAccelerometer];
    theAccel.updateInterval=1.0f/30.0f;
    theAccel.delegate=self;
    ballMovement=CGPointMake(4, 4);
    [self initializeTimer];
    
	// Do any additional setup after loading the view.
}

-(void)initializeTimer
{
    float theInterval = 1.0/30.0;
    [NSTimer scheduledTimerWithTimeInterval:theInterval target:self selector:@selector(animateBall:) userInfo:nil repeats:YES];
}
-(void)animateBall:(NSTimer *)theTimer
{
    BOOL paddleCollision=ball.center.y>=paddle.center.y-16
                        &&ball.center.y<=paddle.center.y+16
                        &&ball.center.x>paddle.center.x-32
                        &&ball.center.x<paddle.center.x+32;
    if (paddleCollision) {
        ballMovement.y=-ballMovement.y;
    }
    if (ball.center.y>=paddle.center.y-16&&ballMovement.y<0) {
        ball.center=CGPointMake(ball.center.x, paddle.center.y-16);
    }else if (ball.center.y<=paddle.center.y+16&&ballMovement.y>0)
    {
        ball.center=CGPointMake(ball.center.x, paddle.center.y+16);
    }else if (ball.center.x>=paddle.center.x-32&&ballMovement.x<0)
    {
        ball.center=CGPointMake(paddle.center.x-32, ball.center.y);
    }else if (ball.center.x<=paddle.center.x+32&&ballMovement.x>0)
    {
        ball.center=CGPointMake(paddle.center.x+32, ball.center.y);
    }
    
    ball.center=CGPointMake(ball.center.x+ballMovement.x, ball.center.y+ballMovement.y);
    if (ball.center.x>300||ball.center.x<20) {
        ballMovement.x=-ballMovement.x;
    }
    if (ball.center.y>440||ball.center.y<40) {
        ballMovement.y=-ballMovement.y;
    }
}
//-------------------touch事件------------------------//
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[[event allTouches]anyObject];
    touchOffset=paddle.center.x-[touch locationInView:touch.view].x;
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[[event allTouches]anyObject];
    float distanceMoved=([touch locationInView:touch.view].x+touchOffset)-paddle.center.x;
    float newX=paddle.center.x+distanceMoved;
    if (newX>30&&newX<290) {
        paddle.center=CGPointMake(newX,paddle.center.y);
    }
    if (newX>290) {
        paddle.center=CGPointMake(290, paddle.center.y);
    }
    if (newX<30) {
        paddle.center=CGPointMake(30, paddle.center.y);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
