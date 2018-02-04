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

@interface ViewController : UIViewController{

//Outlets
IBOutlet UIButton * testerButton;
}
//Actions
-(IBAction)buttonPressedWithSender:(id)sender;
-(IBAction)button2PressedWithSender:(id)sender;

@end

