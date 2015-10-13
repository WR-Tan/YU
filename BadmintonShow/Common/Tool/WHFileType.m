//
//  WHFileType.m
//  MyFile
//
//  Created by wihing on 13-1-30.
//  Copyright (c) 2013年 wihing. All rights reserved.
//

#import "WHFileType.h"
#import "UIKit+x.h"

@interface WHFileType ()

@property (strong, nonatomic) NSMutableDictionary *fileTypeDictionary;

@end

@implementation WHFileType

+ (WHFileType *)sharedInstance
{
    static WHFileType *instance;
    @synchronized (self) {
        if (instance == nil)
            instance = [WHFileType new];
    }
    return instance;
}

- (FileType)fileTypeOfFileInFilePath:(NSString *)filePath
{
    
    NSString *fileExtention = [[filePath extension] lowercaseString];
    if (fileExtention == nil) {
        return FileTypeUnkown;
    }
    return ((NSNumber *)_fileTypeDictionary[fileExtention]).integerValue;
}

- (id)init
{
    if (self = [super init]) {
        _fileTypeDictionary = [@{
                               // doc
                               @"doc"   :   @(FileTypeDoc),
                               @"xls"   :   @(FileTypeDoc),
                               @"xlsx"  :   @(FileTypeDoc),
                               @"txt"   :   @(FileTypeDoc),
                               @"ppt"   :   @(FileTypeDoc),
                               @"docx"  :   @(FileTypeDoc),
                               @"pptx"  :   @(FileTypeDoc),
                               @"rtf"   :   @(FileTypeDoc),
                               @"htm"   :   @(FileTypeDoc),
                               @"html"  :   @(FileTypeDoc),
                               
                               // pic
                               @"jpg"   :   @(FileTypePic),
                               @"jpeg"  :   @(FileTypePic),
                               @"png"   :   @(FileTypePic),
                               @"bmp"   :   @(FileTypePic),
                               @"gif"   :   @(FileTypePic),
                               
                               // pdf
                               @"pdf"   :   @(FileTypePdf),
                               
                               // audio
                               @"mp3"   :   @(FileTypeAudio),
                               @"wav"   :   @(FileTypeAudio),
                               @"mid"   :   @(FileTypeAudio),
                               @"midi"  :   @(FileTypeAudio),
                               @"mp3pro":   @(FileTypeAudio),
                               @"wma"   :   @(FileTypeAudio),
                               @"ape"   :   @(FileTypeAudio),
                               
                               // video
                               @"mp4"   :   @(FileTypeVideo),
                               @"m4v"   :   @(FileTypeVideo),
                               @"mov"   :   @(FileTypeVideo),
                               @"avi"   :   @(FileTypeVideo),
                               @"flv"   :   @(FileTypeVideo),
                               @"rmvb"  :   @(FileTypeVideo),
                               @"asf"   :   @(FileTypeVideo),
                               @"mpeg"  :   @(FileTypeVideo),
                               @"mpg"   :   @(FileTypeVideo),
                               @"rm"    :   @(FileTypeVideo),
                               @"3gp"   :   @(FileTypeVideo),
                               @"mkv"   :   @(FileTypeVideo),
                               @"wmv"   :   @(FileTypeVideo),
                               @"f4v"   :   @(FileTypeVideo),
                               @"ts "   :   @(FileTypeVideo),
                               
                               // zip 
                               @"zip"   :   @(FileTypeZip),
                               @"rar"   :   @(FileTypeZip)
                               } mutableCopy];
    }
    return self;
}

@end
