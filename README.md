# SPReddit

This was built and optimized for the iPhone X, so simulating it on the iPhone X will yield the best results. 

## Features

SPReddit loads the top 25 posts from api.reddit and displays their: comments, date, content, author name, and image (if available). If the user scrolls beyond the initial 25 posts, an addition 5 posts will be loaded. In production, it may be desirable to paginate more than 5 posts at a time (an easily configurable parameter), but for the sake of development purposes fewer posts allows the feature to be more easily tested.

## Third-party libraries

[SDWebImage](https://github.com/rs/SDWebImage) was used to download images asynchronously and to cache images so that they were only downloaded one time. SDWebImage also has a convenient way to display placeholder images while the image is being loaded.

[SBJson 5](https://github.com/stig/json-framework) is parsing library which was used to parse the JSON response from api.reddit into Obj-C objects.

[IDMPhotoBrowser](https://github.com/thiagoperes/IDMPhotoBrowser) is a photo browsing library that is responsible for displaying the photo after you click on the table view cell.

[Infinite Scroll](https://github.com/pronebird/UIScrollView-InfiniteScroll) is a library which provides the UI for infinite scrolling (i.e. pagination support).


![Demo GIF](reddit_vid.gif)

