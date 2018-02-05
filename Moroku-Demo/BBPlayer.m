//
//  BBPlayer.m
//  Moroku-Demo
//
//  Created by Bennie Botha on 2018/02/04.
//  Copyright © 2018 Bennie Botha. All rights reserved.
//

#import "BBPlayer.h"

@implementation BBPlayer

-(void) updatePlayerWithCompletionHandler:(void (^_Nullable) (NSError * _Nullable error)) completionHandler{
    NSLog(@"\nPlayer update request starting. \n");
    NSString * tenantName = TENANT_NAME
    NSString * resourcePath = [NSString stringWithFormat:@"/%@/client/players/%@", tenantName, tenantName]; //@"/bennie/client/players/bennie"
    
    [self performSecureWebRequestWithMethod:@"GET" data:nil apiKey:CLIENT_API_KEY sharedSecret:CLIENT_SHARED_SECRET resourcePath:resourcePath completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Data received: %@", myString);
        
        NSError *jsonError = nil;
        NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (parsedJSON != nil){
            
            [self setPlayerID:[[parsedJSON objectForKey:@"id"] longValue]];
            [self setPlayerName:[parsedJSON objectForKey:@"nickname"]];
            [self setPlayerPoints:[[[parsedJSON objectForKey: @"point_types"][0] objectForKey:@"amount"] longValue]];
            [self setPlayerTop:[[[parsedJSON objectForKey:@"avatar"] objectForKey:@"Top"] longValue]];
            [self setPlayerBottom:[[[parsedJSON objectForKey:@"avatar"] objectForKey:@"Bottom"] longValue]];
            
            NSLog(@"\n\n RESULTS");
            NSLog(@"\nPlayer ID: %ld \n",self.playerID);
            NSLog(@"\nPlayer Name: %@ \n",self.playerName);
            NSLog(@"\nPlayer Points: %ld \n",self.playerPoints);
            NSLog(@"\nPlayer TopID: %ld \n",self.playerTop);
            NSLog(@"\nPlayer BottomID: %ld \n",self.playerBottom);
            
        }else{
            NSLog(@"JSON object failed to parse");
        }
        
        NSLog(@"\nAsync request for update complete \n");
        if (completionHandler != nil){
            //completionHandler(error);
            if ([NSThread isMainThread])
            {
                completionHandler(error);
            }
            else
            {
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    completionHandler(error);
                });
            }
        }
    }];
}

-(void) performSecureWebRequestWithMethod:(NSString *_Nonnull) method data:(NSDictionary* _Nullable)dataDict apiKey:(NSString *_Nonnull)apiKey sharedSecret:(NSString *_Nonnull)sharedSecret resourcePath:(NSString *_Nonnull)resourcePath completionHandler:(void (^_Nullable) (NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)) completionHandler{
    
    NSData *jsonData = nil;
    NSError *jsonError = nil;
    if (dataDict != nil){
        jsonData = [NSJSONSerialization dataWithJSONObject:dataDict options:0 error:&jsonError];
    }else{
        jsonData = [@"" dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    [request setURL:[NSURL URLWithString:[FULL_GAME_SYSTEM_URL stringByAppendingString:resourcePath]]];
    [request setHTTPBody:jsonData];
    [request setHTTPMethod:method];
    
    CryptoUtil *cryptor = [[CryptoUtil alloc] init];
    
    NSDictionary *cryptDict = [cryptor generateHMACWithContent:jsonData
                                                  resourcePath:resourcePath
                                                    httpMethod:method
                                                     secretKey:sharedSecret];
    
    // Build HTTP request for API
    // Set Content-MD5: header to          [cryptDict objectForKey:kBase64Md5Content]
    // Set Authorization: header to          MY_API_KEY:[cryptDict objectForKey:kHmacSha1]
    // Set Date: header to                     [cryptDict objectForKey:kUtcDate]
    
    [request setValue:[cryptDict objectForKey:kBase64Md5Content] forHTTPHeaderField:@"Content-MD5"];
    [request setValue:[[apiKey  stringByAppendingString: @":"]
                       stringByAppendingString:[cryptDict objectForKey:kHmacSha1]]
   forHTTPHeaderField:@"Authorization"];
    [request setValue:[cryptDict objectForKey:kUtcDate] forHTTPHeaderField:@"Date"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler: completionHandler] resume];
}

-(void) eventMagicWithCompletionHandler:(void (^_Nullable) (NSError * _Nullable error)) completionHandler{
    NSDictionary* sendData = @{@"player"               : self.playerName,
                               @"external_event_id"    : @"Magic"
                               };

    
    [self performSecureWebRequestWithMethod:@"POST" data:sendData apiKey:ADMIN_API_KEY sharedSecret:ADMIN_SHARED_SECRET resourcePath:@"/bennie/admin/player_external_events" completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Data received: %@", myString);
        
        if (completionHandler != nil){
            //completionHandler(error);
            if ([NSThread isMainThread])
            {
                completionHandler(error);
            }
            else
            {
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    completionHandler(error);
                });
            }
        }
    }];
}

-(void) achievementRainbowWithCompletionHandler:(void (^_Nullable) (NSError * _Nullable error)) completionHandler{
    NSDictionary* sendData = @{@"player"               : self.playerName,
                               @"external_event_id"    : @"Rainbow"
                               };
    
    
    [self performSecureWebRequestWithMethod:@"POST" data:sendData apiKey:ADMIN_API_KEY sharedSecret:ADMIN_SHARED_SECRET resourcePath:@"/bennie/admin/player_external_events" completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Data received: %@", myString);
        
        if (completionHandler != nil){
            //completionHandler(error);
            if ([NSThread isMainThread])
            {
                completionHandler(error);
            }
            else
            {
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    completionHandler(error);
                });
            }
        }
    }];
}

-(void) nextTopWithCompletionHandler:(void (^_Nullable) (NSError * _Nullable error)) completionHandler{
    NSString * tenantName = TENANT_NAME
    NSString * resourcePath = [NSString stringWithFormat:@"/%@/client/players/%@", tenantName, tenantName];
    
    int newTop = playerAttrib_top_1;
    if (self.playerTop == playerAttrib_top_1){
        newTop = playerAttrib_top_2;
    }
    
    NSDictionary* sendData = @{@"avatar"    : @{
                                                @"Top": [NSNumber numberWithInteger:newTop]
                                                }
                               };
    
    
    [self performSecureWebRequestWithMethod:@"PUT" data:sendData apiKey:CLIENT_API_KEY sharedSecret:CLIENT_SHARED_SECRET resourcePath:resourcePath completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Data received: %@", myString);
        
        if (completionHandler != nil){
            //completionHandler(error);
            if ([NSThread isMainThread])
            {
                completionHandler(error);
            }
            else
            {
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    completionHandler(error);
                });
            }
        }
    }];
}

-(void) nextBottomWithCompletionHandler:(void (^_Nullable) (NSError * _Nullable error)) completionHandler{
    NSString * tenantName = TENANT_NAME
    NSString * resourcePath = [NSString stringWithFormat:@"/%@/client/players/%@", tenantName, tenantName];
    
    int newBottom = playerAttrib_bottom_1;
    if (self.playerBottom == playerAttrib_bottom_1){
        newBottom = playerAttrib_bottom_2;
    }

    NSDictionary* sendData = @{@"avatar"    : @{
                                                @"Bottom": [NSNumber numberWithInteger:newBottom]
                                                }
                               };
    
    
    [self performSecureWebRequestWithMethod:@"PUT" data:sendData apiKey:CLIENT_API_KEY sharedSecret:CLIENT_SHARED_SECRET resourcePath:resourcePath completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Data received: %@", myString);
        
        if (completionHandler != nil){
            if ([NSThread isMainThread])
            {
                completionHandler(error);
            }
            else
            {
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    completionHandler(error);
                });
            }
            
        }
    }];
}


@end
