//
//  Achievement.h
//  Moroku-Demo
//
//  Created by Bennie Botha on 2018/02/06.
//  Copyright © 2018 Bennie Botha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBAchievement : NSObject

@property (nonatomic) long achievementID;
@property (nonatomic, strong) NSString * _Nullable achievementName;
@property (nonatomic, strong) NSString * _Nullable achievementDescription;
@property (nonatomic, strong) NSString * _Nullable achievementImageURL;

-(id)initWithAchievementID: (long) achievementID achievementName: (NSString * _Nullable)achievementName achievementDescription: (NSString * _Nullable) achievementDescription achievementImageURL: (NSString * _Nullable) achievementImageURL;

-(void)printLogAchievement;

@end
