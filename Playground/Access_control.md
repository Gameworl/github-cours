# Access_control

```swift
import UIKit

// Access control

// SCREEN ACCESS CONTROL

public class SomePublicClass {}
open class SomeOpenClass {}

// SCREEN INTERNAL ACCESS

internal class SomeInternalClass {}

// SCREEN FILE PRIVATE ACCESS

fileprivate class SomeFilePrivateClass {}

// SCREEN PRIVATE ACCESS

private class SomePrivateClass {}

// SCREEN RULES

// SCREEN FUNCTION TYPES

func someFunction1() -> (
    SomeInternalClass,
    SomePrivateClass) {
    // function implementation goes here
}

```