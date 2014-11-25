//
//  HashTable.m
//  HashTables
//
//  Created by Daniel Haaser on 11/25/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import "HashTable.h"

static const NSInteger kBucketCount = 128;

@implementation HashTable

#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        
    }
    
    return self;
}

#pragma mark - Get and Set Objects



#pragma mark - Utilities
#pragma message "Implement hashForString: !"

- (NSUInteger)hashForString:(NSString*)string
{
    return 0;
}

@end
