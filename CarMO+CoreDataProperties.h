//
//  CarMO+CoreDataProperties.h
//  Sprint01ARC
//
//  Created by iLya Tkachev on 4/13/17.
//  Copyright © 2017 iLya Tkachev. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CarMO.h"

NS_ASSUME_NONNULL_BEGIN

@interface CarMO (CoreDataProperties)

@property (nullable, nonatomic, retain) id image;
@property (nullable, nonatomic, retain) NSString *mark;
@property (nullable, nonatomic, retain) NSString *model;
@property (nullable, nonatomic, retain) EngineMO *engine;

@end

NS_ASSUME_NONNULL_END
