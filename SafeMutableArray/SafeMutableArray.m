//
//  SafeMutableArray.m
//  
//
//  Created by 周刚涛 on 2018/12/30.
//  Copyright © 2018年 xyz. All rights reserved.
//

#import "SafeMutableArray.h"

@interface SafeMutableArray()

@property (nonatomic) CFMutableArrayRef array;
@property (nonatomic, strong) dispatch_queue_t syncQueue;

@end

@implementation SafeMutableArray

- (instancetype)init {
    return [self initWithCapacity:10];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [self initWithCapacity:10];
}

- (instancetype)initWithCapacity:(NSUInteger)numItems {
    self = [super init];
    if (self) {
        _array = CFArrayCreateMutable(kCFAllocatorDefault, numItems,  &kCFTypeArrayCallBacks);
    }
    return self;
}

// 获取可变数组数量
- (NSUInteger)count {
    __block NSUInteger result;
    dispatch_sync(self.syncQueue, ^{
        result = CFArrayGetCount(self.array);
    });
    return result;
}

// 获取第N个位置的对象
- (id)objectAtIndex:(NSUInteger)index {
    __block id result;
    dispatch_sync(self.syncQueue, ^{
        NSUInteger count = CFArrayGetCount(self.array);
        result = index<count ? CFArrayGetValueAtIndex(self.array, index) : nil;
    });
    
    return result;
}

// 插入对象至指定位置
- (void)insertObject:(id)anObject atIndex:(NSUInteger)index {
    __block NSUInteger blockIndex = index;
    dispatch_barrier_async(self.syncQueue, ^{
        if (!anObject)
        return;
        
        NSUInteger count = CFArrayGetCount(self.array);
        blockIndex = blockIndex > count ? count : blockIndex;
        CFArrayInsertValueAtIndex(self.array, blockIndex, (__bridge const void *)anObject);
    });
}

// 删除指定位置上的对象
- (void)removeObjectAtIndex:(NSUInteger)index {
    dispatch_barrier_async(self.syncQueue, ^{
        NSUInteger count = CFArrayGetCount(self.array);
        if (index < count) {
            CFArrayRemoveValueAtIndex(self.array, index);
        }
    });
}

// 添加对象
- (void)addObject:(id)anObject {
    dispatch_barrier_async(self.syncQueue, ^{
        if (!anObject) {
            return;
        }
        
        CFArrayAppendValue(self.array, (__bridge const void *)anObject);
    });
}

// 删除最后一个对象
- (void)removeLastObject {
    dispatch_barrier_async(self.syncQueue, ^{
        NSUInteger count = CFArrayGetCount(self.array);
        if (count > 0) {
            CFArrayRemoveValueAtIndex(self.array, count-1);
        }
    });
}

// 替换指定位置的对象
- (void)replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    dispatch_barrier_async(self.syncQueue, ^{
        if (!anObject) {
            return;
        }
        
        NSUInteger count = CFArrayGetCount(self.array);
        if (index >= count) {
            return;
        }
        CFArraySetValueAtIndex(self.array, index, (__bridge const void*)anObject);
    });
}

#pragma mark Optional
// 移除所有对象
- (void)removeAllObjects {
    dispatch_barrier_async(self.syncQueue, ^{
        CFArrayRemoveAllValues(self.array);
    });
}

// 获取某一个对象的索引位置
- (NSUInteger)indexOfObject:(id)anObject {
    if (!anObject) {
        return NSNotFound;
    }
    
    __block NSUInteger result;
    dispatch_sync(self.syncQueue, ^{
        NSUInteger count = CFArrayGetCount(self.array);
        result = CFArrayGetFirstIndexOfValue(self.array, CFRangeMake(0, count), (__bridge const void *)(anObject));
    });
    return result;
}
#pragma mark - Private
- (dispatch_queue_t)syncQueue {
    if (!_syncQueue) {
        _syncQueue = dispatch_queue_create("com.xyz
        .SafeMutableArray", DISPATCH_QUEUE_CONCURRENT);
    }
    return _syncQueue;
}

- (void)dealloc {
    CFRelease(_array);
    if (_syncQueue) {
        _syncQueue = NULL;
    }
}
@end
