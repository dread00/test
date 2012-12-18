//
//  RootViewController.h
//  test
//
//  Created by biubiu on 12-12-17.
//  Copyright (c) 2012年 biubiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController<UIAccelerometerDelegate>
{
    UILabel *scoreLabel;
    int score;
    UIImageView *ball;
    CGPoint ballMovement;
    UIImageView *paddle;

}
@property(nonatomic,retain)UILabel *scoreLabel;
@property(nonatomic,retain)UIImageView *ball;
@property(nonatomic,retain)UIImageView *paddle;
-(void)initializeTimer;
-(void)animateBall:(NSTimer *)theTimer;
@end