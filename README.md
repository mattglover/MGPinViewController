MGPinViewController
====================

A UIViewController subclass that provides a PIN view presentation.

Typical usage is presenting the ViewController within a UINavigationController

```objc
#import "MGPinViewController.h"
```

```objc
- (void)showPinViewController {
  
  MGPinViewController *pinViewController = [[MGPinViewController alloc] initWithValidPin:@"1234"];
  
  UINavigationController *pinNavigationController = [[UINavigationController alloc] initWithRootViewController:pinViewController];
  [self presentModalViewController:pinNavigationController animated:NO];
}
```
