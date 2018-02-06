//
//  ViewController.h
//  Moroku-Demo
//
//  Created by Bennie Botha on 2018/02/03.
//  Copyright © 2018 Bennie Botha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CryptoUtil.h"
#import "Constants.h"
#import "BBPlayer.h"

@interface ViewController : UIViewController{
    
//Outlets
    IBOutlet UILabel * helloLabel;
    IBOutlet UIView * popViewsR;
    IBOutlet UIView * popViewsG;
    IBOutlet UIView * popViewsB;
    
    IBOutlet UIImageView * avatarView;
    IBOutlet UIImageView * avatarHairView;
    IBOutlet UIImageView * avatarShirtView;
    IBOutlet UIView * avatarBorderView;
    
    IBOutlet UIImageView * trophyView;
    IBOutlet UIImageView * trophyShineView;
    
    PlayerAtribs avatarTopID;
    PlayerAtribs avatarBottomID;
    
    IBOutlet UILabel * playerNameLabel;
    IBOutlet UILabel * playerPointsLabel;
    IBOutlet UIScrollView * achievementsScrollView;
    
    
    
    
    
}
@property (weak) NSTimer *repeatingTimer;
@property (atomic, strong) BBPlayer* playerModel;
//Actions

-(IBAction)updatePressedWithSender:(id)sender;
-(IBAction)magicPressedWithSender:(id)sender;
-(IBAction)rainbowPressedWithSender:(id)sender;
-(IBAction)nextTopPressedWithSender:(id)sender;
-(IBAction)nextBottomPressedWithSender:(id)sender;

-(void)updateAvatarLook;

-(void)trophyAnimation;

-(void)updateRunloop:(UIViewController*) viewController;

@end

