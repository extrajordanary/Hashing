//
//  main.m
//  HashTables
//
//  Created by Daniel Haaser on 11/25/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "HashTable.h"

extern uint64_t dispatch_benchmark(size_t count, void (^block)(void));

static const NSInteger kPersonCount = 10000;

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        HashTable* hashTable = [[HashTable alloc] init];
        NSMutableArray *persons = [NSMutableArray arrayWithCapacity:kPersonCount];
        
        for (NSInteger i = 0; i < kPersonCount; i++)
        {
            persons[i] = [Person randomPerson];
        }
        
        // Check if setObject:forKey is implemented
        if (! [hashTable respondsToSelector:@selector(setObject:forKey:)])
        {
            NSLog(@"ERROR: You must implement setObject:forKey: in HashTable.m!");
            return 1;
        }
        
        
        // Fill hashtable with people, benchmark the speed
        uint64_t creationTime = dispatch_benchmark(1, ^
        {
            for (NSInteger i = 0; i < kPersonCount; i++)
            {
                Person* person = persons[i];
                NSString* key = [NSString stringWithFormat:@"%@%@%ld", person.lastName, person.firstName, (long)person.age];
                [hashTable setObject:person forKey:key];
            }
        });
        
        NSLog(@"HashTable filled in %llu ms", creationTime / 1000000);

        
        if (! [hashTable respondsToSelector:@selector(objectForKey:)])
        {
            NSLog(@"ERROR: You must implement objectForKey: in HashTable.m!");
            return 1;
        }
        
        // Check the hashtable content, benchmark the speed
        
        __block BOOL retreivalSuccessfull = YES;
        
        uint64_t retrievalTime = dispatch_benchmark(1, ^
        {
            for (NSInteger i = 0; i < kPersonCount; i++)
            {
                Person* person = persons[i];
                NSString* key = [NSString stringWithFormat:@"%@%@%ld", person.lastName, person.firstName, (long)person.age];
                
                Person* retrievedPerson = (Person*) [hashTable objectForKey:key];
                
                if (person != retrievedPerson)
                {
                    NSLog(@"ERROR: Retrieved person doesn't match the expected result!");
                    retreivalSuccessfull = NO;
                    break;
                }
            }
        });
        
        if (retreivalSuccessfull)
        {
            NSLog(@"Successfully retrieved objects from hash table in %llu ms", retrievalTime / 1000000);
        }
        else
        {
            return 1;
        }
        

    }
    
    return 0;
}
