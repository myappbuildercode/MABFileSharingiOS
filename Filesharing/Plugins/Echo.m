//
//  Echo.m
//  videoApp
//
//  Created by Nua Trans Media on 7/23/14.
//
//

#import "Echo.h"
#import <Cordova/CDV.h>
#import "AssetsLibrary/ALAssetsLibrary.h"
#import "AssetsLibrary/ALAssetsFilter.h"
#import "AssetsLibrary/ALAssetsGroup.h"
#import "AssetsLibrary/ALAsset.h"
#import "AssetsLibrary/ALAssetRepresentation.h"
//#import <Cordova/NSArray+Comparisons.h>
//#import <Cordova/NSData+Base64.h>
//#import <Cordova/NSDictionary+Extensions.h>
//#import <Cordova/CDV.h>
#import <AVFoundation/AVFoundation.h>
@interface Echo ()

@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic, strong) NSMutableArray *assets;
@property int assetsCount;

@end


@implementation Echo
- (void)echo:(CDVInvokedUrlCommand*)command
{
    NSString* echo = [command.arguments objectAtIndex:0];
    
    cmds = command;
    if (echo.length!=0)
    {
    keyValues = YES;
    NSFileManager *filemanager=[NSFileManager defaultManager];
    NSError *errors;
    NSString *documentsDir= [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
    if (![[NSFileManager defaultManager ]fileExistsAtPath:documentsDir])
    {
   [[NSFileManager defaultManager]createDirectoryAtPath:documentsDir withIntermediateDirectories:NO attributes:nil error:&errors];
    }
    NSString *fullPaths = [NSString stringWithFormat:@"%@",documentsDir];
    NSArray *contentFile = [filemanager contentsOfDirectoryAtPath:fullPaths error:&errors];
    for (int i=0 ;i<[contentFile count]; i++)
    {
        NSLog(@"Answer:%@",contentFile[i]);
        if([echo isEqualToString:contentFile[i]])
        {
            NSLog(@"ValueStrs second values:%@",echo);
        }
        
    }
    //NSLog(@"Answert lastPath :%@",[contentFile lastObject]);
    //NSLog(@"Image Echo:%@",echo);
    NSArray *strs = [echo componentsSeparatedByString:@"fakepath"];
    //NSLog(@"ValueStrs :%@",strs[1]);
    NSString *stt = [NSString stringWithFormat:@"%@",strs[1]];
    NSArray *valueTrim = [stt componentsSeparatedByString:@"trim"];
    NSString* newString = [stt stringByReplacingOccurrencesOfString:@"\'" withString:@" "];
    //NSLog(@"ValueStrs Slash Screen :%@",valueTrim[1]);
    NSString *moveNameAppends = @"/trim";
    NSString *moveName = [NSString stringWithFormat:@"%@%@",moveNameAppends,valueTrim[1]];
    //NSLog(@"MoveName:%@",moveName);
    NSString *StrSplitvalues = [NSString stringWithFormat:@"%@",strs[1]];
     NSArray *strsSlash = [StrSplitvalues componentsSeparatedByString:@"\""];
    NSLog(@"ValueStrs Sen ones :%@",strsSlash[0]);
    NSString *documentsDirectoryr = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
    //NSString *foldersName = @"/UIWebFileUpload-TbGtW0kb";
    NSString *strpathsValues = [NSString stringWithFormat:@"%@%@",documentsDirectoryr,moveName];
    NSString *foldersName = [NSString stringWithFormat:@"/%@",[contentFile lastObject]];
    NSURL *moveUrl= [NSURL fileURLWithPath:strpathsValues];
    //NSLog(@"Paths Liomns:%@",moveUrl);
    [self playMovie:moveUrl];
    [self performSelector:@selector(imageScreenShotVideos) withObject:nil afterDelay:5];
 }
    //[self myappbuilder:data];
    
}
- (void) playMovie:(NSURL *)vUrl
{
    
    
   // Or any other appropriate encoding
    controller  = [[MPMoviePlayerController alloc] initWithContentURL:vUrl];
    controller.movieSourceType = MPMovieSourceTypeFile;
    [controller setShouldAutoplay:YES];
    self.mc = controller; //Super important
    controller.view.frame = CGRectMake (0, 0,320,400); //Set the size
    //[self.view addSubview:controller.view]; //Present Video Player in Views
    
  
    [controller play]; //Start playi
    
}
-(void)imageScreenShotVideos
{
    UIImage *thumbnail = [controller thumbnailImageAtTime:2.0 timeOption:MPMovieTimeOptionNearestKeyFrame];
    //NSLog(@"Images :%@",imagesValues);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:@"test.png"];
    NSString *documentDirectory = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
    NSString *logoImagePath = [NSString stringWithFormat:@"%@/%@", documentDirectory, @"image.png"];
    //NSLog(@"Image Path Herre:%@",logoImagePath);
    UIImage *logoImage = [UIImage imageWithContentsOfFile:logoImagePath];
    NSData* data = UIImagePNGRepresentation(thumbnail);
    [self myappbuilder:data];
    [controller stop];
    [data writeToFile:path atomically:YES];
}
-(void)myappbuilder :(NSData *)img
{
    //Here From Image Data get From local dir
    NSArray *directoryPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *imagePath =  [directoryPath objectAtIndex:0];
    imagePath= [imagePath stringByAppendingPathComponent:@"test.png"];
    NSData *data = [NSData dataWithContentsOfFile:imagePath];
       NSMutableURLRequest *request;
    request= [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://build.myappbuilder.com/api/elements/images.json?api_key=%@&id=%@", @"d4b2e8f5473bd5023797436ce9556620",@"2225"]]];
    [request setHTTPMethod:@"POST"];
    NSString *stringBoundary = @"0xKhTmLbOuNdArY---This_Is_ThE_BoUnDaRyy---pqo";
    // add header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@;",stringBoundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    // add image data
    NSMutableData *postbody = [NSMutableData data];
    [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n",stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"image\"; filename=\"%@\"\r\n",@"fill.png"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[@"Content-Type:image/png\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:img];
    [postbody appendData:[[NSString stringWithFormat:@"--%@--\r\n",stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postbody];
    
    
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //this will start the image loading in bg
    dispatch_async(concurrentQueue, ^{
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
         dispatch_async(dispatch_get_main_queue(), ^{
    NSLog(@"just sent request");
    NSString *responseString = [[NSString alloc] initWithBytes:[responseData bytes]
                                                        length:[responseData length]
                                            encoding:NSUTF8StringEncoding];
    NSLog(@"Data Receied%@",responseString);
    
    CDVPluginResult *result;
    
    if (keyValues==YES) {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:responseString];
        
    }
    else
    {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Error"];
    
    }
    [self.commandDelegate sendPluginResult:result callbackId:cmds.callbackId];
    keyValues = NO;
         });
    });
    
}


@end
