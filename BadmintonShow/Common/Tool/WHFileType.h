//
//  WHFileType.h
//  MyFile
//
//  Created by wihing on 13-1-30.
//  Copyright (c) 2013年 wihing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    FileTypeUnkown = 0,
    FileTypeDoc,
    FileTypePic,
    FileTypePdf,
    FileTypeAudio,
    FileTypeVideo,
    FileTypeZip
} FileType;

@interface WHFileType : NSObject

+ (WHFileType *)sharedInstance;

- (FileType)fileTypeOfFileInFilePath:(NSString *)filePath;

@end
