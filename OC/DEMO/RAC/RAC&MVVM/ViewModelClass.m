//
//  GPBaseRac.h
//  DEMO
//
//  Created by 郭鹏 on 2022/2/7.
//  Copyright © 2022 郭鹏. All rights reserved.
//

#import "ViewModelClass.h"

@implementation ViewModelClass

#pragma 接收传过来的block
- (void)initWithBlock: (ReturnValueBlock) successBlock
            WithErrorBlock: (ErrorCodeBlock) errorBlock
{
    _successBlock = successBlock;
    _errorBlock = errorBlock;
}

@end
