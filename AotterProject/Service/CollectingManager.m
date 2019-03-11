//
//  CollectingManager.m
//  AotterProject
//
//  Created by Terry on 2019/3/11.
//  Copyright © 2019 HappyTerry. All rights reserved.
//

#import "CollectingManager.h"

#define CollectingData @"CollectingData"
#define TrackID @"trackId"

@implementation CollectingManager

+ (NSDictionary *)getAllCollection {
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults dictionaryForKey:CollectingData] != NULL) {
        return [userDefaults dictionaryForKey:CollectingData];
    }
    return @{};
}

+ (void)syncCollecting:(NSDictionary *)allCollecting {
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:allCollecting forKey:CollectingData];
    [userDefaults synchronize];
}

+ (void)addCollecting:(NSDictionary *)collecting {
    if ([CollectingManager isCollecting:collecting]) {
        return ;
    }
    NSMutableDictionary * allCollectings = [NSMutableDictionary dictionaryWithDictionary:[CollectingManager getAllCollection]];
    if (collecting[TrackID] != NULL) {
        NSString * track = [NSString stringWithFormat:@"%li", [collecting[TrackID] integerValue]];
        [allCollectings setObject:collecting forKey:track];
    }
    [CollectingManager syncCollecting:allCollectings];
}

+ (void)removeCollecting:(NSDictionary *)collecting {
    if (![CollectingManager isCollecting:collecting]) {
        return ;
    }
    NSMutableDictionary * allCollectings = [NSMutableDictionary dictionaryWithDictionary:[CollectingManager getAllCollection]];
    if (collecting[TrackID] != NULL) {
        NSString * track = [NSString stringWithFormat:@"%li", [collecting[TrackID] integerValue]];
        [allCollectings removeObjectForKey:track];
    }
    [CollectingManager syncCollecting:allCollectings];
}

+ (NSInteger)getCollectingCount {
    NSDictionary * allCollectings = [CollectingManager getAllCollection];
    return [allCollectings.allKeys count];
}

+ (BOOL)isCollecting:(NSDictionary *)collecting {
    NSDictionary * allCollectings = [CollectingManager getAllCollection];
    if (collecting[TrackID] != NULL) {
        NSString * track = [NSString stringWithFormat:@"%li", [collecting[TrackID] integerValue]];
        if ([allCollectings.allKeys containsObject:track]) {
            return YES;
        }
    }
    return NO;
}

@end
