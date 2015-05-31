//
//  SourceTextViewDelegateProxy.h
//  QuickJump
//
//  Created by Victor Shamanov on 5/31/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DVTSourceTextViewDelegate;

@interface SourceTextViewDelegateProxy : NSProxy

- (instancetype)initWithDelegate:(NSObject <DVTSourceTextViewDelegate> *)delegate
                originalDelegate:(NSObject <DVTSourceTextViewDelegate> *)originalDelegate;

@end
