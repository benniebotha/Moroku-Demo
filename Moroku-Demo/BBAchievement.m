//
//  Achievement.m
//  Moroku-Demo
//
//  Created by Bennie Botha on 2018/02/06.
//  Copyright © 2018 Bennie Botha. All rights reserved.
//

#import "BBAchievement.h"

@implementation BBAchievement

-(id)initWithAchievementID: (long) achievementID achievementName: (NSString * _Nullable)achievementName achievementDescription: (NSString * _Nullable) achievementDescription achievementImageURL: (NSString * _Nullable) achievementImageURL{
    
    self.achievementID = achievementID;
    self.achievementName = achievementName;
    self.achievementDescription = achievementDescription;
    self.achievementImageURL = achievementImageURL;
    
    return self;
}

-(void)printLogAchievement{
    NSLog(@"\nAchievement:\n");
    NSLog(@"Name: %@\nID: %ld\nDescription:\n%@\n\nImageURL:%@\n",self.achievementName, self.achievementID, self.achievementDescription, self.achievementImageURL);
}

@end
