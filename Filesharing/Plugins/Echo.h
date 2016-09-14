//
//  Echo.h
//  videoApp
//
//  Created by Nua Trans Media on 7/23/14.
//
//

#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>
#import <MediaPlayer/MediaPlayer.h>
@interface Echo : CDVPlugin
{
    MPMoviePlayerController *controller; //Movie Player
    NSData *imgData;
    UIImage *ima;
    //Data  Image Objects
    
    
    NSString *imagesValues;
    BOOL keyValues;
    
    CDVInvokedUrlCommand *cmds;
}
- (void)echo:(CDVInvokedUrlCommand*)command;
@property (nonatomic,strong) MPMoviePlayerController* mc; //Movie Player
@end
