//
//  HTTPCommunication.h
//  Sprint01ARC
//
//  Created by iLya Tkachev on 3/31/17.
//  Copyright © 2017 iLya Tkachev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPCommunication : NSObject <NSURLSessionDownloadDelegate>

@property(nonatomic, copy) void(^myBlock)(NSData *);

- (void)retrieveURL:(NSURL *)url myBlock:(void(^)(NSData *))myBlock;

@end
