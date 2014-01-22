# Cinder-AppNap
`Cinder-AppNap` is a [CinderBlock](http://libcinder.org/) to access the Activity APIs introduced in OS X 10.9 that tie into [App Nap](http://www.apple.com/osx/advanced-technologies/).

### EXAMPLE
```C++
void VisionApp::setup() {
    PerformActivity("Preprocess images", [this](void) {
        auto handle = std::async([this](void) {
            preprocessImages();
        });
        handle.wait();
    });
}
```

Longer-running operations can use a more explicit form
```C++
void CaptureApp::setup() {
    mActivity = Activity::create("OSC I/O and maintain camera control");
    mActivity->begin();
}

void CaptureApp::shutdown() {
    mActivity->end();
}
```
