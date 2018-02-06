//
//  Achievement.h
//  Moroku-Demo
//
//  Created by Bennie Botha on 2018/02/06.
//  Copyright © 2018 Bennie Botha. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 * Record class for saving achievements in a controlled and flexable way.
 * Can be expanded upon quickly.
 */
@interface BBAchievement : NSObject

@property (nonatomic) long achievementID;
@property (nonatomic, strong) NSString * _Nullable achievementName;
@property (nonatomic, strong) NSString * _Nullable achievementDescription;
@property (nonatomic, strong) NSString * _Nullable achievementImageURL;

/**
 * Construct HMAC from request and NSData payload
 * @param achievementID The numerical value of the achievement ID
 * @param achievementName The achievement name
 * @param achievementDescription The achievement description
 * @param achievementImageURL The achievements image as a URL web image
 * @return self the initialised BBAchievement opject
 */
-(id)initWithAchievementID: (long) achievementID achievementName: (NSString * _Nullable)achievementName achievementDescription: (NSString * _Nullable) achievementDescription achievementImageURL: (NSString * _Nullable) achievementImageURL;

/**
 * Uses NSLog to output the parameters of the achievment.
 */
-(void)printLogAchievement;

@end
