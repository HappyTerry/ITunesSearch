//
//  CollectingManager.h
//  AotterProject
//
//  Created by Terry on 2019/3/11.
//  Copyright © 2019 HappyTerry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectingManager : NSObject {
    
}

+ (void)addCollecting:(NSDictionary *)collecting;
+ (void)removeCollecting:(NSDictionary *)collecting;
+ (NSInteger)getCollectingCount;
+ (NSDictionary *)getAllCollection;
+ (BOOL)isCollecting:(NSDictionary *)collecting;

@end

NS_ASSUME_NONNULL_END
