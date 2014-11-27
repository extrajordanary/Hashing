//
//  HashTable.h
//  HashTables
//
//  Created by Daniel Haaser on 11/25/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HashTable : NSObject

// -------------------------------------------
//          Implement these Methods!
// -------------------------------------------

/**
 Adds an object to the hash table for the given key
 */
- (void)setObject:(id)object forKey:(NSString*)key;

/**
 Retrieves an object from the hash table for the given key
 */

- (id)objectForKey:(NSString*)key;
- (void)removeObjectForKey:(NSString*)key;

@end
