# PerformanceTest

This test shows a performance problem with PointFree architecture: just using the global reducer increases the CPU load from 10 to 40% in my testing.

The setup: a draggable view on top of a relatively complex view. There are no dependencies between these views, and each view can use its own reducer, but combining them into a global reducer causes significant increase in the CPU load. An actual app with a more complex view hierarchy is likely to have an even higher overhead.

The problem is that the global reducer forces rebuilding of the complex view on each drag (which is due to updating the store at the root level).

To see the problem go away, replace ContentViewGlobal with ContentViewLocal in SceneDelegate.swift (ContentViewLocal has but doesn't use the global store.)
