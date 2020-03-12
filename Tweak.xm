#import <Cephei/HBPreferences.h>
#import "Tweak.h"

HBPreferences *preferences;
BOOL enabled;
BOOL enableTimerInactive;
BOOL enablePanGestureInactive;
BOOL enableTapGestureInactive;
double chevronOpacity;
double reachOffset;
double cornerRadius;

%hook SBReachabilityBackgroundView

// Sets the opacity of the chevron grabber
- (void)setChevronAlpha:(double)arg1 {
    if (enabled) {
    arg1 = chevronOpacity;
    %orig;
}
%orig;
}

// Sets the corner radius of the SpringBoard view
-(double)_displayCornerRadius {
if (enabled) {
return cornerRadius;
}
return %orig;
}

%end


%hook SBReachabilitySettings

// Sets the vertical offset
- (void)setYOffsetFactor:(double)arg1 {
    if (enabled) {
    arg1 = reachOffset;
    %orig;
}
%orig;
}

// Support for other devices
- (bool)allowOnAllDevices {
    if (enabled) {
    return 1;
}
return nil;
}

// Support for other devices
- (void)setAllowOnAllDevices:(bool)arg1 {
    if (enabled) {
    arg1 = 1;
    %orig;
}
%orig;
}

%end


%hook SBReachabilityManager

// Disables the Pan gesture
-(void)_panToDeactivateReachability:(id)arg1 {
if (enabled && enablePanGestureInactive) {
}
else {%orig;}
}

// Disables the Tap gesture
- (void)_tapToDeactivateReachability:(id)arg1 {
if (enabled && enableTapGestureInactive) {
}
else {%orig;}
}

// Disables auto timeout
- (void)_setKeepAliveTimer {
    if (enabled && enableTimerInactive) {
    }
    else {%orig;}
}

// Support for other devices
+ (bool)reachabilitySupported {
    if (enabled) {
    return 1;
}
return %orig;
}

// Support for other devices
- (bool)reachabilityEnabled {
    if (enabled) {
    return 1;
}
return %orig;
}

// Support for other devices
- (void)setReachabilityEnabled:(bool)arg1 {
    arg1 = 1;
    %orig;
}

%end


%hook SBSearchViewController

// Support for other devices
- (bool)reachabilitySupported {
    if (enabled) {
    return 1;
}
return %orig;
}
%end


%hook SBAppSwitcherController

// Support for other devices
- (bool)_shouldRespondToReachability {
    if (enabled) {
    return 1;
}
return %orig;
}
%end


%hook SBIconController

// Support for other devices
- (bool)_shouldRespondToReachability {
    if (enabled) {
    return 1;
}
return %orig;
}
%end


%hook SBApplication

// Support for other devices
- (bool)isReachabilitySupported {
    if (enabled) {
    return 1;
}
return %orig;
}
%end


%hook SpringBoard

// Support for other devices
- (void)_setReachabilitySupported:(bool)arg1 {
    if (enabled) {
    arg1 = 1;
    %orig;
}
%orig;
}
%end


%hook SBApplication

// Support for other devices
- (void)setReachabilitySupported:(bool)arg1 {
    if (enabled) {
    arg1 = 1;
    %orig;
}
%orig;
}
%end



%ctor {

    preferences = [[HBPreferences alloc] initWithIdentifier:@"com.nahtedetihw.ability"];

    [preferences registerBool:&enabled default:NO forKey:@"enabled"];
    [preferences registerBool:&enableTimerInactive default:NO forKey:@"enableTimerInactive"];
    [preferences registerBool:&enablePanGestureInactive default:NO forKey:@"enablePanGestureInactive"];
    [preferences registerBool:&enableTapGestureInactive default:NO forKey:@"enableTapGestureInactive"];
    [preferences registerDouble:&chevronOpacity default:1.0 forKey:@"chevronOpacity"];
    [preferences registerDouble:&reachOffset default:0.40 forKey:@"reachOffset"];
    [preferences registerDouble:&cornerRadius default:40 forKey:@"cornerRadius"];
}
