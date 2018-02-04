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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * Method called for tester button press
 * @param sender The button being pressed
 */
-(IBAction)buttonPressedWithSender:(id)sender{
    
    NSString *apiKey         = CLIENT_API_KEY;
    NSString *sharedSecret  = CLIENT_SHARED_SECRET;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:@"https://gameserver-sandbox.herokuapp.com/bennie/client/players/bennie"]];
    
    CryptoUtil *cryptor = [[CryptoUtil alloc] init];
    
    NSDictionary *cryptDict = [cryptor generateHMACWithContent:[@"" dataUsingEncoding:NSUTF8StringEncoding]
                                                  resourcePath:@"/bennie/client/players/bennie"
                                                    httpMethod:@"GET"
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
    
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {
          
          NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
          NSLog(@"Data received: %@", myString);
          
          NSError *jsonError = nil;
          NSDictionary *parsedJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
          if (parsedJSON != nil){
              NSLog(@"POINTS:\n");
              NSLog(@"\n %@", [[parsedJSON objectForKey: @"point_types"][0] objectForKey:@"amount"]);
          }else{
              NSLog(@"JSON object failed to parse");
          }
          
          
      }] resume];
    
}

-(IBAction)button2PressedWithSender:(id)sender{
    NSString *apiKey         = ADMIN_API_KEY;
    NSString *sharedSecret  = ADMIN_SHARED_SECRET;
    
    NSDictionary* sendData = @{@"player"               : @"bennie",
                               @"external_event_id"    : @"Rainbow"
                               };
    NSError *jsonError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:sendData options:0 error:&jsonError];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];

    [request setURL:[NSURL URLWithString:@"https://gameserver-sandbox.herokuapp.com/bennie/admin/player_external_events"]];
    [request setHTTPBody:jsonData];
    [request setHTTPMethod:@"POST"];
    
    CryptoUtil *cryptor = [[CryptoUtil alloc] init];
    
    NSDictionary *cryptDict = [cryptor generateHMACWithContent:jsonData
                                                  resourcePath:@"/bennie/admin/player_external_events"
                                                    httpMethod:@"POST"
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

    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:
      ^(NSData * _Nullable data,
        NSURLResponse * _Nullable response,
        NSError * _Nullable error) {

          NSString *responseStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
          NSLog(@"Data received: %@", responseStr);
      }] resume];
}

@end
