//
//  EchoimageUploads.m
//  videoApp
//
//  Created by Nua i7 on 7/31/14.
//
//

#import "EchoimageUploads.h"
#define radian 90
@implementation EchoimageUploads
- (void)echoimageUploads:(CDVInvokedUrlCommand*)command
{
    
    NSString* echo=[command.arguments objectAtIndex:2];

    api_Key=[command.arguments objectAtIndex:0];
    button_Id=[command.arguments objectAtIndex:1];
    //NSString *imageSendings = [command.arguments objectAtIndex:3];
    keyValues = YES;
    cmds = command;
     layValue = [[NSMutableArray alloc]init];
    if ([echo isEqualToString:@"Image"])
    {
        
        NSString *folderNameUiweb;
        
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
            NSLog(@"ValueStrs second values:%@",echo);
            NSString *string = [NSString stringWithFormat:@"%@",contentFile[i]];
            if ([string rangeOfString:@"UIWebFileUpload"].location == NSNotFound)
            {
                NSLog(@"string does not contain bla");
            }
            else
            {
                [layValue addObject:contentFile[i]];
                folderNameUiweb = [NSString stringWithFormat:@"%@",contentFile[i]];
            }
        }
        NSString *moveName = [NSString stringWithFormat:@"/%@%@",folderNameUiweb,@"/image.jpg"];
        NSString *documentsDirectoryr = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
        NSString *strpathsValues = [NSString stringWithFormat:@"%@%@",documentsDirectoryr,moveName];
        NSLog(@"strpathsValues:%@",strpathsValues);
        NSData *data = [NSData dataWithContentsOfFile:strpathsValues];
        UIImage  *ima = [UIImage imageWithData:data];
        
        
        
        CGSize originalSize = ima.size;
        CGSize finalSize = CGSizeMake(150, 225);
        
        CGRect cgRect = [[UIScreen mainScreen]bounds];
        CGSize size = cgRect.size;
        CGSize constraint = CGSizeMake(200,400);
       /* UIGraphicsBeginImageContext(constraint);
        [ima drawInRect:CGRectMake(0, 0, size.width-150, size.height+100)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();*/
        
        
        //UIImage *image = [UIImage imageWithCGImage:ima.CGImage scale:1.0 orientation:UIImageOrientationUp];
        UIImage *image = ima;
        NSLog(@"Image Size width:%.f",image.size.width);
        NSLog(@"Image Size height:%.f",image.size.height);
        double img_width = image.size.width;
        double img_height = image.size.height;
        if(img_width>640||img_height>640)
        {
            
            img_height = ((640 * img_height)/img_width);
            img_width = 640;
            NSLog(@" height : %f",img_height);
            NSLog(@" width : %f",img_width);
           /* double img_Two_Width = img_width/2;
            double img_Two_Height = img_height/2;
            if(img_Two_Width>640||img_Two_Height>640)
            {
                img_width = 640;
                img_height = (640)(;
            }
            else
            {
                if(img_width>640)
                {
                    img_width = img_width/2;
                }
                else if(img_height>640)
                {
                    img_height = img_height/2;
                }
                
            }*/
        }
        
        UIImage *tempImage = nil;
        CGSize targetSize = CGSizeMake(img_width,img_height);
        UIGraphicsBeginImageContext(targetSize);
        
        CGRect thumbnailRect = CGRectMake(0, 0, 0, 0);
        thumbnailRect.origin = CGPointMake(0.0,0.0);
        thumbnailRect.size.width = targetSize.width;
        thumbnailRect.size.height = targetSize.height;
        
        [image drawInRect:thumbnailRect];
        
        tempImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        
        
        
        
        
        
        
        NSData* datas = UIImageJPEGRepresentation(tempImage,0.45);
        [self myappBuilderImageUpload:datas];

    }
    else
    {
        NSLog(@"hello Boss");
        NSString *folderNameUiweb;
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
            NSLog(@"ValueStrs second values:%@",echo);
            NSString *string = [NSString stringWithFormat:@"%@",contentFile[i]];
            if ([string rangeOfString:@"UIWebFileUpload"].location == NSNotFound)
            {
                NSLog(@"string does not contain bla");
            }
            else
            {
                [layValue addObject:contentFile[i]];
                folderNameUiweb = [NSString stringWithFormat:@"%@",contentFile[i]];
            }
        }
        for (int i=0; i<[layValue count]; i++)
        {
            
            NSLog(@"Image:%@",[layValue objectAtIndex:i]);
            
            [self removeTempFolder:[layValue objectAtIndex:i]];
        }
    }
}
-(void)myappBuilderImageUpload :(NSData *)imageData
{
    NSMutableURLRequest *request;
    request= [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://build.myappbuilder.com/api/elements/images.json?api_key=%@&id=%@",api_Key,button_Id]]];
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
    [postbody appendData:imageData];
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
            NSError* error;
            NSDictionary* json = [NSJSONSerialization
                                  JSONObjectWithData:responseData
                                  
                                  options:kNilOptions
                                  error:&error];
            NSArray* latesturl = [json objectForKey:@"url"];
            NSLog(@"loans: %@", latesturl);
            NSString *urlString = [NSString stringWithFormat:@"%@",latesturl];
            if (responseString.length!=0)
            {
                if (responseString.length!=0)
                {
                    CDVPluginResult *result;
                    if (keyValues==YES)
                    {
                        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:urlString];
                    }
                    else
                    {
                        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Error"];
                    }
                    [self.commandDelegate sendPluginResult:result callbackId:cmds.callbackId];
                    
                }
                keyValues = NO;

                for (int i=0; i<[layValue count]; i++)
                {
                    
                    NSLog(@"Image:%@",[layValue objectAtIndex:i]);
                    
                    [self removeTempFolder:[layValue objectAtIndex:i]];
                }
            
            }
            
           
        });
    });

}


-(void)removeTempFolder:(NSString *)subFolderNames
{
    
    NSLog(@"Saravanakumar");
    
    NSString *documentsDirectoryPath = [NSHomeDirectory()  stringByAppendingPathComponent:@"tmp"];
    
    NSString *folderName = [NSString stringWithFormat:@"%@/%@",documentsDirectoryPath,subFolderNames];
    
    NSLog(@"DeletePathName:%@",folderName);
    
    // Delete the file using NSFileManager
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:folderName error:nil];
}




@end
