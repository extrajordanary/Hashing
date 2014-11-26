//
//  LinkedList.h
//  LinkedLists
//
//  Created by Daniel Haaser on 11/20/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyValueLinkedList : NSObject

/**
 Add an object for the specified key
 */
- (void)addObject:(id)object forKey:(NSString*)key;

/**
 Returns the object for the specified key
 */
- (id)objectForKey:(NSString*)key;

/**
 Removes the object for the specified key
 */
- (void)removeObjectForKey:(NSString*)key;

/**
 Returns the number of element stored in the list
 */
- (NSUInteger)count;

@end
