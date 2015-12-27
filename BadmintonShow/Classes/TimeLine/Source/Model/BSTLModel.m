

//
//  BSTLModel.m
//  BadmintonShow
//
//  Created by lizhihua on 12/25/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSTLModel.h"


@implementation BSEmoticon
+ (NSArray *)modelPropertyBlacklist {
    return @[@"group"];
}
@end

@implementation BSEmoticonGroup
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"groupID" : @"id",
             @"nameCN" : @"group_name_cn",
             @"nameEN" : @"group_name_en",
             @"nameTW" : @"group_name_tw",
             @"displayOnly" : @"display_only",
             @"groupType" : @"group_type"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"emoticons" : [BSEmoticon class]};
}
- (void)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    [_emoticons enumerateObjectsUsingBlock:^(BSEmoticon *emoticon, NSUInteger idx, BOOL *stop) {
        emoticon.group = self;
    }];
}
@end
 

@implementation BSPictureMetadata

@end


@implementation BSPicture

@end


@implementation BSURL

@end


@implementation BSTopic

@end

@implementation BSTag

@end

@implementation BSButtonLink

@end


@implementation BSPageInfo

@end



@implementation BSStatusTitle

@end


/*------------------------------------------------------------------------*/
@implementation BSTLMedia

+ (instancetype)modelWithAVFile:(AVFile *)image {
    BSTLMedia  *model = [[BSTLMedia alloc] init];
    model.objectId = image.objectId;
    model.url = [NSURL URLWithString:image.url];
    // size in metaData : (@"size" : (long)70048) ?
    return  model;
}

@end


@implementation BSTLModel

+ (BSTLModel *)modelWithAVObject:(AVObject *)object{
    BSTLModel *model = [[BSTLModel alloc] init];
    model.objectId = object.objectId;
    model.createdAt = object.createdAt;
    model.updatedAt = object.updatedAt;
    
    NSDictionary *dict = object[@"localData"];
    model.user = [BSProfileUserModel modelFromAVUser: dict[@"user"]];
    
    model.text = dict[@"text"];
    model.favoriteCount = [(NSNumber *)dict[@"attitudes_count"] unsignedIntegerValue];
    model.commentsCount = [(NSNumber *)dict[@"comments_count"] unsignedIntegerValue];
    NSMutableArray *picM = [NSMutableArray array];
    for (AVFile *image in dict[@"pics"]) {
        BSTLMedia *picModel = [BSTLMedia modelWithAVFile:image];
        if (picModel) {
            [picM addObject:picModel];
        }
    }
    model.medias = picM;
    
    return model;
}

@end
