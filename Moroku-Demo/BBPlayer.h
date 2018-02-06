//
//  BBPlayer.h
//  Moroku-Demo
//
//  Created by Bennie Botha on 2018/02/04.
//  Copyright © 2018 Bennie Botha. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "CryptoUtil.h"
#import "BBAchievement.h"

typedef enum PlayerAtribs : NSUInteger {
    playerAttrib_top_1 = 1,
    playerAttrib_top_2 = 2,
    playerAttrib_bottom_1 = 3,
    playerAttrib_bottom_2 = 4
} PlayerAtribs;

@interface BBPlayer : NSObject

@property (nonatomic) long playerID;
@property (nonatomic, strong) NSString * _Nullable playerName;
@property (nonatomic) long playerPoints;
@property (nonatomic) PlayerAtribs playerTop;
@property (nonatomic) PlayerAtribs playerBottom;
@property (nonatomic) NSArray * _Nullable playerAchievements;


-(void) updatePlayerWithCompletionHandler:(void (^_Nullable) (NSError * _Nullable error)) completionHandler;

-(void) performSecureWebRequestWithMethod:(NSString *_Nonnull) method data:(NSDictionary* _Nullable)dataDict apiKey:(NSString *_Nonnull)apiKey sharedSecret:(NSString *_Nonnull)sharedSecret resourcePath:(NSString *_Nonnull)resourcePath completionHandler:(void (^_Nullable) (NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)) completionHandler;

-(void) eventMagicWithCompletionHandler:(void (^_Nullable) (NSError * _Nullable error)) completionHandler;

-(void) achievementRainbowWithCompletionHandler:(void (^_Nullable) (NSError * _Nullable error)) completionHandler;

-(void) nextTopWithCompletionHandler:(void (^_Nullable) (NSError * _Nullable error)) completionHandler;

-(void) nextBottomWithCompletionHandler:(void (^_Nullable) (NSError * _Nullable error)) completionHandler;

@end
