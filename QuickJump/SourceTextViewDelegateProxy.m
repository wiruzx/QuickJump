//
//  SourceTextViewDelegateProxy.m
//  QuickJump
//
//  Created by Victor Shamanov on 5/31/15.
//  Copyright (c) 2015 Victor Shamanov. All rights reserved.
//

#import "SourceTextViewDelegateProxy.h"

@interface SourceTextViewDelegateProxy ()

@property (nonatomic, weak) NSObject <DVTSourceTextViewDelegate> *delegate;
@property (nonatomic, weak) NSObject <DVTSourceTextViewDelegate> *originalDelegate;

@end

@implementation SourceTextViewDelegateProxy

#pragma mark - Instantiation

- (instancetype)initWithDelegate:(NSObject <DVTSourceTextViewDelegate>*)delegate originalDelegate:(NSObject <DVTSourceTextViewDelegate>*)originalDelegate {
    
    self.delegate = delegate;
    self.originalDelegate = originalDelegate;
    
    return self;
}

#pragma mark - NSProxy methods

- (void)forwardInvocation:(NSInvocation *)invocation {
    if ([self.delegate respondsToSelector:invocation.selector]) {
        [invocation invokeWithTarget:self.delegate];
    } else {
        [invocation invokeWithTarget:self.originalDelegate];
    }
}

@end
