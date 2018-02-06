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

/**
 * Enumeration of diferent player attributes tied to the ID of these attributes
 */
typedef enum PlayerAtribs : NSUInteger {
    playerAttrib_top_1 = 1,
    playerAttrib_top_2 = 2,
    playerAttrib_bottom_1 = 3,
    playerAttrib_bottom_2 = 4
} PlayerAtribs;

/**
 * Class representing a player with assosiated functions.
 * The class handeling secure HMAC web requests via CryptoUtil.
 */
@interface BBPlayer : NSObject

/**
 * The player ID
 */
@property (nonatomic) long playerID;
/**
 * The players name
 */
@property (nonatomic, strong) NSString * _Nullable playerName;
/**
 * The players amount of points
 */
@property (nonatomic) long playerPoints;
/**
 * The players top avatar attribute
 */
@property (nonatomic) PlayerAtribs playerTop;
/**
 * The players bottom avatar attribute
 */
@property (nonatomic) PlayerAtribs playerBottom;
/**
 * Array of achievements (BBAchievement objects)
 */
@property (nonatomic) NSArray * _Nullable playerAchievements;

/**
 * Attempts to update the player model by requesting the latest player information from the server.
 * This method is non-blocking and updated information will not be present at end of method execution. (Asyncrinous web request and update made.)
 * @param completionHandler A code block with the parameter error (the URL request error) that executes after the asyncrynous web request has completed. WARNING: The completion handeler runs on the main thread, use GCD if long running tasks will be performed in the completion handler.
 */
-(void) updatePlayerWithCompletionHandler:(void (^_Nullable) (NSError * _Nullable error)) completionHandler;

/**
 * Performes a web request with the required method and secures the message with generated HMAC using the shared secret and relevant API key.
 * This method is non-blocking and updated information will not be present at end of method execution. (Asyncrinous web request and update made.)
 * @param method The restful API http method to use (GET, PUT, POST, DELETE)
 * @param dataDict The JSON data to send as a NSDictionary, use nil for a get request or if no data is needed.
 * @param apiKey The relevant API key for the request
 * @param sharedSecret The shared secret needed for HMAC authenticaton with the server.
 * @param resourcePath The API resource path reletive to the server adress.
 * @param completionHandler The URL request completion handler returning the resulting data and/or error code.
 */
-(void) performSecureWebRequestWithMethod:(NSString *_Nonnull) method data:(NSDictionary* _Nullable)dataDict apiKey:(NSString *_Nonnull)apiKey sharedSecret:(NSString *_Nonnull)sharedSecret resourcePath:(NSString *_Nonnull)resourcePath completionHandler:(void (^_Nullable) (NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)) completionHandler;

/**
 * Sends the spesific secure web request for the event Magic to occur with the server.
 * This method is non-blocking and updated information will not be present at end of method execution. (Asyncrinous web request and update made.)
 * @param completionHandler A code block with the parameter error (the URL request error) that executes after the asyncrynous web request has completed. WARNING: The completion handeler runs on the main thread, use GCD if long running tasks will be performed in the completion handler.
 */
-(void) eventMagicWithCompletionHandler:(void (^_Nullable) (NSError * _Nullable error)) completionHandler;

/**
 * Sends the spesific secure web request for the event Rainbow to occur with the server.
 * This method is non-blocking and updated information will not be present at end of method execution. (Asyncrinous web request and update made.)
 * @param completionHandler A code block with the parameter error (the URL request error) that executes after the asyncrynous web request has completed. WARNING: The completion handeler runs on the main thread, use GCD if long running tasks will be performed in the completion handler.
 */
-(void) achievementRainbowWithCompletionHandler:(void (^_Nullable) (NSError * _Nullable error)) completionHandler;

/**
 * Sends the request to change the avatar top attribute to the server.
 * This method is non-blocking and updated information will not be present at end of method execution. (Asyncrinous web request and update made.)
 * @param completionHandler A code block with the parameter error (the URL request error) that executes after the asyncrynous web request has completed. WARNING: The completion handeler runs on the main thread, use GCD if long running tasks will be performed in the completion handler.
 */
-(void) nextTopWithCompletionHandler:(void (^_Nullable) (NSError * _Nullable error)) completionHandler;

/**
 * Sends the request to change the avatar bottom attribute to the server.
 * This method is non-blocking and updated information will not be present at end of method execution. (Asyncrinous web request and update made.)
 * @param completionHandler A code block with the parameter error (the URL request error) that executes after the asyncrynous web request has completed. WARNING: The completion handeler runs on the main thread, use GCD if long running tasks will be performed in the completion handler.
 */
-(void) nextBottomWithCompletionHandler:(void (^_Nullable) (NSError * _Nullable error)) completionHandler;

@end
