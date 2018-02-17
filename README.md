# SPReddit

## Features

SPReddit loads the top 25 users from api.reddit and displays their: comments, date, content, author name, and image (if available)

## Third-party libraries

[SDWebImage](https://github.com/rs/SDWebImage) was used to download images asynchronously and to cache images so that they were only downloaded one time. SDWebImage also has a convenient way to display placeholder images while the image is being loaded.

[SBJson 5](https://github.com/stig/json-framework) is parsing library which was used to parse the JSON response from api.reddit into Obj-C objects. 


![Alt text](screenshot1.png)

