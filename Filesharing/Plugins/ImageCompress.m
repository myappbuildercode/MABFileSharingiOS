//
//  ImageCompress.m
//  videoApp
//
//  ☀️Om Siva☀️
//  ☀️Create By Saravanakumar☀️
//


#import "ImageCompress.h"

@implementation ImageCompress
- (void)imageCompress:(CDVInvokedUrlCommand*)command
{
    
    
    
    
    CollectFileValue = [[NSMutableArray alloc]init];
    CollectFileValueFiles = [[NSMutableArray alloc]init];
    keys = [[NSMutableArray alloc]init];
    Values = [[NSMutableArray alloc]init];
    cmds = command;
    keyValues = YES;
    
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
        NSString *string = [NSString stringWithFormat:@"%@",contentFile[i]];
        if ([string rangeOfString:@"UIWebFileUpload"].location == NSNotFound)
        {
            NSLog(@"string does not contain bla");
        }
        else
        {
            [CollectFileValue addObject:contentFile[i]];
            folderNameUiweb = [NSString stringWithFormat:@"%@",contentFile[i]];
        }
    }
    for (int i=0; i<[CollectFileValue count]; i++)
    {
        
        NSLog(@"Image-----------------))))---->>>>:%@",[CollectFileValue objectAtIndex:i]);
        
    }
    
    inwidth = [NSString stringWithFormat:@"%@",[command.arguments objectAtIndex:0]];
    
    NSLog(@"WIDTH:%@",inwidth);
    if(inwidth.length!=0)
    {
        inHeight = [NSString stringWithFormat:@"%@",[command.arguments objectAtIndex:1]];
        inApp_Name = [NSString stringWithFormat:@"%@",[command.arguments objectAtIndex:2]];
        inImageURL = [NSString stringWithFormat:@"%@",[command.arguments objectAtIndex:3]];
        inURLValues = [NSString stringWithFormat:@"%@",[command.arguments objectAtIndex:4]];
        inSendMethod = [NSString stringWithFormat:@"%@",[command.arguments objectAtIndex:5]];
        inArrayValuePass = [NSString stringWithFormat:@"%@",[command.arguments objectAtIndex:6]];
    }
    else
    {
        NSLog(@"THingLoad");
        
        NSString *folderNameUiweb;
        NSFileManager *filemanager=[NSFileManager defaultManager];
        NSError *errors;
        NSString *documentsDir= [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
        if (![[NSFileManager defaultManager ]fileExistsAtPath:documentsDir])
        {
            [[NSFileManager defaultManager]createDirectoryAtPath:documentsDir withIntermediateDirectories:NO attributes:nil error:&errors];
        }
        //NSString *fullPaths = [NSString stringWithFormat:@"%@",documentsDir];
        NSString *fullPaths = [NSString stringWithFormat:@"%@",documentsDir];
        NSLog(@"Name Images:%@",fullPaths);
        NSArray *contentFile = [filemanager contentsOfDirectoryAtPath:fullPaths error:&errors];
        for (int i=0 ;i<[contentFile count]; i++)
        {
            NSLog(@"Answer:%@",contentFile[i]);
            //            NSLog(@"ValueStrs second values:%@",echo);
            NSString *string = [NSString stringWithFormat:@"%@",contentFile[i]];
            if ([string rangeOfString:@"UIWebFileUpload"].location == NSNotFound)
            {
                NSLog(@"string does not contain bla");
            }
            else
            {
                [CollectFileValue addObject:contentFile[i]];
                folderNameUiweb = [NSString stringWithFormat:@"%@",contentFile[i]];
            }
        }
        for (int i=0; i<[CollectFileValue count]; i++)
        {
            NSLog(@"Image:%@",[CollectFileValue objectAtIndex:i]);
            [self removeTempFolder:[CollectFileValue objectAtIndex:i]];
        }
        
    }
    NSArray *removedoubleCo = [inArrayValuePass componentsSeparatedByString:@"\""];
    NSLog(@"Fix It:%@",removedoubleCo[1]);
    
    
    NSArray *FirstBrackets = [inArrayValuePass componentsSeparatedByString:@"{"];
    NSArray *SecondBrackets = [FirstBrackets[1] componentsSeparatedByString:@"}"];
    CountAllValues = [SecondBrackets[0] componentsSeparatedByString:@";"];
    for (int i=0; i<[CountAllValues count]; i++)
    {
        [CollectFileValueFiles addObject:CountAllValues[i]];
    }
    NSLog(@"CountAllVal:%d",[CountAllValues count]-1);
    
    for (int j=0;j<[CollectFileValueFiles count]-1; j++)
    {
        
        NSString *vals = [NSString stringWithFormat:@"%@",CollectFileValueFiles[j]];
        NSArray *collectsData = [vals componentsSeparatedByString:@"="];
        
        NSLog(@"Key:%@",collectsData[0]);
        NSLog(@"Values:%@",collectsData[1]);
        
        //KEYS
        [keys addObject:collectsData[0]];
        //Values
        [Values addObject:collectsData[1]];
    }
    NSLog(@"First Values:%@",inwidth);
    NSLog(@"Second Values:%@",inHeight);
    NSLog(@"Thrid values:%@",inApp_Name);
    NSLog(@"Four Values:%@",inImageURL);
    NSLog(@"Five Values:%@",inURLValues);
    NSLog(@"Six Values:%@",inSendMethod);
    NSLog(@"Seven values:%@",inArrayValuePass);
    
    
    if (inwidth.length!=0)
    {
        
        NSArray *photoName = [inImageURL componentsSeparatedByString:@"tmp/"];
        
        NSLog(@"PhotoName:%@",photoName[1]);
        
        NSString *moveName = [NSString stringWithFormat:@"/%@",photoName[1]];
        NSString *documentsDirectoryr = [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"];
        NSString *strpathsValues = [NSString stringWithFormat:@"%@%@",documentsDirectoryr,moveName];
        NSLog(@"strpathsValues:%@",strpathsValues);
        NSData *data = [NSData dataWithContentsOfFile:strpathsValues];
        UIImage  *ima = [UIImage imageWithData:data];
        UIImage *image = ima;
        
        
        UIImage *tempImage = nil;
        CGSize targetSize = CGSizeMake([inwidth integerValue],[inHeight integerValue]);
        UIGraphicsBeginImageContext(targetSize);
        CGRect thumbnailRect = CGRectMake(0, 0, 0, 0);
        thumbnailRect.origin = CGPointMake(0.0,0.0);
        thumbnailRect.size.width  = targetSize.width;
        thumbnailRect.size.height = targetSize.height;
        [image drawInRect:thumbnailRect];
        tempImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIImage *imageg = [UIImage imageWithCGImage:tempImage.CGImage scale:1.0 orientation:UIImageOrientationUp];
        NSData* datas = UIImageJPEGRepresentation(imageg,0.3);
        [self myappBuilderImageUpload:datas];
    }
    else
    {
        
        
    }
}
-(void)myappBuilderImageUpload :(NSData *)imageData
{
    NSMutableURLRequest *request;
    request= [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    
    NSString *getCountFrominArrayValues = [NSString stringWithFormat:@"%d",[CollectFileValueFiles count]-1];
    NSString *urlValueGetHere;
    NSString *nospacestring;
    
    if([getCountFrominArrayValues isEqualToString:@"2"])
    {
        NSArray *keySpaceValue = [keys[1] componentsSeparatedByString:@"\n"];
        NSArray *keyRemove = [keys[0] componentsSeparatedByString:@"\""];
        NSArray *valueTitles_Array = [Values[1] componentsSeparatedByString:@"\""];
        NSString *valueTitles;
        if(valueTitles_Array.count>1)
        {
            valueTitles = [valueTitles_Array[1] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        }
        else
        {
            valueTitles = [Values[1] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        }
        NSString *valueIdChecking = [NSString stringWithFormat:@"%@",keySpaceValue[1]];
        NSLog(@"Values Checking:%@",valueIdChecking);
        NSString *FinalValues;
        
        if(![valueIdChecking isEqualToString:@"title"])
        {
            /*NSArray *notTitle_Array = [Values[1] componentsSeparatedByString:@"\n"];
             NSString *valRefine =[notTitle_Array[0] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
             FinalValues = [NSString stringWithFormat:@"%@", valRefine];*/
            
            
            NSArray *notTitle_Array = [Values[1] componentsSeparatedByString:@"\n"];
            NSArray *notTitle_Array_remove = [notTitle_Array[0] componentsSeparatedByString:@"\""];
            NSString *valRefine;
            
            if(notTitle_Array_remove.count>1)
            {
                valRefine = [notTitle_Array_remove[1] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
            }
            else
            {
                valRefine = [NSString stringWithFormat:@"%@",notTitle_Array[0]];
            }
            
            FinalValues = [NSString stringWithFormat:@"%@", valRefine];
            
        }
        else
        {
            FinalValues = [NSString stringWithFormat:@"%@",valueTitles];
        }
        
        
        
        
        
        
        
        urlValueGetHere = [NSString stringWithFormat:@"%@%@=%@&%@=%@",inURLValues,keyRemove[1],Values[0],keySpaceValue[1],FinalValues];
        
        NSArray* words = [urlValueGetHere componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceCharacterSet]];
        nospacestring = [words componentsJoinedByString:@""];
        NSArray *wordsRemoveSpace = [nospacestring componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        spaceStringRemoved  = [wordsRemoveSpace componentsJoinedByString:@""];
        NSLog(@"URL Values 2:%@",spaceStringRemoved);
        
        
        
        
    }
    else if([getCountFrominArrayValues isEqualToString:@"3"])
    {
        
        
        /*  NSArray *desc_RemoveSpace_Array = [Values[1] componentsSeparatedByString:@"\n"];
         NSString *descriptionValues = [NSString stringWithFormat:@"%@",desc_RemoveSpace_Array[0]];
         NSString *descriptionKeys =  [NSString stringWithFormat:@"%@",keys[1]];
         NSArray *keySpaceValue = [keys[2] componentsSeparatedByString:@"\n"];
         NSArray *keyRemove = [keys[0] componentsSeparatedByString:@"\""];
         
         //NSArray *valueTitles_RemoveSpace_Array = []
         NSArray *valueTitles_Array  = [Values[2] componentsSeparatedByString:@"\""];
         NSArray *descriptionArray = [descriptionValues componentsSeparatedByString:@"\""];
         NSString *valueTitles;
         NSString *descriptio_String;
         if(valueTitles_Array.count>1)
         {
         valueTitles = [NSString stringWithFormat:@"%@",valueTitles_Array[1]];
         }
         else
         {
         
         valueTitles = [Values[2] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
         }
         
         if(descriptionArray.count>1)
         {
         descriptio_String = [NSString stringWithFormat:@"%@",descriptionArray[1]];
         
         }
         else
         {
         descriptio_String = [NSString stringWithFormat:@"%@",descriptionValues];
         
         
         }*/
        
        
        NSString *api_Keys = [NSString stringWithFormat:@"%@",keys[0]];
        NSString *api_values = [NSString stringWithFormat:@"%@",Values[0]];
        
        
        NSString *titles_keys = [NSString stringWithFormat:@"%@",keys[2]];
        NSString *titles_Values = [NSString stringWithFormat:@"%@",Values[2]];
        //Description
        
        NSString *description_keys = [NSString stringWithFormat:@"%@",keys[1]];
        NSString *description_Values = [NSString stringWithFormat:@"%@",Values[1]];
        
        
        // Create character set with specified characters
        NSMutableCharacterSet *characterSet =
        [NSMutableCharacterSet characterSetWithCharactersInString:@"()\"\n" ""];
        NSMutableCharacterSet *characterSetDescription =
        [NSMutableCharacterSet characterSetWithCharactersInString:@"()\"\n" "<p></p>"];

        
        // Build array of components using specified characters as separtors
        NSArray *arrayOfComponents_Keys = [api_Keys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_Values = [api_values componentsSeparatedByCharactersInSet:characterSet];
        
        // Create string from the array components
        NSString *FInal_Api_Key = [arrayOfComponents_Keys componentsJoinedByString:@""];
        NSString *FInal_Api_Values =[arrayOfComponents_Values componentsJoinedByString:@""];
        
        
        NSArray *arrayOfComponents_TitleKeys = [titles_keys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_TitleValues = [titles_Values componentsSeparatedByCharactersInSet:characterSet];
        
        // Create string from the array components
        NSString *FInal_titles_keys = [arrayOfComponents_TitleKeys componentsJoinedByString:@""];
        NSString *FInal_titles_Values =[arrayOfComponents_TitleValues componentsJoinedByString:@""];
        
        
        NSArray *arrayOfComponents_descriptionKeys = [description_keys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_descriptionValues = [description_Values componentsSeparatedByCharactersInSet:characterSetDescription];
        // Create string from the array components
        NSString *description_titles_keys = [arrayOfComponents_descriptionKeys componentsJoinedByString:@""];
        NSString *description_titles_Values =[arrayOfComponents_descriptionValues componentsJoinedByString:@""];
        
        
        urlValueGetHere = [NSString stringWithFormat:@"%@%@=%@&%@=%@&%@=%@",inURLValues,FInal_Api_Key,FInal_Api_Values,FInal_titles_keys,FInal_titles_Values,description_titles_keys,description_titles_Values];
        NSArray* words = [urlValueGetHere componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceCharacterSet]];
        nospacestring = [words componentsJoinedByString:@""];
        NSArray *wordsRemoveSpace = [nospacestring componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        spaceStringRemoved  = [wordsRemoveSpace componentsJoinedByString:@""];
        NSLog(@"URL Values 3:%@",spaceStringRemoved);
    }
    else if([getCountFrominArrayValues isEqualToString:@"4"])
    {
        //Titles
        /* NSString *descriptionValues = [NSString stringWithFormat:@"%@",Values[2]];
         NSString *descriptionKeys =  [NSString stringWithFormat:@"%@",keys[2]];
         //Submenu
         
         NSArray *submenuValuesRemoveSpace = [Values[1] componentsSeparatedByString:@"\n"];
         NSString *submenuValues = [NSString stringWithFormat:@"%@",submenuValuesRemoveSpace[0]];
         //NSString *submenuKeys = [NSString stringWithFormat:@"%@",keys[1]];
         
         NSArray *keySpaceValue = [keys[3] componentsSeparatedByString:@"\n"];
         NSArray *keyRemove = [keys[0] componentsSeparatedByString:@"\""];
         NSArray *keyBar = [keys[1] componentsSeparatedByString:@"\""];
         
         // NSString * newReplacedString = [descriptionValues stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
         
         NSArray *descriptionArray = [descriptionValues componentsSeparatedByString:@"\""];
         NSArray *titles_Array = [Values[3] componentsSeparatedByString:@"\""];
         
         NSString *descriptio_String;
         NSString *title_string;
         
         if(titles_Array.count>1)
         {
         title_string = [titles_Array[1] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
         }
         else
         {
         title_string = [Values[3] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
         }
         if(descriptionArray.count>1)
         {
         descriptio_String = [descriptionArray[1] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
         }
         else
         {
         descriptio_String = [descriptionValues stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
         }*/
        
        
        
        NSString *api_Keys = [NSString stringWithFormat:@"%@",keys[0]];
        NSString *api_values = [NSString stringWithFormat:@"%@",Values[0]];
        
        NSString *submenu_Keys = [NSString stringWithFormat:@"%@",keys[1]];
        NSString *submenu_Values = [NSString stringWithFormat:@"%@",Values[1]];
        
        NSString *description_keys = [NSString stringWithFormat:@"%@",keys[2]];
        NSString *description_Values = [NSString stringWithFormat:@"%@",Values[2]];
        
        NSString *titles_keys = [NSString stringWithFormat:@"%@",keys[3]];
        NSString *titles_Values = [NSString stringWithFormat:@"%@",Values[3]];
        
        NSMutableCharacterSet *characterSet =
        [NSMutableCharacterSet characterSetWithCharactersInString:@"()\"\n" ""];
        NSMutableCharacterSet *characterSetDescription =
        [NSMutableCharacterSet characterSetWithCharactersInString:@"()\"\n" "<p></p>"];
        // Build array of components using specified characters as separtors
        NSArray *arrayOfComponents_Keys = [api_Keys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_Values = [api_values componentsSeparatedByCharactersInSet:characterSet];
        
        // Create string from the array components
        NSString *FInal_Api_Key = [arrayOfComponents_Keys componentsJoinedByString:@""];
        NSString *FInal_Api_Values =[arrayOfComponents_Values componentsJoinedByString:@""];
        
        
        NSArray *arrayOfComponents_TitleKeys = [titles_keys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_TitleValues = [titles_Values componentsSeparatedByCharactersInSet:characterSet];
        
        // Create string from the array components
        NSString *FInal_titles_keys = [arrayOfComponents_TitleKeys componentsJoinedByString:@""];
        NSString *FInal_titles_Values =[arrayOfComponents_TitleValues componentsJoinedByString:@""];
        
        
        NSArray *arrayOfComponents_descriptionKeys = [description_keys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_descriptionValues = [description_Values componentsSeparatedByCharactersInSet:characterSetDescription];
        // Create string from the array components
        NSString *description_titles_keys = [arrayOfComponents_descriptionKeys componentsJoinedByString:@""];
        NSString *description_titles_Values =[arrayOfComponents_descriptionValues componentsJoinedByString:@""];
        
        
        
        
        NSArray *arrayOfComponents_submenu_Keys = [submenu_Keys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_submenu_Values = [submenu_Values componentsSeparatedByCharactersInSet:characterSet];
        
        // Create string from the array components
        NSString *FInal_submenu_Keys = [arrayOfComponents_submenu_Keys componentsJoinedByString:@""];
        NSString *FInal_submenu_Values =[arrayOfComponents_submenu_Values componentsJoinedByString:@""];
        
        
        
        
        //NSLog(@"Dress:%@",descriptionArray[1]);
        urlValueGetHere = [NSString stringWithFormat:@"%@%@=%@&%@=%@&%@=%@&%@=%@",inURLValues,FInal_Api_Key,FInal_Api_Values,FInal_titles_keys,FInal_titles_Values,description_titles_keys,description_titles_Values,FInal_submenu_Keys,FInal_submenu_Values];
        NSArray* words = [urlValueGetHere componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceCharacterSet]];
        nospacestring = [words componentsJoinedByString:@""];
        NSArray *wordsRemoveSpace = [nospacestring componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        spaceStringRemoved  = [wordsRemoveSpace componentsJoinedByString:@""];
        NSLog(@"URL Values 4:%@",spaceStringRemoved);
    }
    else if([getCountFrominArrayValues isEqualToString:@"5"])
    {
        
        NSString *api_Keys = [NSString stringWithFormat:@"%@",keys[0]];
        NSString *api_values = [NSString stringWithFormat:@"%@",Values[0]];
        
        NSString *titles_keys = [NSString stringWithFormat:@"%@",keys[4]];
        NSString *titles_Values = [NSString stringWithFormat:@"%@",Values[4]];
        
        NSString *description_keys = [NSString stringWithFormat:@"%@",keys[1]];
        NSString *description_Values = [NSString stringWithFormat:@"%@",Values[1]];
        
        NSString *submenu_Keys = [NSString stringWithFormat:@"%@",keys[2]];
        NSString *submenu_Values = [NSString stringWithFormat:@"%@",Values[2]];
        
        
        NSString *subdomain_Keys = [NSString stringWithFormat:@"%@",keys[3]];
        NSString *subdomain_Values = [NSString stringWithFormat:@"%@",Values[3]];
        
        
        NSMutableCharacterSet *characterSet =
        [NSMutableCharacterSet characterSetWithCharactersInString:@"()\"\n" ""];
        NSMutableCharacterSet *characterSetDescription =
        [NSMutableCharacterSet characterSetWithCharactersInString:@"()\"\n" "<p></p>"];
        
        // Build array of components using specified characters as separtors
        NSArray *arrayOfComponents_Keys = [api_Keys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_Values = [api_values componentsSeparatedByCharactersInSet:characterSet];
        
        // Create string from the array components
        NSString *FInal_Api_Key = [arrayOfComponents_Keys componentsJoinedByString:@""];
        NSString *FInal_Api_Values =[arrayOfComponents_Values componentsJoinedByString:@""];
        
        
        NSArray *arrayOfComponents_TitleKeys = [titles_keys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_TitleValues = [titles_Values componentsSeparatedByCharactersInSet:characterSetDescription];
        
        // Create string from the array components
        NSString *FInal_titles_keys = [arrayOfComponents_TitleKeys componentsJoinedByString:@""];
        NSString *FInal_titles_Values =[arrayOfComponents_TitleValues componentsJoinedByString:@""];
        
        
        NSArray *arrayOfComponents_descriptionKeys = [description_keys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_descriptionValues = [description_Values componentsSeparatedByCharactersInSet:characterSetDescription];
        // Create string from the array components
        NSString *description_titles_keys = [arrayOfComponents_descriptionKeys componentsJoinedByString:@""];
        NSString *description_titles_Values =[arrayOfComponents_descriptionValues componentsJoinedByString:@""];
        
        
        NSArray *arrayOfComponents_submenu_Keys = [submenu_Keys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_submenu_Values = [submenu_Values componentsSeparatedByCharactersInSet:characterSetDescription];
        
        // Create string from the array components
        NSString *FInal_submenu_Keys = [arrayOfComponents_submenu_Keys componentsJoinedByString:@""];
        NSString *FInal_submenu_Values =[arrayOfComponents_submenu_Values componentsJoinedByString:@""];
        
        
        
        
        NSArray *arrayOfComponents_subdomain_Keys = [subdomain_Keys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_subdomain_Values = [subdomain_Values componentsSeparatedByCharactersInSet:characterSetDescription];
        
        // Create string from the array components
        NSString *FInal_subdomain_Keys = [arrayOfComponents_subdomain_Keys componentsJoinedByString:@""];
        NSString *FInal_subdomain_Values =[arrayOfComponents_subdomain_Values componentsJoinedByString:@""];
        
        NSLog(@"Value And Key1:%@",FInal_Api_Key);
        NSLog(@"Value And Key2:%@",FInal_Api_Values);
        NSLog(@"Value And Key3:%@",FInal_titles_keys);
        NSLog(@"Value And Key4:%@",FInal_titles_Values);
        NSLog(@"Value And Key5:%@",description_titles_keys);
        NSLog(@"Value And Key6:%@",description_titles_Values);
        NSLog(@"Value And Key7:%@",FInal_submenu_Keys);
        NSLog(@"Value And Key8:%@",FInal_submenu_Values);
        NSLog(@"Value And Key9:%@",FInal_subdomain_Keys);
        NSLog(@"Value And Key10:%@",FInal_subdomain_Values);
       

        urlValueGetHere = [NSString stringWithFormat:@"%@%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",inURLValues,FInal_Api_Key,FInal_Api_Values,FInal_titles_keys,FInal_titles_Values,description_titles_keys,description_titles_Values,FInal_submenu_Keys,FInal_submenu_Values,FInal_subdomain_Keys,FInal_subdomain_Values];
        NSArray* words = [urlValueGetHere componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceCharacterSet]];
        nospacestring = [words componentsJoinedByString:@""];
        NSArray *wordsRemoveSpace = [nospacestring componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        spaceStringRemoved  = [wordsRemoveSpace componentsJoinedByString:@""];
        NSLog(@"URL Values 5:%@",spaceStringRemoved);
        
        
        
    }
    else if([getCountFrominArrayValues isEqualToString:@"6"])
    {
        
        
        
        //Api_Keys
        NSString *api_Keys = [NSString stringWithFormat:@"%@",keys[0]];
        NSString *api_values = [NSString stringWithFormat:@"%@",Values[0]];
        //Title
        NSString *titles_keys = [NSString stringWithFormat:@"%@",keys[5]];
        NSString *titles_Values = [NSString stringWithFormat:@"%@",Values[5]];
        //Description
        
        NSString *description_keys = [NSString stringWithFormat:@"%@",keys[1]];
        NSString *description_Values = [NSString stringWithFormat:@"%@",Values[1]];
        
        //SubmenuValues[3]
        NSString *submenu_Keys = [NSString stringWithFormat:@"%@",keys[3]];
        NSString *submenu_Values = [NSString stringWithFormat:@"%@",Values[3]];
        
        
        //subdomain
        NSString *subdomain_Keys = [NSString stringWithFormat:@"%@",keys[4]];
        NSString *subdomain_Values = [NSString stringWithFormat:@"%@",Values[4]];
        
        //domain
        
        NSString *domain_Keys = [NSString stringWithFormat:@"%@",keys[2]];
        NSString *domain_Values = [NSString stringWithFormat:@"%@",Values[2]];
        
        //Bar_color
        NSString *barKeys = [NSString stringWithFormat:@"%@",keys[1]];
        NSString *barValues= [NSString stringWithFormat:@"%@",Values[1]];
        
        
        
        
        // Create character set with specified characters
        NSMutableCharacterSet *characterSet =
        [NSMutableCharacterSet characterSetWithCharactersInString:@"()\"\n" ""];
        NSMutableCharacterSet *characterSetDescription =
        [NSMutableCharacterSet characterSetWithCharactersInString:@"()\"\n" "<p></p>"];

        
        // Build array of components using specified characters as separtors
        NSArray *arrayOfComponents_Keys = [api_Keys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_Values = [api_values componentsSeparatedByCharactersInSet:characterSet];
        
        // Create string from the array components
        NSString *FInal_Api_Key = [arrayOfComponents_Keys componentsJoinedByString:@""];
        NSString *FInal_Api_Values =[arrayOfComponents_Values componentsJoinedByString:@""];
        
        
        NSArray *arrayOfComponents_TitleKeys = [titles_keys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_TitleValues = [titles_Values componentsSeparatedByCharactersInSet:characterSet];
        
        // Create string from the array components
        NSString *FInal_titles_keys = [arrayOfComponents_TitleKeys componentsJoinedByString:@""];
        NSString *FInal_titles_Values =[arrayOfComponents_TitleValues componentsJoinedByString:@""];
        
        
        NSArray *arrayOfComponents_descriptionKeys = [description_keys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_descriptionValues = [description_Values componentsSeparatedByCharactersInSet:characterSetDescription];
        // Create string from the array components
        NSString *description_titles_keys = [arrayOfComponents_descriptionKeys componentsJoinedByString:@""];
        NSString *description_titles_Values =[arrayOfComponents_descriptionValues componentsJoinedByString:@""];
        
        
        NSArray *arrayOfComponents_submenu_Keys = [submenu_Keys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_submenu_Values = [submenu_Values componentsSeparatedByCharactersInSet:characterSet];
        
        // Create string from the array components
        NSString *FInal_submenu_Keys = [arrayOfComponents_submenu_Keys componentsJoinedByString:@""];
        NSString *FInal_submenu_Values =[arrayOfComponents_submenu_Values componentsJoinedByString:@""];
        
        
        
        
        NSArray *arrayOfComponents_subdomain_Keys = [subdomain_Keys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_subdomain_Values = [subdomain_Values componentsSeparatedByCharactersInSet:characterSetDescription];
        
        // Create string from the array components
        NSString *FInal_subdomain_Keys = [arrayOfComponents_subdomain_Keys componentsJoinedByString:@""];
        NSString *FInal_subdomain_Values =[arrayOfComponents_subdomain_Values componentsJoinedByString:@""];
        
        
        
        
        NSArray *arrayOfComponents_domain_Keys = [domain_Keys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_domain_Values = [domain_Values componentsSeparatedByCharactersInSet:characterSet];
        
        // Create string from the array components
        NSString *FInal_domain_Keys = [arrayOfComponents_domain_Keys componentsJoinedByString:@""];
        NSString *FInal_domain_Values =[arrayOfComponents_domain_Values componentsJoinedByString:@""];
        
        
        
        
        NSArray *arrayOfComponents_barKeys = [barKeys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_barValues = [barValues componentsSeparatedByCharactersInSet:characterSet];
        
        // Create string from the array components
        NSString *FInal_barKeys = [arrayOfComponents_barKeys componentsJoinedByString:@""];
        NSString *FInal_barValues =[arrayOfComponents_barValues componentsJoinedByString:@""];
        
        
        
        
        NSLog(@"Value And Key1:%@",FInal_Api_Key);
        NSLog(@"Value And Key2:%@",FInal_Api_Values);
        NSLog(@"Value And Key3:%@",FInal_titles_keys);
        NSLog(@"Value And Key4:%@",FInal_titles_Values);
        NSLog(@"Value And Key5:%@",description_titles_keys);
        NSLog(@"Value And Key6:%@",description_titles_Values);
        NSLog(@"Value And Key7:%@",FInal_submenu_Keys);
        NSLog(@"Value And Key8:%@",FInal_submenu_Values);
        NSLog(@"Value And Key9:%@",FInal_subdomain_Keys);
        NSLog(@"Value And Key10:%@",FInal_subdomain_Values);
        NSLog(@"Value And Key11:%@",FInal_domain_Keys);
        NSLog(@"Value And Key12:%@",FInal_domain_Values);
        
        
        
       urlValueGetHere = [NSString stringWithFormat:@"%@%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",inURLValues,FInal_Api_Key,FInal_Api_Values,FInal_titles_keys,FInal_titles_Values,description_titles_keys,description_titles_Values,FInal_submenu_Keys,FInal_submenu_Values,FInal_subdomain_Keys,FInal_subdomain_Values,FInal_domain_Keys,FInal_domain_Values];
//        urlValueGetHere = @"http://build.myappbuilder.com/api/subscribers.json?api_key=e8ad6b11300fd6f71d1d20c5fdca5f26&subscriber[username]=Fetid&subscriber[email]=Fetid&subscriber[lastname]=We&subscriber[phone]=3466677&subscriber[firstname]=Test";
        
        NSArray* words = [urlValueGetHere componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceCharacterSet]];
        nospacestring = [words componentsJoinedByString:@""];
        NSArray *wordsRemoveSpace = [nospacestring componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        spaceStringRemoved  = [wordsRemoveSpace componentsJoinedByString:@""];
        
        NSLog(@"URL Values 6:%@",spaceStringRemoved);
        
    }
    else if([getCountFrominArrayValues isEqualToString:@"7"])
    {
        
        
        //Api_Keys
        NSString *api_Keys = [NSString stringWithFormat:@"%@",keys[0]];
        NSString *api_values = [NSString stringWithFormat:@"%@",Values[0]];
        //Title
        NSString *titles_keys = [NSString stringWithFormat:@"%@",keys[6]];
        NSString *titles_Values = [NSString stringWithFormat:@"%@",Values[6]];
        //Description
        
        NSString *description_keys = [NSString stringWithFormat:@"%@",keys[2]];
        NSString *description_Values = [NSString stringWithFormat:@"%@",Values[2]];
        
        //Submenu
        NSString *submenu_Keys = [NSString stringWithFormat:@"%@",keys[4]];
        NSString *submenu_Values = [NSString stringWithFormat:@"%@",Values[4]];
        
        
        //subdomain
        NSString *subdomain_Keys = [NSString stringWithFormat:@"%@",keys[5]];
        NSString *subdomain_Values = [NSString stringWithFormat:@"%@",Values[5]];
        
        //domain
        
        NSString *domain_Keys = [NSString stringWithFormat:@"%@",keys[3]];
        NSString *domain_Values = [NSString stringWithFormat:@"%@",Values[3]];
        
        //Bar_color
        NSString *barKeys = [NSString stringWithFormat:@"%@",keys[1]];
        NSString *barValues= [NSString stringWithFormat:@"%@",Values[1]];
        
        
        
        
        // Create character set with specified characters
        NSMutableCharacterSet *characterSet =
        [NSMutableCharacterSet characterSetWithCharactersInString:@"()\"\n " ""];
        NSMutableCharacterSet *characterSetDescription =
        [NSMutableCharacterSet characterSetWithCharactersInString:@"()\"\n" "<p></p>"];
        // Build array of components using specified characters as separtors
        NSArray *arrayOfComponents_Keys = [api_Keys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_Values = [api_values componentsSeparatedByCharactersInSet:characterSet];
        
        // Create string from the array components
        NSString *FInal_Api_Key = [arrayOfComponents_Keys componentsJoinedByString:@""];
        NSString *FInal_Api_Values =[arrayOfComponents_Values componentsJoinedByString:@""];
        
        
        NSArray *arrayOfComponents_TitleKeys = [titles_keys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_TitleValues = [titles_Values componentsSeparatedByCharactersInSet:characterSet];
        
        // Create string from the array components
        NSString *FInal_titles_keys = [arrayOfComponents_TitleKeys componentsJoinedByString:@""];
        NSString *FInal_titles_Values =[arrayOfComponents_TitleValues componentsJoinedByString:@""];
        
        
        NSArray *arrayOfComponents_descriptionKeys = [description_keys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_descriptionValues = [description_Values componentsSeparatedByCharactersInSet:characterSetDescription];
        // Create string from the array components
        NSString *description_titles_keys = [arrayOfComponents_descriptionKeys componentsJoinedByString:@""];
        NSString *description_titles_Values =[arrayOfComponents_descriptionValues componentsJoinedByString:@""];
        
        
        NSArray *arrayOfComponents_submenu_Keys = [submenu_Keys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_submenu_Values = [submenu_Values componentsSeparatedByCharactersInSet:characterSetDescription];
        
        // Create string from the array components
        NSString *FInal_submenu_Keys = [arrayOfComponents_submenu_Keys componentsJoinedByString:@""];
        NSString *FInal_submenu_Values =[arrayOfComponents_submenu_Values componentsJoinedByString:@""];
        
        
        
        
        NSArray *arrayOfComponents_subdomain_Keys = [subdomain_Keys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_subdomain_Values = [subdomain_Values componentsSeparatedByCharactersInSet:characterSetDescription];
        
        // Create string from the array components
        NSString *FInal_subdomain_Keys = [arrayOfComponents_subdomain_Keys componentsJoinedByString:@""];
        NSString *FInal_subdomain_Values =[arrayOfComponents_subdomain_Values componentsJoinedByString:@""];
        
        
        
        
        NSArray *arrayOfComponents_domain_Keys = [domain_Keys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_domain_Values = [domain_Values componentsSeparatedByCharactersInSet:characterSetDescription];
        
        // Create string from the array components
        NSString *FInal_domain_Keys = [arrayOfComponents_domain_Keys componentsJoinedByString:@""];
        NSString *FInal_domain_Values =[arrayOfComponents_domain_Values componentsJoinedByString:@""];
        
        
        
        
        NSArray *arrayOfComponents_barKeys = [barKeys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_barValues = [barValues componentsSeparatedByCharactersInSet:characterSetDescription];
        
        // Create string from the array components
        NSString *FInal_barKeys = [arrayOfComponents_barKeys componentsJoinedByString:@""];
        NSString *FInal_barValues =[arrayOfComponents_barValues componentsJoinedByString:@""];
        
        
        
        
        
        
        
        
        //Titles
        /* NSString *descriptionKeys =  [NSString stringWithFormat:@"%@",keys[2]];
         NSString *descriptionValues = [NSString stringWithFormat:@"%@",Values[2]];
         
         //Submenu
         
         NSString *submenuKeys = [NSString stringWithFormat:@"%@",keys[4]];
         NSString *submenuValues = [NSString stringWithFormat:@"%@",Values[4]];
         
         //subdomain
         
         NSString *subdomainKeys = [NSString stringWithFormat:@"%@",keys[5]];
         NSString *subdomainValues = [NSString stringWithFormat:@"%@",Values[5]];
         
         //domain
         
         NSString *domainKeys = [NSString stringWithFormat:@"%@",keys[3]];
         NSString *domainValues = [NSString stringWithFormat:@"%@",Values[3]];
         
         //Bar_color
         //NSString *barKeys = [NSString stringWithFormat:@"%@",keys[1]];
         
         NSArray *barValueRemoveSpace = [Values[1] componentsSeparatedByString:@"\n"];
         
         
         
         
         
         
         NSString *barValues;
         
         
         
         if (barValueRemoveSpace.count>0)
         {
         barValues  = [NSString stringWithFormat:@"%@",barValueRemoveSpace[0]];
         }
         else
         {
         barValues = [NSString stringWithFormat:@"%@",Values[1]];
         }
         
         
         
         
         
         
         
         
         //        //Bar_Button_Color
         //        NSString *bar_Button_ColorKeys = [NSString stringWithFormat:@"%@",keys[7]];
         //        NSString *bar_Button_ColorValues = [NSString stringWithFormat:@"%@",Values[7]];
         NSArray *keySpaceValue = [keys[6] componentsSeparatedByString:@"\n"];
         NSArray *keySpaceValueFromBar_Color = [keys[1] componentsSeparatedByString:@"\""];
         NSArray *keyRemove = [keys[0] componentsSeparatedByString:@"\""];
         
         NSArray *descriptionArray = [descriptionValues componentsSeparatedByString:@"\""];
         NSArray *titles_Array = [Values[6] componentsSeparatedByString:@"\""];
         NSArray *submenuValues_Array = [submenuValues componentsSeparatedByString:@"\""];
         NSArray *subdomainValues_Array = [subdomainValues componentsSeparatedByString:@"\""];
         NSArray *domainValues_Array = [subdomainValues componentsSeparatedByString:@"\""];
         NSArray *barValues_Array = [barValues componentsSeparatedByString:@"\""];
         
         
         NSLog(@"Array Values Here:%@",[NSString stringWithFormat:@"%@",barValues_Array[1]]);
         
         // NSArray *barValues_SpaceRemove_Array = [barValues_Array[1] componentsSeparatedByString:@"\n"];
         
         
         
         
         
         
         NSString *descriptio_String;
         NSString *title_string;
         NSString *submenuValues_String;
         NSString *subdomainValues_String;
         NSString *domainValues_String;
         NSString *barValues_String;
         
         
         
         barValues_String = [NSString stringWithFormat:@"%@",barValues_Array[1]];
         domainValues_String = [NSString stringWithFormat:@"%@",domainValues];
         subdomainValues_String = [NSString stringWithFormat:@"%@",subdomainValues];
         submenuValues_String = [NSString stringWithFormat:@"%@",submenuValues];
         descriptio_String = [NSString stringWithFormat:@"%@",descriptionValues];
         title_string  = [NSString stringWithFormat:@"%@",Values[6]];
         
         
         NSLog(@"Array Values Here domainValues:%@",[NSString stringWithFormat:@"%@",domainValues]);
         
         if(titles_Array.count>1)
         {
         title_string = [titles_Array[1] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
         }
         else
         {
         title_string = [Values[6] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
         }
         if(descriptionArray.count>1)
         {
         descriptio_String = [descriptionArray[1] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
         }
         else
         {
         descriptio_String = [descriptionValues stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
         }
         
         
         if(submenuValues_Array.count>1)
         {
         submenuValues_String = [submenuValues_Array[1] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
         }
         else
         {
         submenuValues_String = [submenuValues stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
         }
         
         if(subdomainValues_Array.count>1)
         {
         subdomainValues_String = [subdomainValues_Array[1] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
         }
         else
         {
         subdomainValues_String = [subdomainValues stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
         }
         
         if(domainValues_Array.count>1)
         {
         domainValues_String = [domainValues_Array[1] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
         }
         else
         {
         domainValues_String = [domainValues stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
         }
         
         if(barValues_Array.count>1)
         {
         barValues_String = [NSString stringWithFormat:@"%@",barValues_SpaceRemove_Array[1]];
         //[barValues_SpaceRemove_Array[1] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
         }
         else
         {
         barValues_String = [NSString stringWithFormat:@"%@",barValues];
         }
         */
        
        
        
        NSLog(@"Value And Key:%@",FInal_Api_Key);
        NSLog(@"Value And Key:%@",FInal_Api_Values);
        NSLog(@"Value And Key:%@",FInal_titles_keys);
        NSLog(@"Value And Key:%@",FInal_titles_Values);
        NSLog(@"Value And Key:%@",description_titles_keys);
        NSLog(@"Value And Key:%@",description_titles_Values);
        NSLog(@"Value And Key:%@",FInal_submenu_Keys);
        NSLog(@"Value And Key:%@",FInal_submenu_Values);
        NSLog(@"Value And Key:%@",FInal_subdomain_Keys);
        NSLog(@"Value And Key:%@",FInal_subdomain_Values);
        NSLog(@"Value And Key:%@",FInal_domain_Keys);
        NSLog(@"Value And Key:%@",FInal_domain_Values);
        
        
        urlValueGetHere = [NSString stringWithFormat:@"%@%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",inURLValues,FInal_Api_Key,FInal_Api_Values,FInal_titles_keys,FInal_titles_Values,description_titles_keys,description_titles_Values,FInal_submenu_Keys,FInal_submenu_Values,FInal_subdomain_Keys,FInal_subdomain_Values,FInal_domain_Keys,FInal_domain_Values,FInal_barKeys,FInal_barValues];
        NSArray* words = [urlValueGetHere componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceCharacterSet]];
        nospacestring = [words componentsJoinedByString:@""];
        NSArray *wordsRemoveSpace = [nospacestring componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        spaceStringRemoved  = [wordsRemoveSpace componentsJoinedByString:@""];
        
        
        
        //spaceStringRemoved = @"http://build.myappbuilder.com/api/subscribers.json?api_key=e8ad6b11300fd6f71d1d20c5fdca5f26&email=ethan@gmail.com&firstname=Ethankumar&id=4237&lastname=Hunt&phone=55485269&username=ethan@gmail.com";
        
        
        NSLog(@"URL Values 7:%@",spaceStringRemoved);
    }
    else if([getCountFrominArrayValues isEqualToString:@"8"])
    {
        
        NSString *api_Keys = [NSString stringWithFormat:@"%@",keys[0]];
        NSString *api_values = [NSString stringWithFormat:@"%@",Values[0]];
        //Title
        NSString *titles_keys = [NSString stringWithFormat:@"%@",keys[7]];
        NSString *titles_Values = [NSString stringWithFormat:@"%@",Values[7]];
        //Description
        
        NSString *description_keys = [NSString stringWithFormat:@"%@",keys[4]];
        NSString *description_Values = [NSString stringWithFormat:@"%@",Values[4]];
        
        //Submenu
        NSString *submenu_Keys = [NSString stringWithFormat:@"%@",keys[5]];
        NSString *submenu_Values = [NSString stringWithFormat:@"%@",Values[5]];
        
        
        //subdomain
        NSString *subdomain_Keys = [NSString stringWithFormat:@"%@",keys[6]];
        NSString *subdomain_Values = [NSString stringWithFormat:@"%@",Values[6]];
        
        //domain
        
        NSString *domain_Keys = [NSString stringWithFormat:@"%@",keys[2]];
        NSString *domain_Values = [NSString stringWithFormat:@"%@",Values[2]];
        
        //Bar_color
        NSString *barKeys = [NSString stringWithFormat:@"%@",keys[1]];
        NSString *bar_Values= [NSString stringWithFormat:@"%@",Values[1]];
        
        
        
        NSString *buttons_Color_Keys = [NSString stringWithFormat:@"%@",keys[3]];
        NSString *buttons_color_Values = [NSString stringWithFormat:@"%@",Values[3]];
        
        
        // Create character set with specified characters
NSMutableCharacterSet *characterSet =
        [NSMutableCharacterSet characterSetWithCharactersInString:@"()\"\n" ""];
NSMutableCharacterSet *characterSetDescription =
        [NSMutableCharacterSet characterSetWithCharactersInString:@"()\"\n" "<p></p>"  "\\n"];
        
        // Build array of components using specified characters as separtors
        NSArray *arrayOfComponents_Keys = [api_Keys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_Values = [api_values componentsSeparatedByCharactersInSet:characterSet];
        
        // Create string from the array components
        NSString *FInal_Api_Key = [arrayOfComponents_Keys componentsJoinedByString:@""];
        NSString *FInal_Api_Values =[arrayOfComponents_Values componentsJoinedByString:@""];
        
        
        NSArray *arrayOfComponents_TitleKeys = [titles_keys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_TitleValues = [titles_Values componentsSeparatedByCharactersInSet:characterSet];
        
        // Create string from the array components
        NSString *FInal_titles_keys = [arrayOfComponents_TitleKeys componentsJoinedByString:@""];
        NSString *FInal_titles_Values =[arrayOfComponents_TitleValues componentsJoinedByString:@""];
        
        
        NSArray *arrayOfComponents_descriptionKeys = [description_keys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_descriptionValues = [description_Values componentsSeparatedByCharactersInSet:characterSetDescription];
        // Create string from the array components
        NSString *description_titles_keys = [arrayOfComponents_descriptionKeys componentsJoinedByString:@""];
        NSString *description_titles_Values =[arrayOfComponents_descriptionValues componentsJoinedByString:@""];
        
        
        NSString *desValue = [description_titles_Values stringByReplacingOccurrencesOfString:@"\\n" withString:@"n"];
        
        NSLog(@"NO Values:%@",desValue);
        
        
        NSArray *arrayOfComponents_submenu_Keys = [submenu_Keys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_submenu_Values = [submenu_Values componentsSeparatedByCharactersInSet:characterSet];
        
        // Create string from the array components
        NSString *FInal_submenu_Keys = [arrayOfComponents_submenu_Keys componentsJoinedByString:@""];
        NSString *FInal_submenu_Values =[arrayOfComponents_submenu_Values componentsJoinedByString:@""];
        
        
        
        
    NSArray *arrayOfComponents_subdomain_Keys = [subdomain_Keys componentsSeparatedByCharactersInSet:characterSet];
    NSArray *arrayOfComponents_subdomain_Values = [subdomain_Values componentsSeparatedByCharactersInSet:characterSet];
        
        // Create string from the array components
        NSString *FInal_subdomain_Keys = [arrayOfComponents_subdomain_Keys componentsJoinedByString:@""];
        NSString *FInal_subdomain_Values =[arrayOfComponents_subdomain_Values componentsJoinedByString:@""];
        
        
        
        
        NSArray *arrayOfComponents_domain_Keys = [domain_Keys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_domain_Values = [domain_Values componentsSeparatedByCharactersInSet:characterSet];
        
        // Create string from the array components
        NSString *FInal_domain_Keys = [arrayOfComponents_domain_Keys componentsJoinedByString:@""];
        NSString *FInal_domain_Values =[arrayOfComponents_domain_Values componentsJoinedByString:@""];
        
        
        
        
        NSArray *arrayOfComponents_barKeys = [barKeys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_barValues = [bar_Values componentsSeparatedByCharactersInSet:characterSet];
        
        // Create string from the array components
        NSString *FInal_barKeys = [arrayOfComponents_barKeys componentsJoinedByString:@""];
        NSString *FInal_barValues =[arrayOfComponents_barValues componentsJoinedByString:@""];
        
        
        
        
        
        NSArray *arrayOfComponents_buttonKeys = [buttons_Color_Keys componentsSeparatedByCharactersInSet:characterSet];
        NSArray *arrayOfComponents_buttonValues = [buttons_color_Values componentsSeparatedByCharactersInSet:characterSet];
        
        // Create string from the array components
        NSString *FInal_buttonKeys = [arrayOfComponents_buttonKeys componentsJoinedByString:@""];
        NSString *FInal_buttonValues =[arrayOfComponents_buttonValues componentsJoinedByString:@""];
        
        NSLog(@"Value And Key:%@",FInal_Api_Key);
        NSLog(@"Value And Key:%@",FInal_Api_Values);
        NSLog(@"Value And Key:%@",FInal_titles_keys);
        NSLog(@"Value And Key:%@",FInal_titles_Values);
        NSLog(@"Value And Key:%@",description_titles_keys);
        NSLog(@"Value And Key:%@",description_titles_Values);
        NSLog(@"Value And Key:%@",FInal_submenu_Keys);
        NSLog(@"Value And Key:%@",FInal_submenu_Values);
        NSLog(@"Value And Key:%@",FInal_subdomain_Keys);
        NSLog(@"Value And Key:%@",FInal_subdomain_Values);
        NSLog(@"Value And Key:%@",FInal_domain_Keys);
        NSLog(@"Value And Key:%@",FInal_domain_Values);
        
        
        urlValueGetHere = [NSString stringWithFormat:@"%@%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",inURLValues,FInal_Api_Key,FInal_Api_Values,FInal_titles_keys,FInal_titles_Values,description_titles_keys,description_titles_Values,FInal_submenu_Keys,FInal_submenu_Values,FInal_subdomain_Keys,FInal_subdomain_Values,FInal_domain_Keys,FInal_domain_Values,FInal_barKeys,FInal_barValues,FInal_buttonKeys,FInal_buttonValues];
        
        NSArray* words = [urlValueGetHere componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceCharacterSet]];
        nospacestring = [words componentsJoinedByString:@""];
        NSArray *wordsRemoveSpace = [nospacestring componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        spaceStringRemoved  = [wordsRemoveSpace componentsJoinedByString:@""];
        NSLog(@"URL Values 8:%@",spaceStringRemoved);
        
    }
    else if([getCountFrominArrayValues isEqualToString:@"9"])
    {
        //Titles
        NSString *descriptionKeys =  [NSString stringWithFormat:@"%@",keys[4]];
        NSString *descriptionValues = [NSString stringWithFormat:@"%@",Values[4]];
        //Submenu
        NSString *submenuKeys = [NSString stringWithFormat:@"%@",keys[6]];
        NSString *submenuValues = [NSString stringWithFormat:@"%@",Values[6]];
        //subdomain
        NSString *subdomainKeys = [NSString stringWithFormat:@"%@",keys[7]];
        NSString *subdomainValues = [NSString stringWithFormat:@"%@",Values[7]];
        //domain
        NSString *domainKeys = [NSString stringWithFormat:@"%@",keys[5]];
        NSString *domainValues = [NSString stringWithFormat:@"%@",Values[5]];
        //Bar_color
        //NSString *barKeys = [NSString stringWithFormat:@"%@",keys[1]];
        NSString *barValues = [NSString stringWithFormat:@"%@",Values[2]];
        //Bar_Button_Color
        //NSString *bar_Button_ColorKeys = [NSString stringWithFormat:@"%@",keys[7]];
        NSString *bar_Button_ColorValues = [NSString stringWithFormat:@"%@",Values[1]];
        //button_color
        NSString *button_ColorValues = [NSString stringWithFormat:@"%@",Values[3]];
        
        
        NSArray *keySpaceValue = [keys[8] componentsSeparatedByString:@"\n"];
        NSArray *keySpaceValueFromBar_Color = [keys[2] componentsSeparatedByString:@"\""];
        NSArray *keySpaceValueFromBar_button_color = [keys[1] componentsSeparatedByString:@"\""];
        NSArray *keyRemove = [keys[0] componentsSeparatedByString:@"\""];
        NSArray *keyButtonColorValues = [keys[3] componentsSeparatedByString:@"\""];
        
        NSArray *descriptionArray = [descriptionValues componentsSeparatedByString:@"\""];
        NSArray *titles_Array = [Values[8] componentsSeparatedByString:@"\""];
        NSArray *submenuValues_Array = [submenuValues componentsSeparatedByString:@"\""];
        NSArray *subdomainValues_Array = [subdomainValues componentsSeparatedByString:@"\""];
        NSArray *domainValues_Array = [subdomainValues componentsSeparatedByString:@"\""];
        NSArray *barValues_Array = [barValues componentsSeparatedByString:@"\""];
        NSArray *bar_Button_ColorValues_Array = [bar_Button_ColorValues componentsSeparatedByString:@"\""];
        NSArray *button_ColorValues_Array = [button_ColorValues componentsSeparatedByString:@"\""];
        
        NSString *descriptio_String;
        NSString *title_string;
        NSString *submenuValues_String;
        NSString *subdomainValues_String;
        NSString *domainValues_String;
        NSString *barValues_String;
        NSString *bar_Button_ColorValues_String;
        NSString *button_ColorValues_String;
        
        if(titles_Array.count>1)
        {
            title_string = [titles_Array[1] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        }
        else
        {
            title_string = [Values[8] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        }
        if(descriptionArray.count>1)
        {
            descriptio_String = [descriptionArray[1] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        }
        else
        {
            descriptio_String = [descriptionValues stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        }
        if(submenuValues_Array.count>1)
        {
            submenuValues_String = [submenuValues_Array[1] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        }
        else
        {
            submenuValues_String = [submenuValues stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        }
        if(subdomainValues_Array.count>1)
        {
            subdomainValues_String = [subdomainValues_Array[1] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        }
        else
        {
            subdomainValues_String = [subdomainValues stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        }
        
        if(domainValues_Array.count>1)
        {
            domainValues_String = [domainValues_Array[1] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        }
        else
        {
            domainValues_String = [domainValues stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        }
        if(barValues_Array.count>1)
        {
            barValues_String = [barValues_Array[1] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        }
        else
        {
            barValues_String = [barValues stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        }
        if(bar_Button_ColorValues_Array.count>1)
        {
            bar_Button_ColorValues_String = [bar_Button_ColorValues_Array[1] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        }
        else
        {
            bar_Button_ColorValues_String = [bar_Button_ColorValues stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        }
        if(button_ColorValues_Array.count>1)
        {
            button_ColorValues_String = [button_ColorValues_Array[1] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        }
        else
        {
            button_ColorValues_String = [button_ColorValues stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        }
        
        urlValueGetHere = [NSString stringWithFormat:@"%@%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@&%@=%@",inURLValues,keyRemove[1],Values[0],keySpaceValue[1],title_string,descriptionKeys,descriptio_String,submenuKeys,submenuValues_String,subdomainKeys,subdomainValues_String,domainKeys,domainValues_String,keySpaceValueFromBar_Color[1],barValues_String,keySpaceValueFromBar_button_color[1],bar_Button_ColorValues_String,keyButtonColorValues[1],button_ColorValues_String];
        
        NSArray* words = [urlValueGetHere componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceCharacterSet]];
        nospacestring = [words componentsJoinedByString:@""];
        
        NSArray *wordsRemoveSpace = [nospacestring componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        spaceStringRemoved  = [wordsRemoveSpace componentsJoinedByString:@""];
        NSLog(@"URL Values 9:%@",spaceStringRemoved);
        
    }
    else if([getCountFrominArrayValues isEqualToString:@"11"])
    {
        
    }
    else if([getCountFrominArrayValues isEqualToString:@"12"])
    {
        
    }
    else if([getCountFrominArrayValues isEqualToString:@"13"])
    {
        
    }
    else
    {
        NSLog(@"Datavan");
    }
    //[request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://build.myappbuilder.com/api/apps/settings/general.json?api_key=ece73ade72f355d1de6c8cded79a2a22&title=keen&description=Gerenking&domain=buildapps&subdomain=submain&bar_color=royal&bar_button_color=energized&button_color=energized"]]];
    
    //    spaceStringRemoved = [NSString stringWithFormat:@"http://build.myappbuilder.com/api/apps/settings/general.json?api_key=b7842e69a188e180dd79fcbca3a08268&title=keen&description=Gerenking&domain=buildap.ps&subdomain=submain&bar_color=royal&bar_button_color=energized&button_color=energized"];
    //
    //[request setURL:[NSURL URLWithString:[spaceStringRemoved stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    NSString *s = [NSString stringWithFormat:@"%@",spaceStringRemoved];
    //url = [[NSURL alloc] initWithString:spaceStringRemoved];
    url = [NSURL URLWithString:spaceStringRemoved];
    [request setURL:url];
    NSLog(@"URLFinal Creations:%@",[spaceStringRemoved stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
    
    [request setHTTPMethod:inSendMethod];
    NSString *stringBoundary = @"0xKhTmLbOuNdArY---This_Is_ThE_BoUnDaRyy---pqo";
    // add header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@;",stringBoundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    // add image data
    NSMutableData *postbody = [NSMutableData data];
    [postbody appendData:[[NSString stringWithFormat:@"--%@\r\n",stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",inApp_Name,@"fill.png"] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[@"Content-Type:image/png\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"Images:%@",imageData);
    [postbody appendData:imageData];
    [postbody appendData:[[NSString stringWithFormat:@"--%@--\r\n",stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postbody];
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //this will start the image loading in bg
    dispatch_async(concurrentQueue, ^{
        NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *strData = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
        NSLog(@"In App:%@",inApp_Name);
        NSLog(@"Data Receied%@",strData);
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"just sent request");
            NSString *responseString = [[NSString alloc] initWithBytes:[responseData bytes]
                                                                length:[responseData length]
                                                              encoding:NSUTF8StringEncoding];
            
            NSLog(@"Data Receied responseString%@",responseString);
            NSError* error;
            NSDictionary* json = [NSJSONSerialization
                                  JSONObjectWithData:responseData
                                  options:kNilOptions
                                  error:&error];
            //NSArray* latesturl = [json objectForKey:@"url"];
            // NSLog(@"loans: %@", latesturl);
            //NSString *urlString = [NSString stringWithFormat:@"%@",latesturl];
            
            NSString *jsonValue = [NSString stringWithFormat:@"%@",[json objectForKey:@"error"]];
            if (responseString.length!=0)
            {
                //if (![responseString isEqualToString:@"error"])
                //{
                CDVPluginResult *result;
                if (![jsonValue isEqualToString:@"Bad Request"])
                {
                    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:json];
                }
                else
                {
                    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:json];
                }
                
                [self.commandDelegate sendPluginResult:result callbackId:cmds.callbackId];
                // }
                keyValues = NO;
            
                for (int i=0; i<[CollectFileValue count]; i++)
                {
                    NSLog(@"Image:%@",[CollectFileValue objectAtIndex:i]);
                    
                    [self removeTempFolder:[CollectFileValue objectAtIndex:i]];
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
