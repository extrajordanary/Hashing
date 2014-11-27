//
//  HashTable.m
//  HashTables
//
//  Created by Daniel Haaser on 11/25/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import "HashTable.h"
#import "KeyValueLinkedList.h"

static const unsigned int kBucketCount = 128;

@implementation HashTable {
    NSMutableArray *buckets;
}

#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        buckets = [[NSMutableArray alloc] initWithCapacity:kBucketCount];
        for(int i = 0; i < kBucketCount; i++) {
            buckets[i] = [[KeyValueLinkedList alloc] init];
        }
    }
    
    return self;
}

#pragma mark - Get and Set and Remove Objects

- (void)setObject:(id)object forKey:(NSString*)key {
//    unsigned int hash = [self hashForString:key];
//    unsigned int bucket = hash % kBucketCount;
//    NSLog(@"\nHASH: %lu \nBUCKET: %lu", (unsigned long)hash, (unsigned long)bucket);

//    KeyValueLinkedList *linkedList = [self bucketListForKey:key];
    
    [[self bucketListForKey:key] addObject:object forKey:key];
}

- (id)objectForKey:(NSString*)key {
//    unsigned int hash = [self hashForString:key];
//    unsigned int bucket = hash % kBucketCount;
//    KeyValueLinkedList *linkedList = buckets[bucket];
    return [[self bucketListForKey:key] objectForKey:key];
 }

- (void)removeObjectForKey:(NSString*)key {
    [[self bucketListForKey:key] removeObjectForKey:key];
}


#pragma mark - Utilities

- (unsigned int)hashForString:(NSString*)string
{
    unsigned int len = (unsigned int)[string length];
    unichar buffer[len+1];
    [string getCharacters:buffer range:NSMakeRange(0, len)];
    
    unsigned int hash = 5381;

    for(int i = 0; i < len; i++) {
        int charValue = buffer[i];
        
        hash = hash * 33 + charValue;
    }
    return hash;
}

-(KeyValueLinkedList*) bucketListForKey:(NSString*)key {
    unsigned int hash = [self hashForString:key];
    unsigned int bucket = hash % kBucketCount;
    return (KeyValueLinkedList*)buckets[bucket];
}

@end
