# Cinder-AppNap
`Cinder-AppNap` is a [CinderBlock](http://libcinder.org/) to access the Activity APIs introduced in OS X 10.9.

OS X 10.9 uses heuristics to improve system battery life, performance and responsiveness and governs the resources made available to applications and their behavior to achieve this. At times the system behavior isn't desirable and `Cinder-AppNap` can be used to hint an exceptional need. Doing so can obviously negatively affect the battery life, performance and responsiveness of the system as a whole, so one should *be critical of its use and disciplined in minimizing its use to a narrow scope*.

While the CinderBlock is (perhaps poorly) named `Cinder-AppNap`, an application can provide hints that affect other behaviors like timer coalescing and the application termination. `Cinder-AppNap` currently disables idle system sleep and sudden termination which is hopefully a fit for most Cinder application needs, but could certainly be made more flexible should the need arise.

### EXAMPLE
```C++
void VisionApp::setup() {
    Cinder::AppNap::PerformActivity("Preprocess images", [this](void) {
        auto handle = std::async([this](void) {
            preprocessImages();
        });
        handle.wait();
    });
}
```

Long-running operations can use a more explicit form:
```C++
void CaptureApp::setup() {
    Cinder::AppNap::BeginActivity("Maintain camera control");
}

void CaptureApp::shutdown() {
    Cinder::AppNap::EndActivity();
}
```

#### NOTE

System power assertions can be verified with the `pmset` command line tool:
```sh
$ pmset -g assertions
```
