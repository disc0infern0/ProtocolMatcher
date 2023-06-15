
#  Protocol Matcher

## getClassesFor(_:)
#### List all class types found by the compiler to conform to a specified protocol.
```swift
func getClassesFor(_ yourprotocol: Protocol) -> [any AnyObject.Type]
```
**Parameter**: Protocol

**Returns**: [any AnyObject.Type]
### Description
Returns a list of classes compiled into the build of your app that conform to a specified Protocol. 
This can be very useful if you provide a protocol in your app/package, along with a way to interact with any classes that implement your protocol. 
You might for example develop a super snazzy way to view fractals, and provide a Fractal protocol for anyone to describe their own.
Without needing to modifiy any of your code, another developer can implement the Fractal protocol, and your code can detect the class, and add it to a pick list for viewing. 

If invoked from Swift, to correctly identify the intended protocol, ```self``` must be added to the protocol name in the invocation. The protocol ```Foo``` for example, must be passed as ```Foo.self```. \
e.g.
```swift
let matchingClassTypes = ProtocolMatcher().getClassesFor(Foo.self)
```
In addition, the Swift protocol definition must be marked with @objc in order for this function to recognise the protocol. e.g. 
```swift 
@objc Foo { }
```

If intending to operate on the return values, the results should be recast to the specific type. Using the example above, this would be; 
```swift 
let matchingClassTypes = ProtocolMatcher().getClassesFor(Foo.self) as! [any Foo.Type]
```

Adding a friendlier Swift wrapper around this function is unfortunately not possible in a Swift package, which, at time of writing, does not support mixed languages.

Note that this differs from the Swift Mirror method, which can only return classes which have been instantiated, whereas this method will return all classes which conform to a given protocol, regardless of whether instantiated or not. 
 

### Note
In order to instantiate a returned class, then the protocol must require an init method.
See the example below for more details. 



 
 ## Fully worked example 
Suppose we have a project called Secrets, containing the following code:-
 ```swift
import ProtocolMatcher

// Define a protocol to test for
@objc protocol Food { init(); var secret: String {get} }

// and two conforming class definitions:
final class Baah : Food { init() {}; let secret = "applesauce" }
final class HumBug: Food { init() {}; let secret = "ketchup" }

final class FoodMatch {

   static func getFoodSecrets()  {
      let classesConforming = ProtocolMatcher().getClassesFor(Food.self) as! [any Food.Type]

      for classType in classesConforming {
         let className = "\(classType)"
         let classObject = classType.init()
         let secret = classObject.secret
         print("Found \(className) .. with a secret of \(secret)")
      }

   }
}

 ```
 
Invoking FoodMatch.getFoodSecrets()  will print 
```
> Found Baah .. with a secret of applesauce
> Found HumBug .. with a secret of ketchup
```


https://github.com/disc0infern0/ProtocolMatcher
Copyright 2023 Andrew Cowley
