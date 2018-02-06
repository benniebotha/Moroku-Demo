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

//Initial setup done here
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    // Initialise bookkeeping values
    avatarTopID = playerAttrib_top_1;
    avatarBottomID = playerAttrib_bottom_1;
    
    //Create nice border
    avatarBorderView.layer.borderColor = [UIColor colorWithRed:0.27 green:0.53 blue:0.95 alpha:1.00].CGColor;
    avatarBorderView.layer.borderWidth = 3.0;
    avatarBorderView.layer.cornerRadius = 40.0;
    
    //Set up initial animation conditions
    [avatarHairView setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, 500, 0)];
    [avatarShirtView setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, -500, 0)];
    
    [avatarBorderView setAlpha:0.0];
    [avatarView setAlpha:0.0];
    [avatarHairView setAlpha:1.0];
    [avatarShirtView setAlpha:1.0];
    
    [avatarBorderView setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 5.0, 5.0)];
    [avatarView setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 0.5, 0.5)];
    [avatarHairView setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, 500, 0)];
    
    
    //init the player model
    self.playerModel = [[BBPlayer alloc] init];
    //Start initial update request to server
    [self.playerModel updatePlayerWithCompletionHandler:nil];
    
    [popViewsR setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -105)];
    [popViewsG setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -105)];
    [popViewsB setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, 0, -105)];
    
    [helloLabel setAlpha:0.0];
    [helloLabel setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4)];
    
    //perform a series of welcome animations
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
        //after last animation update the GUI
        [self updateAvatarLook];
        
        //Start update runloop for continious server updates to be detedted
        //time editable in the header file
        [self.repeatingTimer invalidate];
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:UPDATE_RUNLOOP_UPDATE_TIME
                                                          target:self selector:@selector(updateRunloop:)
                                                        userInfo:self repeats:YES];
        
        self.repeatingTimer = timer;
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * Method called for manual server update call to be made on button press
 * @param sender The button being pressed
 */
-(IBAction)updatePressedWithSender:(id)sender{
    [self.playerModel updatePlayerWithCompletionHandler:^(NSError * _Nullable error) {
        //update GUI with new information if available
        [self updateAvatarLook];
    }];
}

/**
 * Method called for magic event to be sent to server on button press
 * @param sender The button being pressed
 */
-(IBAction)magicPressedWithSender:(id)sender{
    [self.playerModel eventMagicWithCompletionHandler:^(NSError * _Nullable error) {
        [self.playerModel updatePlayerWithCompletionHandler:^(NSError * _Nullable error) {
            //update GUI with new information if available
            [self updateAvatarLook];
        }];
    }];
}

/**
 * Method called for rainbow event to be sent to server on button press
 * @param sender The button being pressed
 */
-(IBAction)rainbowPressedWithSender:(id)sender{
    [self.playerModel achievementRainbowWithCompletionHandler:^(NSError * _Nullable error) {
        if (error == nil){
            //update GUI with new information if available
            [self trophyAnimation];
        }
    }];
}

/**
 * Switches to the next avatar top value and updates the server on button press
 * @param sender The button being pressed
 */
-(IBAction)nextTopPressedWithSender:(id)sender{
    [self.playerModel nextTopWithCompletionHandler:nil];
    if (self.playerModel.playerTop == playerAttrib_top_1){
        self.playerModel.playerTop = playerAttrib_top_2;
    }else{
        self.playerModel.playerTop = playerAttrib_top_1;
    }
    [self updateAvatarLook];
}
/**
 * Switches to the next avatar bottom value and updates the server on button press
 * @param sender The button being pressed
 */
-(IBAction)nextBottomPressedWithSender:(id)sender{
    [self.playerModel nextBottomWithCompletionHandler:nil];
    
    if (self.playerModel.playerBottom == playerAttrib_bottom_1){
        self.playerModel.playerBottom = playerAttrib_bottom_2;
    }else{
        self.playerModel.playerBottom = playerAttrib_bottom_1;
    }
    
    [self updateAvatarLook];
}
/**
 * Updates the GUI with any new information to the player model if available.
 */
-(void)updateAvatarLook{
    //update player name (should happen only once in most cases)
    [playerNameLabel setText:self.playerModel.playerName];
    
    //Update points using animations
    if (![playerPointsLabel.text isEqualToString:[NSString stringWithFormat:@"%ld", self.playerModel.playerPoints]]){
        [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseIn animations:^{
            [playerPointsLabel setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 2.0, 2.0)];
        } completion:^(BOOL finished) {
            [playerPointsLabel setText:[NSString stringWithFormat:@"%ld", self.playerModel.playerPoints]];
            
            [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.4 initialSpringVelocity:0.9 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [playerPointsLabel setTransform:CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)];
            } completion:^(BOOL finished) {
                
            }];
        }];
    }
    
    //for testing many achievements:
//    [self.playerModel setPlayerAchievements:@[[[BBAchievement alloc] initWithAchievementID:2 achievementName:@"test1" achievementDescription:@"" achievementImageURL:@"https://s3-ap-southeast-2.amazonaws.com/gameserver-sandbox/bennie/achievements/images/1/tattly_jessi_arrington_rainbow_web_design_01_grande.jpg?1517456714"],[[BBAchievement alloc] initWithAchievementID:2 achievementName:@"test1" achievementDescription:@"" achievementImageURL:@"https://s3-ap-southeast-2.amazonaws.com/gameserver-sandbox/bennie/achievements/images/1/tattly_jessi_arrington_rainbow_web_design_01_grande.jpg?1517456714"],[[BBAchievement alloc] initWithAchievementID:2 achievementName:@"test1" achievementDescription:@"" achievementImageURL:@"https://s3-ap-southeast-2.amazonaws.com/gameserver-sandbox/bennie/achievements/images/1/tattly_jessi_arrington_rainbow_web_design_01_grande.jpg?1517456714"],[[BBAchievement alloc] initWithAchievementID:2 achievementName:@"test1" achievementDescription:@"" achievementImageURL:@"https://s3-ap-southeast-2.amazonaws.com/gameserver-sandbox/bennie/achievements/images/1/tattly_jessi_arrington_rainbow_web_design_01_grande.jpg?1517456714"],[[BBAchievement alloc] initWithAchievementID:2 achievementName:@"test1" achievementDescription:@"" achievementImageURL:@"https://s3-ap-southeast-2.amazonaws.com/gameserver-sandbox/bennie/achievements/images/1/tattly_jessi_arrington_rainbow_web_design_01_grande.jpg?1517456714"],[[BBAchievement alloc] initWithAchievementID:2 achievementName:@"test1" achievementDescription:@"" achievementImageURL:@"https://s3-ap-southeast-2.amazonaws.com/gameserver-sandbox/bennie/achievements/images/1/tattly_jessi_arrington_rainbow_web_design_01_grande.jpg?1517456714"],[[BBAchievement alloc] initWithAchievementID:2 achievementName:@"test1" achievementDescription:@"" achievementImageURL:@"https://s3-ap-southeast-2.amazonaws.com/gameserver-sandbox/bennie/achievements/images/1/tattly_jessi_arrington_rainbow_web_design_01_grande.jpg?1517456714"],[[BBAchievement alloc] initWithAchievementID:2 achievementName:@"test1" achievementDescription:@"" achievementImageURL:@"https://s3-ap-southeast-2.amazonaws.com/gameserver-sandbox/bennie/achievements/images/1/tattly_jessi_arrington_rainbow_web_design_01_grande.jpg?1517456714"],[[BBAchievement alloc] initWithAchievementID:2 achievementName:@"test1" achievementDescription:@"" achievementImageURL:@"https://s3-ap-southeast-2.amazonaws.com/gameserver-sandbox/bennie/achievements/images/1/tattly_jessi_arrington_rainbow_web_design_01_grande.jpg?1517456714"],[[BBAchievement alloc] initWithAchievementID:2 achievementName:@"test1" achievementDescription:@"" achievementImageURL:@"https://s3-ap-southeast-2.amazonaws.com/gameserver-sandbox/bennie/achievements/images/1/tattly_jessi_arrington_rainbow_web_design_01_grande.jpg?1517456714"],[[BBAchievement alloc] initWithAchievementID:2 achievementName:@"test1" achievementDescription:@"" achievementImageURL:@"https://s3-ap-southeast-2.amazonaws.com/gameserver-sandbox/bennie/achievements/images/1/tattly_jessi_arrington_rainbow_web_design_01_grande.jpg?1517456714"]]];
    
    //add achievement icons as neccacary
    int count = 0;
    for (BBAchievement * achieve in self.playerModel.playerAchievements) {
        //must use HTTPS as per ATP policy.
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: [achieve.achievementImageURL stringByReplacingOccurrencesOfString:@"http://" withString:@"https://"]]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData: imageData]];
        [imageView setAutoresizingMask:(UIViewAutoresizingFlexibleHeight & UIViewAutoresizingFlexibleWidth)];
        [imageView setFrame:CGRectMake(0+(56*count), 0, 46, 46)];
        [achievementsScrollView addSubview:imageView];
        [achievementsScrollView setContentSize:CGSizeMake(56*count+46, 46)];
        
        [achieve printLogAchievement];
        
        count++;
    }
    
    
    //animate changing of top/bottom avatar components as neccacay
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

/**
 * Performs a series of animations to show the achievement trophy.
 */
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

/**
 * A runloop function that is implemented through the use of a timer to continiously poll server updates at a spesific update frequincy.
 * @param viewController The caller of the runloop.
 */
-(void)updateRunloop:(UIViewController*) viewController{
    [self.playerModel updatePlayerWithCompletionHandler:^(NSError * _Nullable error) {
        [self updateAvatarLook];
        avatarBottomID = self.playerModel.playerBottom;
        avatarTopID = self.playerModel.playerTop;
    }];
    
}


@end
