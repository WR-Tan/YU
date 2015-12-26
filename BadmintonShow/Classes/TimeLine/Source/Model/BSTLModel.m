

//
//  BSTLModel.m
//  BadmintonShow
//
//  Created by lizhihua on 12/25/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSTLModel.h"

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
