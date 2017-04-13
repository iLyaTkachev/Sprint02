//
//  EngineMO+CoreDataProperties.h
//  Sprint01ARC
//
//  Created by iLya Tkachev on 4/13/17.
//  Copyright © 2017 iLya Tkachev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "EngineMO.h"

NS_ASSUME_NONNULL_BEGIN

@interface EngineMO (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *power;

@end

NS_ASSUME_NONNULL_END
