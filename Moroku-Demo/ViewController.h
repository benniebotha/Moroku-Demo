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
    
    PlayerAtribs avatarTopID;
    PlayerAtribs avatarBottomID;
    
    
}

@property (atomic, strong) BBPlayer* playerModel;
//Actions

-(IBAction)updatePressedWithSender:(id)sender;
-(IBAction)magicPressedWithSender:(id)sender;
-(IBAction)rainbowPressedWithSender:(id)sender;
-(IBAction)nextTopPressedWithSender:(id)sender;
-(IBAction)nextBottomPressedWithSender:(id)sender;

-(void)updateAvatarLook;

@end

