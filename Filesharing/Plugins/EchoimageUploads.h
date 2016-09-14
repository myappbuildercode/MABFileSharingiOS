//
//  EchoimageUploads.h
//  videoApp
//
//  Created by Nua i7 on 7/31/14.
//
//
#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>
@interface EchoimageUploads : CDVPlugin
{
    NSString*title;
    NSString*api_Key;
    NSString*button_Id;
    NSString* echo1;
    NSString*thumbnailUrl;
    NSURL *moveUrl;
    NSMutableArray *layValue;
    CDVInvokedUrlCommand *cmds;
    BOOL keyValues;
}
- (void)echoimageUploads:(CDVInvokedUrlCommand*)command;
@end
