//
//  NSURL+GPURL.m
//  DEMO
//
//  Created by 郭鹏 on 2022/2/3.
//  Copyright © 2022 郭鹏. All rights reserved.
//

#import "NSURL+GPURL.h"

@implementation NSURL (GPURL)
- (NSURL *)streamingURL {
    
    NSURLComponents *commpents = [NSURLComponents componentsWithString:self.absoluteString];
    [commpents setScheme:@"streaming"];
    
    return [commpents URL];
    
}

- (NSURL *)httpURL {
    NSURLComponents *commpents = [NSURLComponents componentsWithString:self.absoluteString];
    [commpents setScheme:@"http"];
    
    return [commpents URL];
}
@end
