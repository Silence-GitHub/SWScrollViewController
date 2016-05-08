# SWScrollViewController

A container view controller with scroll view. It changes content view controller with scroll view or programmatically.

## Major features

### Select content view controller with title button

![](README_resources/Select_content_view_controller_with_title_button.gif "Select_content_view_controller_with_title_button")

![](README_resources/Select_content_view_controller_with_title_button_2.gif "Select_content_view_controller_with_title_button_2")

### Select content view controller with panning gesture

![](README_resources/Select_content_view_controller_with_panning_gesture.gif "Select_content_view_controller_with_panning_gesture")

### Select content view controller programmatically

![](README_resources/Select_content_view_controller_programmatically.gif "Select_content_view_controller_programmatically")

![](README_resources/Select_content_view_controller_programmatically_2.gif "Select_content_view_controller_programmatically_2")

### Set content view controllers

![](README_resources/Set_content_view_controllers.gif "Set_content_view_controllers")

### Hide or show titles

![](README_resources/Hide_or_show_titles.gif "Hide_or_show_titles")



## How to use

### Install
```
#import "SWScrollViewController.h"
```


### Initialize

```
SWScrollViewController *scrollVC = [[SWScrollViewController alloc] initWithControllers:@[controller, controller2]];
```
    
    
### Change child view controllers

```
scrollVC.viewControllers = @[controller, controller2, controller3];
```
    
### Get title scroll view displaying title buttons and mark line

```
UIScrollView *titleScrollView = scrollVC.titleScrollView;
// Do something to the title scroll view
```
    
### Hide or show titles

It will change content view frame, not just set hidden property of title scroll view

```
// Hide titles
[scrollVC hideTitleScrollView:YES];
// Show titles
[scrollVC hideTitleScrollView:NO];
```
    
### Get content scroll view displaying views of child view controllers

```
UIScrollView *contentScrollView = scrollVC.contentScrollView;
// Do something to the content scroll view
```
    
### Get content view controller whose view is in visible rect

```
UIViewController *contentVC = scrollVC.contentViewController;
```
    
### Get content view which is the view of the selected child view controller

```
UIView *contentView = scrollVC.contentView;
```
    
### Get selected index indicating the selected child view controller (content view controller)

```
NSUInteger selectedIndex = scrollVC.selectedIndex;
```
 
### Set selected index to change content view controller

```
scrollVC.selectedIndex = anIndex;
```
 
### Get scroll view controller of child view controller

```
SWScrollViewController *scrollVC = controller.scrollViewController;
```
