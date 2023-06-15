//
//  ProtocolMatcher.m
//  qanda
//
//  Created by Andrew on 02/06/2023.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <malloc/malloc.h>

#import "ProtocolMatcher.h"

@interface ProtocolMatcher()
@property (nonatomic, copy) NSMutableArray<Class> *children;
@end


@implementation ProtocolMatcher : NSObject
///
/// - getClasses(:Protocol)
/// - Description: Returns a list of all registered classes conforming to a supplied protocol.
/// - Parameter swiftProtocol: A protocol to match against. If declared in swift, the protocol must be marked with @objc e.g.:
/// ```swift
/// @objc
/// Protocol Foo { }
/// ```
/// - Returns [Class.Type]:   An array of class types that are registered in the build, that conform to the supplied protocol
-(NSMutableArray<Class> *) getClassesFor:(Protocol *)yourProtocol {

   /// Declare an array of class types that will hold all matching classes conforming to  swiftProtocol
   NSMutableArray<Class> *children = [NSMutableArray<Class> new];

   /// Get the number of all classes registered in this build (it will be a big number!)
   int numberOfClasses = objc_getClassList(NULL, 0);
   // NSLog([NSString stringWithFormat:@"Number of all registered classes: %d",numberOfClasses]);

   /// Create a buffer with enough free space to hold the entire array of all registered classes, and retrieve the specified number of classes into the buffer
   Class *classList = (Class *)malloc( sizeof(Class) * numberOfClasses ) ;
   objc_getClassList(classList, numberOfClasses);

   ///for each class retrieved, check if it conforms to the required protocol, and if so,
   ///add it to a children array (which will be returned)
   for (int idx = 0; idx < numberOfClasses; idx++) {
      Class class = classList[idx];
      if ((class_getClassMethod(class, @selector(conformsToProtocol:))) &&
          (class_conformsToProtocol(class, yourProtocol)) ) {
//         NSLog([NSString stringWithFormat:@"Matching class: %@",class]);
         [children addObject:class ];
      }
   }
   free(classList); ///remove buffer from memory and return space to system
   return children;
}
@end
