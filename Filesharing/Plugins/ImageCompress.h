//
//  ImageCompress.h
//  videoApp
//
//  Created by Nua i7 on 8/22/14.
//
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>
@interface ImageCompress : CDVPlugin
{
    NSMutableArray *CollectFileValue;
    NSMutableArray *CollectFileValueFiles;
    NSMutableArray *keys;
    NSMutableArray *Values;
    NSString *inwidth;
    NSString *inHeight;
    NSString *inApp_Name;
    NSString *inImageURL;
    NSString *inURLValues;
    NSString *inSendMethod;
    NSString *inArrayValuePass;
    NSArray *CountAllValues;
    NSString *spaceStringRemoved;
    BOOL keyStatusVal;
    CDVInvokedUrlCommand *cmds;
    BOOL keyValues;
    NSURL *url;
}
- (void)imageCompress:(CDVInvokedUrlCommand*)command;
@end
