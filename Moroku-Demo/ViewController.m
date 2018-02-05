//
//  ViewController.m
//  Moroku-Demo
//
//  Created by Bennie Botha on 2018/02/03.
//  Copyright © 2018 Bennie Botha. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    avatarTopID = playerAttrib_top_1;
    avatarBottomID = playerAttrib_bottom_1;
    
    avatarBorderView.layer.borderColor = [UIColor colorWithRed:0.27 green:0.53 blue:0.95 alpha:1.00].CGColor;
    avatarBorderView.layer.borderWidth = 3.0;
    avatarBorderView.layer.cornerRadius = 40.0;
    
    [avatarHairView setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, 500, 0)];
    [avatarShirtView setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, -500, 0)];
    
    [avatarBorderView setAlpha:0.0];
    [avatarView setAlpha:0.0];
    [avatarHairView setAlpha:1.0];
    [avatarShirtView setAlpha:1.0];
    
    [avatarBorderView setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 5.0, 5.0)];
    [avatarView setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5)];
    [avatarHairView setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, 500, 0)];
    
    
    
    self.playerModel = [[BBPlayer alloc] init];
    
    [self.playerModel updatePlayerWithCompletionHandler:^(NSError * _Nullable error) {
        [self updateAvatarLook];
    }];
    
    [popViewsR setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -105)];
    [popViewsG setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -105)];
    [popViewsB setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -105)];
    
    [helloLabel setAlpha:0.0];
    [helloLabel setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4)];
    
    [UIView animateWithDuration:1.0 delay:0.5 usingSpringWithDamping:0.4 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [helloLabel setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 1.0 , 1.0)];
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:1.0 delay:0.35 usingSpringWithDamping:1.0 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [helloLabel setAlpha:1.0];
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:1.0 delay:2.0 usingSpringWithDamping:1.0 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [helloLabel setTransform:CGAffineTransformScale(CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -342), 0.7, 0.7)];
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.55 delay:1.0 usingSpringWithDamping:1.0 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [popViewsR setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0)];
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.6 delay:1.2 usingSpringWithDamping:1.0 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [popViewsG setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -5)];
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.65 delay:1.4 usingSpringWithDamping:1.0 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [popViewsB setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -10)];
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.65 delay:3.0 usingSpringWithDamping:1.0 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [avatarBorderView setAlpha:1.0];
        [avatarView setAlpha:1.0];
        
        [avatarBorderView setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)];
        [avatarView setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)];
        
        [avatarHairView setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0)];
        [avatarShirtView setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0)];
        
    } completion:^(BOOL finished) {
        [self updateAvatarLook];
        [self.repeatingTimer invalidate];
        
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:5.0
                                                          target:self selector:@selector(updateRunloop:)
                                                        userInfo:self repeats:YES];
        
        self.repeatingTimer = timer;
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.playerModel = nil;
}

/**
 * Method called for tester button press
 * @param sender The button being pressed
 */
-(IBAction)updatePressedWithSender:(id)sender{
    [self.playerModel updatePlayerWithCompletionHandler:^(NSError * _Nullable error) {
        [self updateAvatarLook];
    }];
    [self trophyAnimation];
}
-(IBAction)magicPressedWithSender:(id)sender{
    [self.playerModel eventMagicWithCompletionHandler:nil];
}
-(IBAction)rainbowPressedWithSender:(id)sender{
    [self.playerModel achievementRainbowWithCompletionHandler:nil];
}
-(IBAction)nextTopPressedWithSender:(id)sender{
    [self.playerModel nextTopWithCompletionHandler:nil];
}
-(IBAction)nextBottomPressedWithSender:(id)sender{
    [self.playerModel nextBottomWithCompletionHandler:nil];
}

-(void)updateAvatarLook{
    if (self.playerModel.playerTop != avatarTopID){
        NSString *newImageFileName = nil;
        if (avatarTopID == playerAttrib_top_1){
            avatarTopID = playerAttrib_top_2;
            newImageFileName = @"avatarHair2.png";
        }else{
            avatarTopID = playerAttrib_top_1;
            newImageFileName = @"avatarHair1.png";
        }
        
        [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            [avatarHairView setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, -500, 0)];
        } completion:^(BOOL finished) {
            [avatarHairView setImage:[UIImage imageNamed:newImageFileName]];
            [avatarHairView setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, 500, 0)];
            
            [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [avatarHairView setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0)];
            } completion:^(BOOL finished) {
                
            }];
        }];
        
    }
    
    if (self.playerModel.playerBottom != avatarBottomID){
        NSString *newImageFileName = nil;
        if (avatarBottomID == playerAttrib_bottom_1){
            avatarBottomID = playerAttrib_bottom_2;
            newImageFileName = @"avatarShirt2.png";
        }else{
            avatarBottomID = playerAttrib_bottom_1;
            newImageFileName = @"avatarShirt1.png";
        }
        
        [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            [avatarShirtView setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, 500, 0)];
        } completion:^(BOOL finished) {
            [avatarShirtView setImage:[UIImage imageNamed:newImageFileName]];
            [avatarShirtView setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, -500, 0)];
            
            [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [avatarShirtView setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0)];
            } completion:^(BOOL finished) {
                
            }];
        }];
    }
}


-(void)trophyAnimation{
    [trophyView setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5)];
    [trophyShineView setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5)];
    
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.35 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGAffineTransform transForAll = CGAffineTransformScale(CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -235), 0.3, 0.3);
        [avatarShirtView setTransform:transForAll];
        [avatarHairView setTransform:transForAll];
        [avatarBorderView setTransform:transForAll];
        [avatarView setTransform:transForAll];
        
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.5 delay:0.5 usingSpringWithDamping:0.35 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        [trophyView setAlpha:1.0];
        [trophyView setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)];
        
        
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:5.0 delay:0.7 usingSpringWithDamping:0.06 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        [trophyShineView setAlpha:1.0];
        [trophyShineView setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)];
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:2.0 usingSpringWithDamping:1.0 initialSpringVelocity:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            [trophyView setAlpha:0.0];
            [trophyShineView setAlpha:0.0];
            [trophyView setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5)];
            [trophyShineView setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5)];
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.35 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseIn animations:^{
                
                [avatarShirtView setTransform:CGAffineTransformIdentity];
                [avatarHairView setTransform:CGAffineTransformIdentity];
                [avatarBorderView setTransform:CGAffineTransformIdentity];
                [avatarView setTransform:CGAffineTransformIdentity];
                
            } completion:^(BOOL finished) {
                
            }];
            
        }];
    }];

}

-(void)updateRunloop:(UIViewController*) viewController{
    [self.playerModel updatePlayerWithCompletionHandler:^(NSError * _Nullable error) {
        [self updateAvatarLook];
    }];
    
}


@end
