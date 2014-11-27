//
//  HashTable.m
//  HashTables
//
//  Created by Daniel Haaser on 11/25/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import "HashTable.h"
#import "KeyValueLinkedList.h"

static const unsigned int kBucketCount = 12800;
static const BOOL isChained = NO;

@implementation HashTable {
    NSMutableArray *buckets;
    int entryCount;
    int bucketCount;
    float loadFactor;
}

#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        bucketCount = kBucketCount;
        buckets = [[NSMutableArray alloc] initWithCapacity:bucketCount];
        for(int i = 0; i < bucketCount; i++) {
            if (isChained) {
                buckets[i] = [[KeyValueLinkedList alloc] init]; // chained version
            } else {
                buckets[i] = [NSNull null]; // probed version
            }
        }
    }
    
    return self;
}

#pragma mark - Get and Set and Remove Objects

- (void)setObject:(id)object forKey:(NSString*)key {
    if (isChained) {
        [[self chainedBucketListForKey:key] addObject:object forKey:key];
    } else {
        [self probedSetObject:object forKey:key];
    }
    entryCount++;
    [self updateLoadFactor];
}

- (id)objectForKey:(NSString*)key {
    if (isChained) {
        return [[self chainedBucketListForKey:key] objectForKey:key];
    } else {
        return [self probedGetObjectForKey:key];
    }
}

- (void)removeObjectForKey:(NSString*)key {
    if (isChained) {
    [[self chainedBucketListForKey:key] removeObjectForKey:key];
    } else {
        [self probedRemoveObjectForKey:key];
    }
    entryCount--;
    [self updateLoadFactor];
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

-(KeyValueLinkedList*) chainedBucketListForKey:(NSString*)key {
    unsigned int hash = [self hashForString:key];
    unsigned int bucket = hash % bucketCount;
    
    return (KeyValueLinkedList*)buckets[bucket];
}

-(void)updateLoadFactor {
    loadFactor = entryCount / bucketCount;
}

-(void)checkLoadFactor {
    if (loadFactor > 0.8) {
        // expand size of table
        
        // rehash all the things
    }
}
#pragma mark - Probed Versions
-(void) probedSetObject:(id)object forKey:(NSString*)key {
    // get hash and target bucket
    unsigned int hash = [self hashForString:key];
    unsigned int bucket = hash % kBucketCount;
    
    // create list with object to add
    KeyValueLinkedList *linkedList = [[KeyValueLinkedList alloc] init];
    [linkedList addObject:object forKey:key];

    if (buckets[bucket]==[NSNull null]) {
        // if yes, add list with object
        buckets[bucket] = linkedList;
        return;
    }
    // else iterate through buckets til finds an empty one
    unsigned int i = (bucket+1) % (kBucketCount-1);
    // until wrapping all the way around to start again
    while (i != bucket) {
        if (buckets[i]==[NSNull null]) {
            // if yes, add list with object
            buckets[i] = linkedList;
            return;
        }
        // if i > kBucketCount wrap back around to 0
        i = (i+1) % (kBucketCount-1);
    }
    NSLog(@"no empty bucket found");
}

-(id) probedGetObjectForKey:(NSString*)key {
    // get hash and target bucket
    unsigned int hash = [self hashForString:key];
    unsigned int bucket = hash % bucketCount;
    
    id object;
    if ([buckets[bucket] isKindOfClass:[KeyValueLinkedList class]]) {
        // if bucket has a list, check for correct key
        object = [(KeyValueLinkedList*)buckets[bucket] objectForKey:key];
        if (object) {
            return object;
        }
    } else {
        // target must be nil from being deleted, so return nil
        return nil;
    }

    // else iterate through buckets til finds an empty one
    unsigned int i = (bucket+1) % (bucketCount-1);
    // until wrapping all the way around to start again
    while (i != bucket) {
        if ([buckets[i] isKindOfClass:[KeyValueLinkedList class]]) {
            // if yes, add list with object
            object = [(KeyValueLinkedList*)buckets[i] objectForKey:key];
            if (object) {
                return object;
            }
        } else {
            // target must be nil from being deleted, so return nil
            return nil;
        }
        // if i > kBucketCount wrap back around to 0
        i = (i+1) % (bucketCount-1);
    }
//    NSLog(@"object not found");
    return nil;
}

-(void) probedRemoveObjectForKey:(NSString*)key {
    // get hash and target bucket
    unsigned int hash = [self hashForString:key];
    unsigned int bucket = hash % bucketCount;
    
    id object;
    if ([buckets[bucket] isKindOfClass:[KeyValueLinkedList class]]) {
        // if bucket has a list, check for correct key
        object = [(KeyValueLinkedList*)buckets[bucket] objectForKey:key];
        if (object) {
            buckets[bucket] = [NSNull null];
//            [(KeyValueLinkedList*)buckets[bucket] removeObjectForKey:key];
            return;
        }
    }
    
    // else iterate through buckets til finds an empty one
    unsigned int i = (bucket+1) % (bucketCount-1);
    // until wrapping all the way around to start again
    while (i != bucket) {
        if ([buckets[i] isKindOfClass:[KeyValueLinkedList class]]) {
            // if yes, add list with object
            object = [(KeyValueLinkedList*)buckets[i] objectForKey:key];
            if (object) {
                buckets[bucket] = [NSNull null];
                return;
            }
        }
        // if i > kBucketCount wrap back around to 0
        i = (i+1) % (bucketCount-1);
    }
    NSLog(@"object to remove not found");
}

@end
