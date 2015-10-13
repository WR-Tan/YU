//
//  RatingPromotor.m
//  BookKeeping
//
//  Created by wihing on 12-11-8.
//
//

#import "RatingPromotor.h"
#import "UIKit+x.h"

@interface RatingPromotor ()

@property (assign, nonatomic) NSInteger executeTime;
@property (assign, nonatomic) BOOL hasRated;

@end

@implementation RatingPromotor

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0: // cancel
            self.hasRated = NO;
            self.executeTime = 0;
            break;
        case 1: // rating
            self.hasRated = YES;
            break;
        case 2: // nerver mind
            self.hasRated = YES;
            self.executeTime = 0;
            break;
        default:
            break;
    }
}

- (void)promoteRatingDialog:(id)nilObj
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Thank you" message:@"if you like this app please rate for us" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"rating", @"nerver mind", nil];
    [alertView show];
}

- (void)auxPromoteRating
{
    [self asyncTask:^{
        if (self.hasRated)
            return;
        NSInteger executeTime = self.executeTime;
        if (executeTime >= 5) {
            [self performSelectorOnMainThread:@selector(promoteRatingDialog:) withObject:nil waitUntilDone:NO];
        }
        self.executeTime = executeTime + 1;
    }];
}

+ (void)promoteRating
{
    static RatingPromotor *ratingPromotor;
    if (ratingPromotor == nil) {
        ratingPromotor = [RatingPromotor new];
    }
    [ratingPromotor auxPromoteRating];
}

- (BOOL)hasRated
{
    NSNumber *hasRated = [[NSUserDefaults standardUserDefaults] valueForKey:@"hasRated"];
    if (hasRated == nil)
        return NO;
    return hasRated.boolValue;
}

- (void)setHasRated:(BOOL)hasRated
{
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithBool:hasRated] forKey:@"hasRated"];
}

- (NSInteger)executeTime
{
    NSNumber *executeTime = [[NSUserDefaults standardUserDefaults] valueForKey:@"executeTime"];
    if (executeTime == nil)
        return 1;
    return executeTime.integerValue;
}

- (void)setExecuteTime:(NSInteger)executeTime
{
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInt:executeTime] forKey:@"executeTime"];
}

@end
